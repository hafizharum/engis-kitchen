unit f13;

interface

uses typetubes2018;

procedure lihatMentah (var inv: inventoriMentah);
	{I.S Daftar bahan mentah pada inventori bahan mentah belum terurut berdasarkan nama}
	{F.S Menampilkan daftar bahan mentah pada inventori bahan mentah terurut berdasarkan nama (a..z)}

procedure lihatOlahan (var inv: inventoriOlahan); 
	{I.S Daftar bahan olahan pada inventori bahan olahan belum terurut berdasarkan nama}
	{F.S Menampilkan daftar bahan olahan pada inventori bahan olahan terurut berdasarkan nama (a..z)}

implementation

procedure lihatMentah (var inv: inventoriMentah);
	{I.S Daftar bahan mentah pada inventori bahan mentah belum terurut berdasarkan nama}
	{F.S Menampilkan daftar bahan mentah pada inventori bahan mentah terurut berdasarkan nama (a..z)}
	{KAMUS LOKAL}
	var
		i,j:integer;
		tukar: bahanMentah;
	{ALGORITMA PROCEDURE}
	begin
		{Mengurutkan bahan mentah berdasarkan nama bahan mentah}
		for i:=1 to inv.neffMentah-1 do
		begin
			for j:=i to inv.neffMentah do
			begin
				if inv.arrayMentah[j].nama < inv.arrayMentah[i].nama then
				begin
					tukar := inv.arrayMentah[j];
					inv.arrayMentah[j] := inv.arrayMentah[i];
					inv.arrayMentah[i] := tukar;
				end;
			end;
		end;
		
		{menampilkan daftar bahan mentah yang dimiliki}
		writeln('Daftar bahan mentah yang kamu miliki: ');
		writeln('Nama Bahan Mentah | Tanggal Beli | Tanggal Kadaluarsa | Jumlah');
		for i:=1 to inv.neffMentah do
		begin
			write(inv.arrayMentah[i].nama,' | ');
			write(inv.arrayMentah[i].tglBeli.hari,'/');
			write(inv.arrayMentah[i].tglBeli.bulan,'/');
			write(inv.arrayMentah[i].tglBeli.tahun,' | ');
			write(inv.arrayMentah[i].tglKdlMentah.hari,'/');
			write(inv.arrayMentah[i].tglKdlMentah.bulan,'/');
			write(inv.arrayMentah[i].tglKdlMentah.tahun,' | ');
			write(inv.arrayMentah[i].jumlah,' | ');
			writeln();
		end;
	end;

procedure lihatOlahan (var inv: inventoriOlahan); 
	{I.S Daftar bahan olahan pada inventori bahan olahan belum terurut berdasarkan nama}
	{F.S Menampilkan daftar bahan olahan pada inventori bahan olahan terurut berdasarkan nama (a..z)}
	{KAMUS LOKAL}
	var
		i,j:integer;
		tukar:bahanOlahan;
	{ALGORITMA PROCEDURE}
	begin
		{Mengurutkan bahan olahan berdasarkan nama bahan olahan}
		for i:=1 to inv.neffOlahan-1 do
		begin
			for j:= i to inv.neffOlahan do
			begin
				if inv.arrayOlahan[j].nama < inv.arrayOlahan[i].nama then
				begin
					tukar := inv.arrayOlahan[j];
					inv.arrayOlahan[j] := inv.arrayOlahan[i];
					inv.arrayOlahan[i] := tukar;
				end;
			end;
		end;
		
		{menampilkan daftar bahan olahan yang dimiliki}
		writeln('Daftar bahan olahan yang kamu miliki: ');
		writeln('Nama Bahan Olahan | Tanggal Buat | Tanggal Kadaluarsa | Harga Jual | Jumlah');
		for i:=1 to inv.neffOlahan do
		begin
			write(inv.arrayOlahan[i].nama,' | ');
			write(inv.arrayOlahan[i].tglBuat.hari,'/');
			write(inv.arrayOlahan[i].tglBuat.bulan,'/');
			write(inv.arrayOlahan[i].tglBuat.tahun,' | ');
			write(inv.arrayOlahan[i].tglKdlOlahan.hari,'/');
			write(inv.arrayOlahan[i].tglKdlOlahan.bulan,'/');
			write(inv.arrayOlahan[i].tglKdlOlahan.tahun,' | ');
			write(inv.arrayOlahan[i].hargaJual,' | ');
			write(inv.arrayOlahan[i].jumlah,' | ');
			writeln();
		end;
	end;

end.
