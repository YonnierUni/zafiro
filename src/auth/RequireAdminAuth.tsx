import { Navigate, Outlet, useLocation } from 'react-router-dom';
import { useSupabaseAuth } from './SupabaseAuthProvider';

export function RequireAdminAuth() {
  const location = useLocation();
  const { authError, authReady, isAuthenticated, isAuthorized, isConfigured } = useSupabaseAuth();

  if (!isConfigured) {
    return (
      <AuthStateScreen
        title="Admin no disponible"
        description="Este entorno no tiene Supabase configurado. Define VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY para habilitar el acceso protegido al admin."
      />
    );
  }

  if (!authReady) {
    return <AuthStateScreen title="Validando acceso" description="Estamos comprobando tu sesion y permisos para entrar al admin." />;
  }

  if (!isAuthenticated) {
    return <Navigate to="/admin/login" replace state={{ from: location.pathname + location.search }} />;
  }

  if (!isAuthorized) {
    return <Navigate to="/admin/login" replace state={{ from: location.pathname + location.search, denied: authError ?? true }} />;
  }

  return <Outlet />;
}

function AuthStateScreen({ description, title }: { description: string; title: string }) {
  return (
    <div className="min-h-screen bg-obsidian px-5 py-16 text-ivory sm:px-6 lg:px-8">
      <div className="mx-auto max-w-2xl rounded-[2rem] border border-white/10 bg-white/[0.03] p-8 shadow-[0_24px_60px_rgba(0,0,0,0.3)]">
        <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Acceso admin</p>
        <h1 className="mt-4 font-display text-[2.4rem] leading-none text-ivory">{title}</h1>
        <p className="mt-5 text-base leading-8 text-mist">{description}</p>
      </div>
    </div>
  );
}
