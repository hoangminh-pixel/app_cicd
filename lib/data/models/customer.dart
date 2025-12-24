class Customer {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? address;
  final String? qrCode; // mã QR đại diện cho khách hàng

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    this.qrCode,
  });
}

 final customers = <Customer>[
    Customer(id: "c1", name: "Nguyễn Văn A", phone: "0123456789", address: 'Hanoi'),
    Customer(id: "c2", name: "Trần Thị B", phone: "0987654321",address: 'Haiphong'),
  ];
