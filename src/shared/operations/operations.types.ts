export type TableStatus = 'available' | 'occupied' | 'reserved' | 'inactive';

export type TableType = 'fixed' | 'temporary';

export type TableZone = 'salon' | 'bar' | 'terrace' | 'vip' | 'other';

export type StaffRole = 'waiter' | 'cashier' | 'admin';

export interface StaffUser {
  id: string;
  name: string;
  role: StaffRole;
  isActive: boolean;
}

export interface Table {
  id: string;
  code: string;
  name: string;
  type: TableType;
  zone: TableZone;
  capacity?: number;
  status: TableStatus;
  assignedStaffUserId?: string | null;
  activeOrderId?: string | null;
  createdAt?: string;
  createdByUserId?: string | null;
  notes?: string;
}

export type OrderStatus = 'open' | 'partially_paid' | 'paid' | 'cancelled';

export type OrderItemStatus = 'active' | 'cancelled' | 'paid';

export interface OrderItem {
  id: string;
  productId?: string | null;
  productName: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
  status: OrderItemStatus;
  addedAt: string;
  addedByUserId: string;
  cancelledAt?: string | null;
  cancelledByUserId?: string | null;
  cancellationReason?: string;
  notes?: string;
}

export interface OrderPaymentSummary {
  subtotal: number;
  discountAmount?: number;
  tipAmount?: number;
  totalDue: number;
  totalPaid: number;
  remainingBalance: number;
}

export interface Order {
  id: string;
  tableId: string;
  status: OrderStatus;
  openedAt: string;
  closedAt?: string | null;
  openedByUserId: string;
  assignedStaffUserId?: string | null;
  cashierUserId?: string | null;
  items: OrderItem[];
  paymentSummary: OrderPaymentSummary;
  notes?: string;
  cancellationReason?: string;
}

export type PaymentMethod = 'cash' | 'nequi' | 'bank_transfer' | 'card' | 'other';

export type PaymentStatus = 'pending' | 'confirmed' | 'rejected';

export type PaymentAllocationType = 'amount' | 'items';

export interface PaymentAllocation {
  id: string;
  type: PaymentAllocationType;
  amount: number;
  orderItemIds?: string[];
}

export interface CashPaymentDetails {
  amountDue: number;
  amountApplied: number;
  amountReceived: number;
  changeDue: number;
}

export interface Payment {
  id: string;
  orderId: string;
  amount: number;
  method: PaymentMethod;
  status: PaymentStatus;
  receivedAt: string;
  receivedByUserId: string;
  allocations: PaymentAllocation[];
  amountDue?: number;
  amountApplied?: number;
  amountReceived?: number;
  changeDue?: number;
  cashDetails?: CashPaymentDetails;
  tipAmount?: number;
  reference?: string;
  confirmedAt?: string | null;
  confirmedByUserId?: string | null;
  notes?: string;
}

export interface QuickProductSearchFilters {
  query?: string;
  type?: string;
  subgrupo?: string;
  onlyVisibleInPublic?: boolean;
  onlyAvailable?: boolean;
  onlyFeaturedInPublic?: boolean;
  onlyVisibleInPos?: boolean;
  onlyFrequentInPos?: boolean;
}

export type PosProductVisibility = 'hidden' | 'visible' | 'frequent';

export interface PosProductShortcut {
  productId: string;
  label: string;
  visibility: PosProductVisibility;
  priority?: number;
}

export interface CashRegisterPaymentBreakdown {
  method: PaymentMethod;
  totalAmount: number;
  paymentCount: number;
  pendingAmount?: number;
  confirmedAmount?: number;
  rejectedAmount?: number;
}

export interface CashRegisterSummary {
  expectedCashAmount: number;
  confirmedPaymentsTotal: number;
  pendingPaymentsTotal: number;
  rejectedPaymentsTotal: number;
  paymentBreakdown: CashRegisterPaymentBreakdown[];
}

export type OrderAuditEventType =
  | 'table_created'
  | 'table_updated'
  | 'order_opened'
  | 'order_item_added'
  | 'order_item_cancelled'
  | 'payment_created'
  | 'payment_confirmed'
  | 'payment_rejected'
  | 'order_closed'
  | 'order_cancelled';

export interface OrderAuditEvent {
  id: string;
  orderId?: string | null;
  tableId?: string | null;
  type: OrderAuditEventType;
  createdAt: string;
  createdByUserId: string;
  payload?: Record<string, unknown>;
  notes?: string;
}

export type CashRegisterStatus = 'open' | 'closed';

export interface CashRegisterSession {
  id: string;
  status: CashRegisterStatus;
  openedAt: string;
  openedByUserId: string;
  closedAt?: string | null;
  closedByUserId?: string | null;
  openingAmount?: number;
  closingAmount?: number;
  summary?: CashRegisterSummary;
  notes?: string;
}
