export type MenuCategory = string;

export interface MenuDataItem {
  id: number;
  sourceKey?: string;
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
  updatedAt?: string;
  createdAt?: string;
}

export interface MenuDataCollection {
  updatedAt: string;
  count: number;
  items: MenuDataItem[];
}
