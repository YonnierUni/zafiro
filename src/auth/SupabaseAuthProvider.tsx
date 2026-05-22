import type { PropsWithChildren } from 'react';
import { createContext, useContext, useEffect, useMemo, useState } from 'react';
import type { Session, User } from '@supabase/supabase-js';
import { getSupabaseClient, isSupabaseConfigured } from '../integrations/supabase/client';

interface SupabaseAuthContextValue {
  authError: string | null;
  authReady: boolean;
  isAuthenticated: boolean;
  isAuthorized: boolean;
  isConfigured: boolean;
  session: Session | null;
  signInWithPassword: (email: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
  user: User | null;
}

const SupabaseAuthContext = createContext<SupabaseAuthContextValue | null>(null);

export function SupabaseAuthProvider({ children }: PropsWithChildren) {
  const [session, setSession] = useState<Session | null>(null);
  const [user, setUser] = useState<User | null>(null);
  const [isAuthorized, setIsAuthorized] = useState(false);
  const [authReady, setAuthReady] = useState(false);
  const [authError, setAuthError] = useState<string | null>(null);
  const isConfigured = isSupabaseConfigured();

  useEffect(() => {
    if (!isConfigured) {
      setAuthReady(true);
      setSession(null);
      setUser(null);
      setIsAuthorized(false);
      setAuthError(null);
      return;
    }

    const supabase = getSupabaseClient();
    let isMounted = true;

    const resolveAuthorization = async (nextUser: User | null) => {
      if (!nextUser) {
        if (isMounted) {
          setIsAuthorized(false);
          setAuthError(null);
        }
        return;
      }

      const { data, error } = await supabase.rpc('is_catalog_admin');

      if (!isMounted) {
        return;
      }

      if (error) {
        setIsAuthorized(false);
        setAuthError(`No fue posible validar permisos admin: ${error.message}`);
        return;
      }

      setIsAuthorized(Boolean(data));
      setAuthError(Boolean(data) ? null : 'Tu cuenta no esta autorizada para operar el admin del catalogo.');
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
      isAuthenticated: Boolean(session?.user),
      isAuthorized,
      isConfigured,
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
      user,
    }),
    [authError, authReady, isAuthorized, isConfigured, session, user],
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
