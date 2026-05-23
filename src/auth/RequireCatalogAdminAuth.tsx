import { Navigate, Outlet, useLocation } from 'react-router-dom';
import { useSupabaseAuth } from './SupabaseAuthProvider';

export function RequireCatalogAdminAuth() {
  const location = useLocation();
  const { authReady, canAccessCatalog, isAuthenticated, isConfigured } = useSupabaseAuth();

  if (!isConfigured) {
    return <Navigate to="/admin/login" replace state={{ from: location.pathname + location.search }} />;
  }

  if (!authReady) {
    return null;
  }

  if (!isAuthenticated || !canAccessCatalog) {
    return (
      <Navigate
        to="/admin/login"
        replace
        state={{
          from: location.pathname + location.search,
          denied: 'Esta cuenta puede entrar al backoffice, pero no tiene permisos para editar el catalogo.',
        }}
      />
    );
  }

  return <Outlet />;
}
