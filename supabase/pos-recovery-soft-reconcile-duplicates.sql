-- Conservative reconciliation after duplicate recovery run.
-- DOES NOT DELETE rows. It only marks selected recovery-created duplicate payments/items
-- so operational totals stop counting them, while preserving an audit trail.
-- Generated from Supabase Snippet POS Recovery Inspection & Integrity Checks (3).csv.

begin;

-- Payment rows selected because their amounts exactly match each jornada surplus
-- (pagos_confirmados - venta_total) in the latest inspection CSV.
-- 2026-05-22   3000 nequi         payment_id=18d16cdb-446c-5b1d-9966-c7355f473d90 order_id=695c6444-6e6d-474e-b599-646c930484ed
-- 2026-05-22   5000 nequi         payment_id=46c91d90-24ad-5509-8546-c1dc4013fd6d order_id=2f0a2ca0-a496-45c2-804b-11d4c3957218
-- 2026-05-22  25000 nequi         payment_id=a60bc81e-f8a5-5e52-b771-dc1f0b21a79d order_id=153e1b85-3e78-4f62-bbb9-a1ce34b5b724
-- 2026-05-22  19000 cash          payment_id=572643e3-4e5a-55fb-9995-d9cb6b7263de order_id=0465fded-62e7-4331-8c86-7ca920fe5006
-- 2026-05-22 295000 nequi         payment_id=5133e04e-e0f9-5848-90b8-d9d4d01e6198 order_id=566f932d-4c7c-4962-a5fc-6959fc96be0f
-- 2026-05-23   5000 nequi         payment_id=fde59498-e764-5c98-95ab-ef1be54b8b0b order_id=50a53517-864f-44d9-b9c9-516dd21f05d8
-- 2026-05-23  81000 bank_transfer payment_id=1fd791c0-e5b1-5147-bf77-e261fc094203 order_id=173aadce-cba6-453d-92da-5fe26a21e69d
-- 2026-05-23   8000 bank_transfer payment_id=a748dc02-4c89-5ce6-b29f-221a0efee182 order_id=173aadce-cba6-453d-92da-5fe26a21e69d
-- 2026-05-23  12000 cash          payment_id=743d1f50-de18-5bd3-a2b0-4bff072f9406 order_id=173aadce-cba6-453d-92da-5fe26a21e69d
-- 2026-05-23  72000 cash          payment_id=cb0b5d06-74e3-55cc-a1dd-bdf4a058500c order_id=1bec3141-0350-414d-8c12-4fc3c06e40a4
-- 2026-05-23  22000 bank_transfer payment_id=e249c2a3-b0b5-5186-bd56-6a34236b5ae2 order_id=f49a1572-86cd-48d8-86b1-89ead2157652
-- 2026-05-23   9000 cash          payment_id=ad40e7ce-84c2-52a6-8554-7f27d8f08d5e order_id=a15b8cf8-8e34-4cf6-bc1f-9b638aba7203
-- 2026-05-23  56000 nequi         payment_id=aefd4382-53b5-52d4-99d3-e6b063604121 order_id=71c2075e-bf5f-4531-85a6-1139f5ceaa47
-- 2026-05-23  32000 nequi         payment_id=7b279da1-39f6-5fe0-aabd-7f95e75831e9 order_id=1fc00905-31b6-429f-873f-1a4e58303669
-- 2026-05-24  10000 cash          payment_id=08163b9c-f7c0-5b55-baae-d3d2c9050fa8 order_id=83811ff2-6a42-4042-83cf-fbb14b1a05a4
-- 2026-05-26  19000 nequi         payment_id=af335931-fbf2-5dfb-aba8-bf33fca5ece9 order_id=4ea5e71f-f2d4-47c9-b77f-e04248d8f668
-- 2026-05-26  10000 nequi         payment_id=b080b4c6-3075-54bd-ac74-aa7e1e10fa47 order_id=cd11c35c-1fba-4398-84b9-7a4b90bacbab
-- 2026-05-26  28000 nequi         payment_id=5f603907-7e3b-5a2d-8c7e-f4d3ad7c935b order_id=0470d9df-4237-4811-9ef8-d2a40e1d6371
-- 2026-05-26   5000 cash          payment_id=79555a40-b690-5673-9d76-4c89aa722ca4 order_id=78c8e74c-48be-4d0b-a996-525d33f70fbb
-- 2026-05-26   5000 cash          payment_id=8b54e827-e868-5bbe-94ec-b2f928c2827b order_id=7cefad24-a203-455e-932a-5c564f2a3624
-- 2026-05-26  26000 nequi         payment_id=e53367fa-ef38-5677-966c-b9a0807add9e order_id=8c340a3b-fac0-46f3-8996-5a3fb6678feb
-- 2026-05-26   5000 nequi         payment_id=4b82603e-0282-5b36-bfea-50a91589e0d1 order_id=faebbf42-ace3-47f9-9df3-2d23b2e76e79
-- 2026-05-28  51000 nequi         payment_id=9c29817e-9810-5d49-a8c0-a53a4cc7b396 order_id=8a16e76b-ffb9-406f-b437-b089915b6994
-- 2026-05-29   6000 nequi         payment_id=0b7f757b-31cf-5fea-91bd-f0a3feca3a43 order_id=b4f8f126-4265-416e-8628-e965db52d100
-- 2026-05-29  42000 nequi         payment_id=751a9413-fd9c-5376-95c1-2b3b026c12c0 order_id=d38f98b4-16e3-40f2-81d7-d97f1dbd4da9
-- 2026-05-29   5000 cash          payment_id=bb731cdb-6a11-5b91-98d3-d167e87457c0 order_id=0645f808-4bf6-42d4-b059-82e729773888
-- 2026-05-29   5000 cash          payment_id=c1793635-3156-578e-8fa4-06cc2ced8eab order_id=522f035f-d137-4845-8013-1640b4e97758
-- 2026-05-29  25000 nequi         payment_id=bea336f2-0b9c-5e66-9635-5be92d291e78 order_id=887cec88-8897-4cb6-8a6c-4aae3eb92de3
-- 2026-05-29  82000 cash          payment_id=d8ad6128-8447-55bb-9de9-eae7a308e267 order_id=6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c
-- 2026-05-30   5000 cash          payment_id=018faa50-a38c-5614-964d-bffe38bc5c7b order_id=5f6c36a6-ea72-434c-a531-0d40271d99dc
-- 2026-05-30   5000 other         payment_id=83f7eec1-e37f-52e6-8e23-687de7316809 order_id=10c11ad2-3dc7-4ffa-ad2e-589948d5f646
-- 2026-05-30  44000 nequi         payment_id=78056410-52e4-5b01-b704-7690647a2cfa order_id=6914e2f5-07c7-42b8-be44-eb567f03747a
-- 2026-05-30  62000 nequi         payment_id=18ec53f8-7c1e-5f54-ae7a-7f9e6fa9b763 order_id=6e9ffa4d-7a3e-4910-9441-cb70c54e02c4
-- 2026-05-30  82000 nequi         payment_id=a07a8338-50b3-53ad-8581-6135eb0af950 order_id=a113fef6-fb98-4260-9070-80042910f289
-- 2026-05-30  78000 bank_transfer payment_id=858cac88-d5f1-5ae9-9ee2-0c356610770f order_id=ba3c5059-0ba0-4839-8c98-3180f971a271
-- 2026-05-31  10000 nequi         payment_id=7d866d90-4e6a-51ad-8a54-248b48e84510 order_id=bacf03d0-c7c3-492a-96eb-fb897a0297dc
-- 2026-05-31   6000 cash          payment_id=a912c15e-e8cf-586e-8605-adbae8b452c5 order_id=99e279d9-995c-4c05-9c55-5b89814a6d09
-- 2026-05-31 102000 bank_transfer payment_id=b81b2899-ad8b-555a-a950-54368afe9f44 order_id=54388ffc-8714-412a-bb98-73e13e89edab
-- 2026-05-31  70000 nequi         payment_id=91a96281-cab5-5dcb-b3c8-0ca11e56f1cb order_id=69cfc190-78db-4eda-bcb2-3dd821844091
-- 2026-05-31  29000 cash          payment_id=d7b66912-c14d-56cb-8eaf-a80861a5a642 order_id=85da1ae7-7385-4d90-9ab0-4aaacf29f2e8
-- 2026-05-31  70000 nequi         payment_id=3cbdb68d-c312-5f65-9877-1157a6350729 order_id=46503d83-e948-46eb-a5d6-7cc57b192414
-- 2026-05-31  71000 bank_transfer payment_id=2453bef0-1095-5152-ad0b-e885c14fd2aa order_id=b8d45027-1623-4281-8a4c-5e1303f67563
-- 2026-06-01   8000 cash          payment_id=63eed389-ada9-5544-8d99-02d20c50b201 order_id=f1c42de6-4389-43fc-9613-23a252d3b063
-- 2026-06-01  47000 nequi         payment_id=33ad86e3-5427-5e04-bf4c-81684b711622 order_id=3e614951-a4c6-419e-a389-66520337da5a
-- 2026-06-01   5000 nequi         payment_id=1726bf65-f2cf-5468-85e0-21361c47228e order_id=3e614951-a4c6-419e-a389-66520337da5a
-- 2026-06-01   5000 cash          payment_id=8db9fcf4-cf5c-5092-8ccb-36126711f5c8 order_id=7922b6cd-c2ea-4df9-85e5-586783afcc8d
-- 2026-06-01   9000 nequi         payment_id=458ef0dd-1578-52cc-89ea-85ae8bf5bfb7 order_id=7922b6cd-c2ea-4df9-85e5-586783afcc8d
-- 2026-06-01  35000 nequi         payment_id=db6de80e-4035-53c8-808f-018a8b68ca73 order_id=04259209-f015-47b9-b1df-9aa324dc4d8f
-- 2026-06-01  26000 bank_transfer payment_id=e05896e3-b2f0-57eb-971d-b567e5f5fc2b order_id=825d025e-65de-4a28-a56d-474796cd8a31
-- 2026-06-03  80000 bank_transfer payment_id=3f716cb8-6a7c-5b0d-b4ed-044822869c8c order_id=d9cf2b65-d040-45f3-ba2a-db2aaf15409e
-- 2026-06-03  38000 nequi         payment_id=dd4a8f27-165f-5c58-a257-32e0726c7ea0 order_id=a9a1bee7-070d-4c86-a6f8-31b542a5fdf1
-- 2026-06-03   5000 cash          payment_id=e01d965e-a455-5058-8f08-9fb86799f0fa order_id=90df6e99-c8ae-4678-a816-d347955de1dd
-- 2026-06-03  15000 nequi         payment_id=6d1e0337-93e8-59a2-8d8a-c95b498c20d7 order_id=90df6e99-c8ae-4678-a816-d347955de1dd
-- 2026-06-03  93000 cash          payment_id=cd25330f-3f35-5639-90c1-4500a0b63ce0 order_id=1cd556fd-3cc9-4db4-b54b-536e94ca22bd
-- 2026-06-03 101000 cash          payment_id=75bab6bf-4ffc-52dd-bf4a-a658d3dfc114 order_id=ad3415ff-3d54-44ee-9691-d57cd8f01b25
-- 2026-06-03  65000 bank_transfer payment_id=cd769331-2edd-534c-82a2-66efe8aa08ed order_id=dd5b18d2-2fb1-464b-9322-4b58866a75ac
-- 2026-06-03  17000 nequi         payment_id=8ab0b1ff-1095-5dd1-b1e7-e7eda48c57ff order_id=14a32cde-5e31-478f-84f4-dc281012ebb3
-- 2026-06-03  16000 nequi         payment_id=b9b1aec6-28c4-585b-91a8-9620efe1ebf0 order_id=fb31121c-bcba-4ef4-a0e8-0a8f81854907
-- 2026-06-04   5000 nequi         payment_id=01586789-3aec-5a39-a40a-14b1b06db716 order_id=ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d
-- 2026-06-04  10000 nequi         payment_id=f489b6a2-596d-5aa5-affa-93038804a1c0 order_id=46142a57-894a-42d7-81d1-82f06a88e20f
-- 2026-06-04  27000 nequi         payment_id=817149b9-934a-5ed6-8122-879636247ca8 order_id=46142a57-894a-42d7-81d1-82f06a88e20f
-- 2026-06-04  20000 nequi         payment_id=628e62c1-33ba-597f-b9eb-609334dc16be order_id=46142a57-894a-42d7-81d1-82f06a88e20f
-- 2026-06-04  20000 nequi         payment_id=aae8bbd0-9369-5062-bf6c-c337b936be51 order_id=46142a57-894a-42d7-81d1-82f06a88e20f
-- 2026-06-04  18000 cash          payment_id=db315e1a-9592-544e-aa84-f84af9bbc1cb order_id=46142a57-894a-42d7-81d1-82f06a88e20f
-- 2026-06-04 110000 nequi         payment_id=399fba7a-253a-58e7-af46-93ec4e45d663 order_id=877ee3ac-8d9b-4d3f-98f6-7956f292e416
-- 2026-06-04  40000 nequi         payment_id=24881ab9-73ef-5fb5-a86c-b07e4865e428 order_id=9fbd6c34-66a7-40a0-9b50-969dc0d17abb
-- 2026-06-04  20000 nequi         payment_id=a5cc420e-10d4-56a5-a2b7-f9a1c5abbae7 order_id=a4ae9670-f0b4-4638-b02b-fb9f33dde038
-- 2026-06-05   5000 nequi         payment_id=648508eb-e146-5bf3-b592-2aa1d8613f8b order_id=72698c72-61db-4294-ad32-743bfba0af3e
-- 2026-06-06  88000 nequi         payment_id=ae53f137-e2c7-5fe4-95a3-06acdcd462c1 order_id=f7a7742d-fbed-4d43-8d83-1fdeaa2af222
-- 2026-06-06  29000 nequi         payment_id=3641ad5c-a53b-55ed-adc9-f74282816729 order_id=ec4580a9-70e8-4eb4-be68-75cd70717cd5
-- 2026-06-06 142000 cash          payment_id=af9419bf-b5c0-5339-b513-8003dc38b946 order_id=9ea3687b-7126-49f5-a692-55ad244b42ee
-- 2026-06-06  81000 nequi         payment_id=3467a5f8-ba8e-510c-82e2-74eb3d74f660 order_id=04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7
-- 2026-06-06  41000 nequi         payment_id=21b3c127-43c5-5660-99be-f93328bce370 order_id=eb368a47-a4b1-4ac4-bbf2-500b012f7b94
-- 2026-06-06  67000 nequi         payment_id=a27c1ff5-8fc4-5802-8431-af8e3a104eb6 order_id=0a3c26cf-15fa-4255-9275-499f8c4f52b2
-- 2026-06-06  47000 cash          payment_id=517992ab-de3c-5e06-96d6-fcb251a3854d order_id=0a3c26cf-15fa-4255-9275-499f8c4f52b2
-- 2026-06-06  63000 cash          payment_id=4bd016cf-af31-59bd-9782-228c5878853c order_id=0a3c26cf-15fa-4255-9275-499f8c4f52b2
-- 2026-06-06  15000 cash          payment_id=66735e74-2eb6-5112-bb40-7863e13fda73 order_id=593359c4-ceb7-4f02-b2cf-46d259202acb
-- 2026-06-06  26000 cash          payment_id=abb189ae-7861-5f2f-8c6b-b1fb54a2a29e order_id=83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9
-- 2026-06-06  86000 cash          payment_id=5b99d235-161f-5d94-89ad-0d9e337ab164 order_id=26e809e6-d86a-47ed-8339-85708600a40e
-- 2026-06-06  59000 nequi         payment_id=bd20a8e0-1f02-5b0f-8809-3d1485f5ef82 order_id=4e33d0ec-e975-4a0d-b471-e1e951b2688b
-- 2026-06-06  60000 nequi         payment_id=b88b5535-a133-5820-9e08-f72905b05a23 order_id=355daae2-f2de-48be-814e-d4580a858e4c

with duplicate_payment_ids(id) as (
  values
    ('18d16cdb-446c-5b1d-9966-c7355f473d90'::uuid),
    ('46c91d90-24ad-5509-8546-c1dc4013fd6d'::uuid),
    ('a60bc81e-f8a5-5e52-b771-dc1f0b21a79d'::uuid),
    ('572643e3-4e5a-55fb-9995-d9cb6b7263de'::uuid),
    ('5133e04e-e0f9-5848-90b8-d9d4d01e6198'::uuid),
    ('fde59498-e764-5c98-95ab-ef1be54b8b0b'::uuid),
    ('1fd791c0-e5b1-5147-bf77-e261fc094203'::uuid),
    ('a748dc02-4c89-5ce6-b29f-221a0efee182'::uuid),
    ('743d1f50-de18-5bd3-a2b0-4bff072f9406'::uuid),
    ('cb0b5d06-74e3-55cc-a1dd-bdf4a058500c'::uuid),
    ('e249c2a3-b0b5-5186-bd56-6a34236b5ae2'::uuid),
    ('ad40e7ce-84c2-52a6-8554-7f27d8f08d5e'::uuid),
    ('aefd4382-53b5-52d4-99d3-e6b063604121'::uuid),
    ('7b279da1-39f6-5fe0-aabd-7f95e75831e9'::uuid),
    ('08163b9c-f7c0-5b55-baae-d3d2c9050fa8'::uuid),
    ('af335931-fbf2-5dfb-aba8-bf33fca5ece9'::uuid),
    ('b080b4c6-3075-54bd-ac74-aa7e1e10fa47'::uuid),
    ('5f603907-7e3b-5a2d-8c7e-f4d3ad7c935b'::uuid),
    ('79555a40-b690-5673-9d76-4c89aa722ca4'::uuid),
    ('8b54e827-e868-5bbe-94ec-b2f928c2827b'::uuid),
    ('e53367fa-ef38-5677-966c-b9a0807add9e'::uuid),
    ('4b82603e-0282-5b36-bfea-50a91589e0d1'::uuid),
    ('9c29817e-9810-5d49-a8c0-a53a4cc7b396'::uuid),
    ('0b7f757b-31cf-5fea-91bd-f0a3feca3a43'::uuid),
    ('751a9413-fd9c-5376-95c1-2b3b026c12c0'::uuid),
    ('bb731cdb-6a11-5b91-98d3-d167e87457c0'::uuid),
    ('c1793635-3156-578e-8fa4-06cc2ced8eab'::uuid),
    ('bea336f2-0b9c-5e66-9635-5be92d291e78'::uuid),
    ('d8ad6128-8447-55bb-9de9-eae7a308e267'::uuid),
    ('018faa50-a38c-5614-964d-bffe38bc5c7b'::uuid),
    ('83f7eec1-e37f-52e6-8e23-687de7316809'::uuid),
    ('78056410-52e4-5b01-b704-7690647a2cfa'::uuid),
    ('18ec53f8-7c1e-5f54-ae7a-7f9e6fa9b763'::uuid),
    ('a07a8338-50b3-53ad-8581-6135eb0af950'::uuid),
    ('858cac88-d5f1-5ae9-9ee2-0c356610770f'::uuid),
    ('7d866d90-4e6a-51ad-8a54-248b48e84510'::uuid),
    ('a912c15e-e8cf-586e-8605-adbae8b452c5'::uuid),
    ('b81b2899-ad8b-555a-a950-54368afe9f44'::uuid),
    ('91a96281-cab5-5dcb-b3c8-0ca11e56f1cb'::uuid),
    ('d7b66912-c14d-56cb-8eaf-a80861a5a642'::uuid),
    ('3cbdb68d-c312-5f65-9877-1157a6350729'::uuid),
    ('2453bef0-1095-5152-ad0b-e885c14fd2aa'::uuid),
    ('63eed389-ada9-5544-8d99-02d20c50b201'::uuid),
    ('33ad86e3-5427-5e04-bf4c-81684b711622'::uuid),
    ('1726bf65-f2cf-5468-85e0-21361c47228e'::uuid),
    ('8db9fcf4-cf5c-5092-8ccb-36126711f5c8'::uuid),
    ('458ef0dd-1578-52cc-89ea-85ae8bf5bfb7'::uuid),
    ('db6de80e-4035-53c8-808f-018a8b68ca73'::uuid),
    ('e05896e3-b2f0-57eb-971d-b567e5f5fc2b'::uuid),
    ('3f716cb8-6a7c-5b0d-b4ed-044822869c8c'::uuid),
    ('dd4a8f27-165f-5c58-a257-32e0726c7ea0'::uuid),
    ('e01d965e-a455-5058-8f08-9fb86799f0fa'::uuid),
    ('6d1e0337-93e8-59a2-8d8a-c95b498c20d7'::uuid),
    ('cd25330f-3f35-5639-90c1-4500a0b63ce0'::uuid),
    ('75bab6bf-4ffc-52dd-bf4a-a658d3dfc114'::uuid),
    ('cd769331-2edd-534c-82a2-66efe8aa08ed'::uuid),
    ('8ab0b1ff-1095-5dd1-b1e7-e7eda48c57ff'::uuid),
    ('b9b1aec6-28c4-585b-91a8-9620efe1ebf0'::uuid),
    ('01586789-3aec-5a39-a40a-14b1b06db716'::uuid),
    ('f489b6a2-596d-5aa5-affa-93038804a1c0'::uuid),
    ('817149b9-934a-5ed6-8122-879636247ca8'::uuid),
    ('628e62c1-33ba-597f-b9eb-609334dc16be'::uuid),
    ('aae8bbd0-9369-5062-bf6c-c337b936be51'::uuid),
    ('db315e1a-9592-544e-aa84-f84af9bbc1cb'::uuid),
    ('399fba7a-253a-58e7-af46-93ec4e45d663'::uuid),
    ('24881ab9-73ef-5fb5-a86c-b07e4865e428'::uuid),
    ('a5cc420e-10d4-56a5-a2b7-f9a1c5abbae7'::uuid),
    ('648508eb-e146-5bf3-b592-2aa1d8613f8b'::uuid),
    ('ae53f137-e2c7-5fe4-95a3-06acdcd462c1'::uuid),
    ('3641ad5c-a53b-55ed-adc9-f74282816729'::uuid),
    ('af9419bf-b5c0-5339-b513-8003dc38b946'::uuid),
    ('3467a5f8-ba8e-510c-82e2-74eb3d74f660'::uuid),
    ('21b3c127-43c5-5660-99be-f93328bce370'::uuid),
    ('a27c1ff5-8fc4-5802-8431-af8e3a104eb6'::uuid),
    ('517992ab-de3c-5e06-96d6-fcb251a3854d'::uuid),
    ('4bd016cf-af31-59bd-9782-228c5878853c'::uuid),
    ('66735e74-2eb6-5112-bb40-7863e13fda73'::uuid),
    ('abb189ae-7861-5f2f-8c6b-b1fb54a2a29e'::uuid),
    ('5b99d235-161f-5d94-89ad-0d9e337ab164'::uuid),
    ('bd20a8e0-1f02-5b0f-8809-3d1485f5ef82'::uuid),
    ('b88b5535-a133-5820-9e08-f72905b05a23'::uuid)
)
update public.pos_payments p
set status = 'rejected',
    rejected_at = coalesce(p.rejected_at, timezone('utc', now())),
    rejected_by_email = coalesce(p.rejected_by_email, 'recovery@zafiro.local'),
    rejection_reason = coalesce(p.rejection_reason, 'Rechazado por conciliacion: duplicado creado por recovery conservador 2026-06-08')
from duplicate_payment_ids d
where p.id = d.id
  and p.status = 'confirmed'
  and p.created_by_email = 'recovery@zafiro.local';

-- Product rows selected because they exactly match the product-detail surplus:
-- 2026-05-30: +13000 / +1 product; 2026-06-06: +25000 / +4 products.
-- 2026-05-30  13000 qty=1 item_id=a43eee50-7182-51cd-b0c0-69960ef38594 order_id=6914e2f5-07c7-42b8-be44-eb567f03747a product=Soda Italiana de Maracuyá
-- 2026-06-06  10000 qty=1 item_id=98fd1986-4e45-5bf5-b62a-7cb875f6f4bc order_id=eb368a47-a4b1-4ac4-bbf2-500b012f7b94 product=Limonada de Sandía
-- 2026-06-06  15000 qty=3 item_id=341b3b55-dde4-518f-aa5b-daaf2122ad26 order_id=593359c4-ceb7-4f02-b2cf-46d259202acb product=Águila Original

with duplicate_item_ids(id) as (
  values
    ('a43eee50-7182-51cd-b0c0-69960ef38594'::uuid),
    ('98fd1986-4e45-5bf5-b62a-7cb875f6f4bc'::uuid),
    ('341b3b55-dde4-518f-aa5b-daaf2122ad26'::uuid)
)
update public.pos_order_items i
set operational_status = 'cancelled',
    financial_status = 'cancelled',
    cancelled_at = coalesce(i.cancelled_at, timezone('utc', now())),
    cancelled_by_email = coalesce(i.cancelled_by_email, 'recovery@zafiro.local'),
    cancellation_reason = coalesce(i.cancellation_reason, 'Cancelado por conciliacion: duplicado creado por recovery conservador 2026-06-08'),
    updated_at = timezone('utc', now()),
    updated_by_email = 'recovery@zafiro.local'
from duplicate_item_ids d
where i.id = d.id
  and i.operational_status <> 'cancelled'
  and i.financial_status <> 'cancelled'
  and i.created_by_email = 'recovery@zafiro.local';

-- Verification after reconciliation. Expected: pagos_confirmados should match venta_total for these jornadas.
select
  s.business_date as jornada,
  coalesce(sum(p.amount_applied) filter (where p.status = 'confirmed'), 0) as pagos_confirmados
from public.pos_sales_sessions s
left join public.pos_payments p on p.sales_session_id = s.id
where s.business_date between '2026-05-22'::date and '2026-06-06'::date
group by s.business_date
order by s.business_date;

commit;
