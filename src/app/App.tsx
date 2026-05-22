import { AppRouter } from '../routes/AppRouter';
import { SupabaseAuthProvider } from '../auth/SupabaseAuthProvider';

export default function App() {
  return (
    <SupabaseAuthProvider>
      <AppRouter />
    </SupabaseAuthProvider>
  );
}
