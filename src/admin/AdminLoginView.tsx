import type { FormEvent } from 'react';
import { useEffect, useState } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import zafiroLogoWhite from '../assets/zafiro-logo-white.png';
import { useSupabaseAuth } from '../auth/SupabaseAuthProvider';

interface LoginLocationState {
  denied?: string | boolean;
  from?: string;
}

export function AdminLoginView() {
  const navigate = useNavigate();
  const location = useLocation();
  const { authError, authReady, isAuthenticated, isAuthorized, isConfigured, signInWithPassword, signOut, user } = useSupabaseAuth();
  const state = (location.state ?? {}) as LoginLocationState;
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [submitError, setSubmitError] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const redirectTo = state.from ?? '/admin';

  useEffect(() => {
    if (authReady && isAuthenticated && isAuthorized) {
      navigate(redirectTo, { replace: true });
    }
  }, [authReady, isAuthenticated, isAuthorized, navigate, redirectTo]);

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSubmitError(null);
    setIsSubmitting(true);

    const result = await signInWithPassword(email.trim(), password);

    setIsSubmitting(false);

    if (result.error) {
      setSubmitError(result.error);
    }
  };

  return (
    <div className="min-h-screen bg-obsidian text-ivory">
      <div className="mx-auto flex min-h-screen w-full max-w-7xl items-center px-5 py-12 sm:px-6 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
        <div className="grid w-full gap-8 xl:grid-cols-[minmax(0,1.02fr)_minmax(22rem,0.98fr)] xl:items-center">
          <section className="max-w-3xl">
            <p className="text-[0.72rem] uppercase tracking-[0.28em] text-cyanGlow/80">Acceso protegido</p>
            <h1 className="mt-5 font-display text-[2.8rem] leading-none text-ivory sm:text-[4rem]">
              Admin del catalogo
            </h1>
            <p className="mt-6 text-base leading-8 text-mist sm:text-lg">
              El menu publico sigue abierto para todos, pero la edicion real del catalogo ya requiere autenticacion y permisos
              de operador dentro de Supabase.
            </p>
            <div className="mt-8 rounded-[1.6rem] border border-white/10 bg-white/[0.03] p-5">
              <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Estado actual</p>
              <p className="mt-3 text-sm leading-7 text-mist">
                {isConfigured
                  ? 'Supabase esta configurado. Inicia sesion con una cuenta autorizada para entrar al admin.'
                  : 'Supabase no esta configurado en este entorno. Primero debes definir VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY.'}
              </p>
              {state.denied ? (
                <p className="mt-3 text-sm leading-7 text-amberGlow">
                  {typeof state.denied === 'string'
                    ? state.denied
                    : 'Tu sesion existe, pero esta cuenta no esta autorizada para operar el admin del catalogo.'}
                </p>
              ) : null}
            </div>
          </section>

          <section className="rounded-[2rem] border border-white/10 bg-white/[0.03] p-6 shadow-[0_24px_60px_rgba(0,0,0,0.3)] sm:p-8">
            <div className="flex items-center gap-3">
              <img src={zafiroLogoWhite} alt="ZAFIRO Bar Lounge logo" className="h-11 w-auto object-contain" />
              <div>
                <p className="font-display text-2xl tracking-[0.18em] text-ivory">ZAFIRO Admin</p>
                <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Login operativo</p>
              </div>
            </div>

            {isAuthenticated && !isAuthorized ? (
              <div className="mt-8 rounded-[1.4rem] border border-amberGlow/20 bg-amberGlow/10 p-5">
                <p className="font-semibold text-ivory">Sesion iniciada, pero sin permisos admin</p>
                <p className="mt-3 text-sm leading-7 text-mist">
                  Iniciaste sesion como <span className="text-ivory">{user?.email ?? 'usuario desconocido'}</span>, pero esta cuenta
                  no esta en la allowlist del catalogo.
                </p>
                <button
                  type="button"
                  onClick={() => void signOut()}
                  className="interactive-button mt-5 rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-xs font-semibold uppercase tracking-[0.22em] text-ivory"
                >
                  Cerrar sesion
                </button>
              </div>
            ) : (
              <form className="mt-8 space-y-5" onSubmit={handleSubmit}>
                <label className="block">
                  <span className="text-[0.68rem] uppercase tracking-[0.24em] text-mist">Correo</span>
                  <input
                    type="email"
                    autoComplete="email"
                    value={email}
                    onChange={(event) => setEmail(event.target.value)}
                    className="mt-2 w-full rounded-[1.15rem] border border-white/10 bg-obsidian/45 px-4 py-3 text-sm text-ivory outline-none transition focus:border-cyanGlow/40"
                    placeholder="admin@zafiro.com"
                    required
                    disabled={!isConfigured || isSubmitting}
                  />
                </label>

                <label className="block">
                  <span className="text-[0.68rem] uppercase tracking-[0.24em] text-mist">Contrasena</span>
                  <input
                    type="password"
                    autoComplete="current-password"
                    value={password}
                    onChange={(event) => setPassword(event.target.value)}
                    className="mt-2 w-full rounded-[1.15rem] border border-white/10 bg-obsidian/45 px-4 py-3 text-sm text-ivory outline-none transition focus:border-cyanGlow/40"
                    placeholder="Tu contrasena de operador"
                    required
                    disabled={!isConfigured || isSubmitting}
                  />
                </label>

                {submitError ? (
                  <div className="rounded-[1.1rem] border border-rose-200/20 bg-rose-200/10 px-4 py-3 text-sm text-rose-100">
                    {submitError}
                  </div>
                ) : null}

                {!submitError && authError && !isAuthorized ? (
                  <div className="rounded-[1.1rem] border border-amberGlow/20 bg-amberGlow/10 px-4 py-3 text-sm text-amberGlow">
                    {authError}
                  </div>
                ) : null}

                <button
                  type="submit"
                  disabled={!isConfigured || isSubmitting}
                  className={`interactive-button w-full rounded-full px-4 py-3 text-xs font-semibold uppercase tracking-[0.24em] ${
                    !isConfigured || isSubmitting
                      ? 'cursor-not-allowed border border-white/10 bg-white/[0.03] text-mist/70'
                      : 'border border-cyanGlow/20 bg-cyanGlow/10 text-cyanGlow'
                  }`}
                >
                  {isSubmitting ? 'Ingresando...' : 'Iniciar sesion'}
                </button>
              </form>
            )}

            <div className="mt-6 flex flex-wrap items-center justify-between gap-3 text-sm text-mist">
              <Link to="/" className="interactive-link text-cyanGlow/85">
                Volver al sitio
              </Link>
              <span>{authReady ? 'Sesion revisada' : 'Validando sesion...'}</span>
            </div>
          </section>
        </div>
      </div>
    </div>
  );
}
