import type { PropsWithChildren } from 'react';
import { createContext, useContext, useEffect, useMemo, useState } from 'react';
import type { Session, User } from '@supabase/supabase-js';
import { getSupabaseClient, isSupabaseConfigured } from '../integrations/supabase/client';
import type { StaffProfile, StaffRole } from '../shared/operations/operations.types';

interface SupabaseAuthContextValue {
  authError: string | null;
  authReady: boolean;
  canAccessCatalog: boolean;
  canAccessPos: boolean;
  hasRole: (role: StaffRole) => boolean;
  isAuthenticated: boolean;
  isAuthorized: boolean;
  isCatalogAdmin: boolean;
  isConfigured: boolean;
  isPosStaff: boolean;
  session: Session | null;
  signInWithPassword: (email: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
  staffProfile: StaffProfile | null;
  staffRoles: StaffRole[];
  user: User | null;
}

const SupabaseAuthContext = createContext<SupabaseAuthContextValue | null>(null);

export function SupabaseAuthProvider({ children }: PropsWithChildren) {
  const [session, setSession] = useState<Session | null>(null);
  const [user, setUser] = useState<User | null>(null);
  const [isAuthorized, setIsAuthorized] = useState(false);
  const [isCatalogAdmin, setIsCatalogAdmin] = useState(false);
  const [staffProfile, setStaffProfile] = useState<StaffProfile | null>(null);
  const [staffRoles, setStaffRoles] = useState<StaffRole[]>([]);
  const [authReady, setAuthReady] = useState(false);
  const [authError, setAuthError] = useState<string | null>(null);
  const isConfigured = isSupabaseConfigured();

  useEffect(() => {
    if (!isConfigured) {
      setAuthReady(true);
      setSession(null);
      setUser(null);
      setIsAuthorized(false);
      setIsCatalogAdmin(false);
      setStaffProfile(null);
      setStaffRoles([]);
      setAuthError(null);
      return;
    }

    const supabase = getSupabaseClient();
    let isMounted = true;

    const resolveAuthorization = async (nextUser: User | null) => {
      if (!nextUser) {
        if (isMounted) {
          setIsAuthorized(false);
          setIsCatalogAdmin(false);
          setStaffProfile(null);
          setStaffRoles([]);
          setAuthError(null);
        }
        return;
      }

      const normalizedEmail = nextUser.email?.trim().toLowerCase();
      const emptyProfileResult = Promise.resolve({ data: null, error: null });
      const emptyRolesResult = Promise.resolve({ data: [] as { role: StaffRole }[], error: null });
      const [{ data: catalogAdmin, error: adminError }, { data: profile, error: profileError }, { data: roles, error: rolesError }] =
        await Promise.all([
          supabase.rpc('is_catalog_admin'),
          normalizedEmail
            ? supabase.from('staff_profiles').select('*').eq('email', normalizedEmail).maybeSingle()
            : emptyProfileResult,
          normalizedEmail
            ? supabase.from('staff_role_assignments').select('role').eq('email', normalizedEmail)
            : emptyRolesResult,
        ]);

      if (!isMounted) {
        return;
      }

      if (adminError || profileError || rolesError) {
        setIsAuthorized(false);
        setIsCatalogAdmin(false);
        setStaffProfile(null);
        setStaffRoles([]);
        setAuthError(
          `No fue posible validar permisos operativos: ${adminError?.message ?? profileError?.message ?? rolesError?.message}`,
        );
        return;
      }

      const nextRoles = Array.from(
        new Set<StaffRole>([
          ...(catalogAdmin ? (['superadmin'] as StaffRole[]) : []),
          ...(roles ?? []).map((entry) => entry.role as StaffRole),
        ]),
      );
      const nextProfile: StaffProfile | null =
        profile || normalizedEmail
          ? {
              email: profile?.email ?? normalizedEmail ?? '',
              fullName: profile?.full_name ?? normalizedEmail ?? 'Operador',
              isActive: profile?.is_active ?? true,
              roles: nextRoles,
            }
          : null;
      const nextAuthorized = Boolean(catalogAdmin) || nextRoles.length > 0;

      setIsCatalogAdmin(Boolean(catalogAdmin));
      setStaffProfile(nextProfile);
      setStaffRoles(nextRoles);
      setIsAuthorized(nextAuthorized);
      setAuthError(nextAuthorized ? null : 'Tu cuenta no tiene permisos para operar el backoffice de ZAFIRO.');
    };

    supabase.auth
      .getSession()
      .then(async ({ data, error }) => {
        if (!isMounted) {
          return;
        }

        if (error) {
          setAuthError(error.message);
        }

        setSession(data.session ?? null);
        setUser(data.session?.user ?? null);
        await resolveAuthorization(data.session?.user ?? null);
      })
      .finally(() => {
        if (isMounted) {
          setAuthReady(true);
        }
      });

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, nextSession) => {
      setSession(nextSession ?? null);
      setUser(nextSession?.user ?? null);
      void resolveAuthorization(nextSession?.user ?? null).finally(() => {
        if (isMounted) {
          setAuthReady(true);
        }
      });
    });

    return () => {
      isMounted = false;
      subscription.unsubscribe();
    };
  }, [isConfigured]);

  const value = useMemo<SupabaseAuthContextValue>(
    () => ({
      authError,
      authReady,
      canAccessCatalog: isCatalogAdmin,
      canAccessPos: isAuthorized,
      hasRole: (role) => staffRoles.includes(role),
      isAuthenticated: Boolean(session?.user),
      isAuthorized,
      isCatalogAdmin,
      isConfigured,
      isPosStaff: isAuthorized,
      session,
      signInWithPassword: async (email, password) => {
        if (!isConfigured) {
          return { error: 'Supabase no esta configurado en este entorno.' };
        }

        const supabase = getSupabaseClient();
        const { error } = await supabase.auth.signInWithPassword({ email, password });

        return {
          error: error?.message ?? null,
        };
      },
      signOut: async () => {
        if (!isConfigured) {
          return;
        }

        const supabase = getSupabaseClient();
        await supabase.auth.signOut();
      },
      staffProfile,
      staffRoles,
      user,
    }),
    [authError, authReady, isAuthorized, isCatalogAdmin, isConfigured, session, staffProfile, staffRoles, user],
  );

  return <SupabaseAuthContext.Provider value={value}>{children}</SupabaseAuthContext.Provider>;
}

export function useSupabaseAuth() {
  const context = useContext(SupabaseAuthContext);

  if (!context) {
    throw new Error('useSupabaseAuth debe usarse dentro de SupabaseAuthProvider.');
  }

  return context;
}
