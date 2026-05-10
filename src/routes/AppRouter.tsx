import { Navigate, Route, Routes } from 'react-router-dom';
import { AdminMenuView } from '../admin/AdminMenuView';
import { AdminPosView } from '../admin/AdminPosView';
import { AdminView } from '../admin/AdminView';
import { HomeView } from '../views/HomeView';
import { MenuView } from '../views/MenuView';

export function AppRouter() {
  return (
    <Routes>
      <Route path="/admin" element={<AdminView />} />
      <Route path="/admin/menu" element={<AdminMenuView />} />
      <Route path="/admin/pos" element={<AdminPosView />} />
      <Route path="/" element={<HomeView />} />
      <Route path="/menu" element={<MenuView />} />
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
