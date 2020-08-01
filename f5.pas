unit f5;

interface

uses typetubes2018,f11, f17;

const upgradeInv = 25000;

var
 S : simulasi;
	
procedure lihatBarangMentah (var listbrgmentah : tabMentah);
{ Mengecek list barang mentah yang ada di supermarket }

procedure beliBarangMentah (var invMentah : inventoriMentah; var TBahanMentah : tabMentah; var invOlahan : inventoriOlahan; var S : simulasi;
								var pembelian : integer;  var countMakan: integer; var countIstirahat: integer; var sudahTidur: boolean; var isSimulasi: boolean);
{ Membeli barang mentah yang ada di supermarket dan memasukkannya ke dalam inventori bahan mentah}


implementation	
	
	procedure lihatBarangMentah (var listbrgmentah : tabMentah);
	{I.S : untuk mengecek list barang mentah yang ada di supermarket }
	{F.S : mengeluarkan list bahan mentah yang ada di supermarket}
	{ Kamus lokal }
	var
	i : integer;
	{ Algoritma lokal }
	begin
		for i := 1 to listbrgmentah.neffMentah do
		begin
			writeln('- ',listbrgmentah.arrBahanMentah[i].nama);
		end;
	end;
	
	
	
    procedure beliBarangMentah(var invMentah : inventoriMentah; var TBahanMentah : tabMentah; var invOlahan : inventoriOlahan; var S : simulasi;
								var pembelian : integer;  var countMakan: integer; var countIstirahat: integer; var sudahTidur: boolean; var isSimulasi: boolean);
    {I.S : untuk mengecek list barang mentah yang ada di supermarket }
	{F.S : mengeluarkan list bahan mentah yang ada di supermarket}
	{ Kamus lokal }	
	var
	
	 BahanYangDibeli : string;
	 i,z : integer;
	 upgrade : string;
	 harga : longint;
	 
	{ Algoritma lokal}
	begin
	  if (isSimulasi=true) then {Menjalankan procedure hanya saat simulasi telah dijalankan}
	  begin
	  
		sudahTidur := false; {mengubah sudahTidur menjadi false agar procedure tidur bisa dijalankan setelah menjalankan procedure beliBarangMentah ini}
		
		writeln('Daftar Nama Bahan Mentah yang Tersedia di Supermarket:');
		lihatBarangMentah(TBahanMentah); {memanggil procedure untuk melihat list barang mentah yang ada di supermarket}
		writeln('Mau beli apa?');
		readln(BahanYangDibeli); {menuliskan bahan yang ingin dibeli}
		
		if (invMentah.neffMentah >= S.maksInvMentah) then {Jika inventori mentah sudah penuh}
		begin
			
			pembelian := upgradeInv;
			writeln('Inventori penuh! Apakah kamu ingin upgrade inventorimu? Ya/Tidak?');
			
			repeat
			
			readln(upgrade); {membaca pilihan user apakah ingin mengupgrade inventorinya atau tidak}
			if (upgrade = 'Ya') then
			begin
				upInvMentah(S, pembelian); {memanggil procedure untuk mengupgrade inventori bahan mentah}
				
				if not(cukupUang(pembelian, S)) then {dicek dulu, jika uang yang dimiliki tidak mencukupi untuk mengupgrade}
				begin
					writeln('Uangmu tidak mencukupi untuk upgrade inventori:(');
				end else {jika uang mencukupi untuk mengupgrade inventori}
				begin
					writeln('Inventorimu sudah diupgrade!');
					
					for i:= 1 to TBahanMentah.neffMentah do
					begin
			
						if (TBahanMentah.arrBahanMentah[i].nama = BahanYangDibeli) then {jika bahan mentah yang dibeli ada dalam list bahan mentah di supermarket}
						begin
							harga := TBahanMentah.arrBahanMentah[i].hargaBeli; {mengambil harga beli dari barang mentah yang dijual}
					
							if (cukupUang(harga, S)) then {jika uang mencukupi harga beli barang mentah}
							begin
					
							z := invMentah.neffMentah + 1; 
						
							invMentah.arrayMentah[z].nama := TBahanMentah.arrBahanMentah[i].nama; {memasukkan barang mentah yang dibeli ke dalam inventori bahan mentah}
							invMentah.arrayMentah[z].tglBeli := S.tanggalSimulasi; {tanggal dibeli dimasukkan untuk dihitung tanggal kadaluarsanya}
						
							writeln('Mau beli berapa?');
							readln(invMentah.arrayMentah[z].jumlah); {membaca banyaknya bahan mentah yang dibeli}
						
							tglKadaluarsaM(invMentah.arrayMentah[z], TBahanMentah.arrBahanMentah[i].kadaluarsa, S);
					
							writeln('Barang mentah sudah masuk ke inventori!');	
								
							invMentah.neffMentah := invMentah.neffMentah + 1; {jumlah inventori bertambah}
							S.jumlahEnergi := S.jumlahEnergi - 1; {karena sudah membeli bahan, energi berkurang}
							S.totalMentahDibeli := S.totalMentahDibeli+1;
							S.totalUang := S.totalUang - TBahanMentah.arrBahanMentah[i].hargaBeli;
							S.totalPengeluaran := S.totalPengeluaran + TBahanMentah.arrBahanMentah[i].hargaBeli;
							end;
					
						end;
					end;
				end;
			end else if (upgrade = 'Tidak') then
			begin
				writeln('Pembelian gagal. Inventorimu penuh.');
			end else if (upgrade <> 'Ya') or (upgrade <> 'Tidak') then
			begin
				writeln('Pilihanmu belum benar. Ya/Tidak?');
			end;
			
			until (upgrade = 'Ya') or (upgrade = 'Tidak');
			
		end else if (invMentah.neffMentah < S.maksInvMentah) and (S.jumlahEnergi >=1) then { inventori dan uang mencukupi }
		begin
			
			for i:= 1 to TBahanMentah.neffMentah do
			begin
			
				if (TBahanMentah.arrBahanMentah[i].nama = BahanYangDibeli) then
				begin
					pembelian := TBahanMentah.arrBahanMentah[i].hargaBeli;
					
					if (cukupUang(pembelian, S)) then
					begin
					
						z := invMentah.neffMentah + 1;
						
						invMentah.arrayMentah[z].nama := TBahanMentah.arrBahanMentah[i].nama;
						invMentah.arrayMentah[z].tglBeli := S.tanggalSimulasi;
						
						writeln('Mau beli berapa?');
						readln(invMentah.arrayMentah[z].jumlah);
						
						tglKadaluarsaM(invMentah.arrayMentah[z], TBahanMentah.arrBahanMentah[i].kadaluarsa, S);
					
								
						invMentah.neffMentah := invMentah.neffMentah + 1;
						S.jumlahEnergi := S.jumlahEnergi - 1;
						S.totalMentahDibeli := S.totalMentahDibeli+1;
						S.totalUang := S.totalUang - TBahanMentah.arrBahanMentah[i].hargaBeli;
						S.totalPengeluaran := S.totalPengeluaran + TBahanMentah.arrBahanMentah[i].hargaBeli;
						
						writeln(invMentah.arrayMentah[z].nama,' sudah masuk ke inventori bahan mentah!');	
						writeln('Sisa uang anda ',S.totalUang);
						writeln('Energi anda berkurang 1');
						
						if (S.jumlahEnergi=0) then {jika energi sudah habis maka akan otomatis tidur}
						begin
							writeln('Energimu  habis! Program akan otomatis menjalankan tidur...');
							tidur(countMakan, countIstirahat, invMentah,invOlahan,sudahTidur, isSimulasi, S); {otomatis tidur kalau energinya sudah habis}
						end else
						begin
							writeln('Sisa energi anda ', S.jumlahEnergi);
						end;
						
					end else if (not(cukupUang(pembelian,S))) then {jika uang tidak mencukupi untuk membali barang}
					begin
						writeln('Maaf, uangmu tidak cukup untuk melakukan pembelian ini. Pembelian gagal dilaksanakan.');
					end;
				end;
			end;
			
			
			
		end;
		end else if (isSimulasi = false) then {jika simulasi belum dijalankan}
		begin
			writeln('Simulasi belum dimulai');
		end;
	end;
end.
