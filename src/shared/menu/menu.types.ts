export type MenuCategory = string;

export interface MenuDataItem {
  id: number;
  orden: number;
  slug: string;
  name: string;
  description: string;
  tipo: string;
  subgrupo?: string;
  ingredientes: string;
  preparacion: string;
  emplatado: string;
  precioVenta: number | null;
  imagen: string;
  hojaOrigen: string;
  visible: boolean;
  disponible: boolean;
  destacado: boolean;
}

export interface MenuDataCollection {
  updatedAt: string;
  count: number;
  items: MenuDataItem[];
}
