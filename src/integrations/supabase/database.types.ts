export interface Database {
  public: {
    Tables: {
      admin_users: {
        Row: {
          created_at: string;
          email: string;
        };
        Insert: {
          created_at?: string;
          email: string;
        };
        Update: Partial<Database['public']['Tables']['admin_users']['Insert']>;
        Relationships: [];
      };
      menu_change_logs: {
        Row: {
          actor_label: string | null;
          after_data: Record<string, unknown>;
          applied_at: string;
          before_data: Record<string, unknown>;
          change_source: string;
          changed_fields: Record<string, unknown>;
          id: string;
          item_slug: string;
          menu_item_source_key: string;
        };
        Insert: {
          actor_label?: string | null;
          after_data: Record<string, unknown>;
          applied_at?: string;
          before_data: Record<string, unknown>;
          change_source?: string;
          changed_fields: Record<string, unknown>;
          id?: string;
          item_slug: string;
          menu_item_source_key: string;
        };
        Update: Partial<Database['public']['Tables']['menu_change_logs']['Insert']>;
        Relationships: [];
      };
      menu_items: {
        Row: {
          created_at: string;
          description: string;
          disponible: boolean;
          destacado: boolean;
          emplatado: string;
          hoja_origen: string;
          id: string;
          imagen: string;
          ingredientes: string;
          legacy_id: number;
          name: string;
          orden: number;
          precio_venta: number | null;
          preparacion: string;
          slug: string;
          source_key: string;
          subgrupo: string | null;
          tipo: string;
          updated_at: string;
          visible: boolean;
        };
        Insert: {
          created_at?: string;
          description?: string;
          disponible?: boolean;
          destacado?: boolean;
          emplatado?: string;
          hoja_origen: string;
          id?: string;
          imagen?: string;
          ingredientes?: string;
          legacy_id: number;
          name: string;
          orden: number;
          precio_venta?: number | null;
          preparacion?: string;
          slug: string;
          source_key: string;
          subgrupo?: string | null;
          tipo: string;
          updated_at?: string;
          visible?: boolean;
        };
        Update: Partial<Database['public']['Tables']['menu_items']['Insert']>;
        Relationships: [];
      };
      menu_snapshots: {
        Row: {
          created_at: string;
          id: string;
          payload: Record<string, unknown>;
          snapshot_kind: string;
          summary: Record<string, unknown>;
        };
        Insert: {
          created_at?: string;
          id?: string;
          payload: Record<string, unknown>;
          snapshot_kind: string;
          summary: Record<string, unknown>;
        };
        Update: Partial<Database['public']['Tables']['menu_snapshots']['Insert']>;
        Relationships: [];
      };
    };
    Views: {
      menu_items_public: {
        Row: Database['public']['Tables']['menu_items']['Row'];
        Relationships: [];
      };
    };
    Functions: {
      is_catalog_admin: {
        Args: Record<PropertyKey, never>;
        Returns: boolean;
      };
    };
  };
}
