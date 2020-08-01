unit f17;

interface

uses typetubes2018;

procedure upInvMentah (var Inv: simulasi; var pembelian : integer);
	{I.S Jika uang yang dimiliki mencapai harga membeli inventori maka dapat melakukan upgrade inventori bahan mentah}
	{F.S Jumlah kapasitas inventori bahan mentah setelah diupgrade (+25)}

procedure upInvOlahan (var Inv: simulasi);
	{I.S Jika uang yang dimiliki mencapai harga membeli inventori maka dapat melakukan upgrade inventori bahan olahan}
	{F.S Jumlah kapasitas inventori bahan olahan setelah diupgrade (+25)}



implementation
	
procedure upInvMentah (var Inv: simulasi; var pembelian : integer);
	{I.S Jika uang yang dimiliki mencapai harga membeli inventori maka dapat melakukan upgrade inventori bahan mentah}
	{F.S Jumlah kapasitas inventori bahan mentah setelah diupgrade (+25)}
	{ALGORITMA PROCEDURE}
	begin
		if (cukupUang(pembelian, Inv) = true) then
		begin
			Inv.maksInvMentah := Inv.maksInvMentah + 25;
			Inv.totalUang := Inv.totalUang - 25000;
			Inv.totalPengeluaran := Inv.totalPengeluaran + 25000;
			writeln('Update inventori bahan mentah berhasil.');
			writeln('Kapasitas inventori bahan mentah anda ',Inv.maksInvMentah);
			writeln('Sisa uang anda ',Inv.totalUang);
		end;
	end;

procedure upInvOlahan(var Inv: simulasi);
	{I.S Jika uang yang dimiliki mencapai harga membeli inventori maka dapat melakukan upgrade inventori bahan olahan}
	{F.S Jumlah kapasitas inventori bahan olahan setelah diupgrade (+25)}
	
	const
		harga = 25000;
	{ALGORITMA PROCEDURE}
	begin
		if (cukupUang(harga, Inv) = true) then
		begin
			Inv.maksInvOlahan := Inv.maksInvOlahan + 25;
			Inv.totalUang := Inv.totalUang - harga;
			Inv.totalPengeluaran := Inv.totalPengeluaran + harga;
			writeln('Update inventori bahan olahan berhasil.');
			writeln('Kapasitas inventori bahan olahan anda ',Inv.maksInvOlahan);
			writeln('Sisa uang anda ',Inv.totalUang);
		end;
	end;

end.
