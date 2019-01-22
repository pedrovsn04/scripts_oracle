-- Senha Master Cliente (Nextel)
select b.cd_Federal_Tax||' - '||b.nm_customer_main Cliente, a.nxpin "Senha Master", c.cd_status||' - '||c.de_status as "Status do Departamento", 
d.nm_customer_level "Nome Depto", d.cd_Customer "BSCS"
from nxt_corp_pin a, tbgn_Customer_main b, tbgn_status c, tbgn_customer d
where a.custcode = d.cd_Customer
and b.id_customer_main = d.id_Customer_main
and d.cd_customer_status = c.cd_status
and length(a.nxpin) > 4
and b.cd_Federal_Tax = 08069385790;

-- Senha Master Cliente (SFA)
select b.cd_Federal_Tax||' - '||b.nm_customer_main Cliente, a.cd_pin + 10 "Senha Master", a.nm_customer_level "Nome Depto", a.cd_Customer "BSCS"
from tsfa_customer a, tsfa_customer_main b
where a.id_Customer_main = b.id_Customer_main
and b.cd_Federal_Tax = 08069385790


