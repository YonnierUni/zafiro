import { Navigate, Route, Routes } from 'react-router-dom';
import { HomeView } from '../views/HomeView';
import { MenuView } from '../views/MenuView';

export function AppRouter() {
  return (
    <Routes>
      <Route path="/" element={<HomeView />} />
      <Route path="/menu" element={<MenuView />} />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
