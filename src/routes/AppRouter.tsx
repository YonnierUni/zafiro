import { Navigate, Route, Routes } from 'react-router-dom';
import { HomeView } from '../views/HomeView';

export function AppRouter() {
  return (
    <Routes>
      <Route path="/" element={<HomeView />} />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
