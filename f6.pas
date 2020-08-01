unit F6;

interface

uses typetubes2018, f11, f17 ;

procedure OlahBahan(var invM : inventoriMentah; var invO:inventoriOlahan; var arrOlahan : tabOlahan; var S : simulasi; var countMakan : integer; 
					var countIstirahat : integer; var sudahTidur : boolean; var isSimulasi: boolean);
{I.S : Mencampur beberapa barang mentah untuk diolah menjadi bahan olahan }
{F.S : Bahan olahan terbentuk}


implementation
	
	procedure OlahBahan(var invM : inventoriMentah; var invO:inventoriOlahan; var arrOlahan : tabOlahan; var S : simulasi; var countMakan : integer; 
						var countIstirahat : integer; var sudahTidur : boolean; var isSimulasi: boolean);
	{I.S : Mencampur beberapa barang mentah untuk diolah menjadi bahan olahan }
	{F.S : Bahan olahan terbentuk}
	
	{ Kamus lokal }
	
	var
	 a, k, l , N, count, i, j, neff: integer;
	 namaOlahan, upgrade : string;
	 found	: boolean;
	 
	{ Algoritma lokal }
	begin
	  if (isSimulasi=true) and (invO.neffOlahan < S.maksInvOlahan) then {jika simulasi telah dimulai dan inventori bahan olahan mencukupi}
	  begin
		writeln('Daftar Nama Bahan Olahan yang Dapat Dibuat');
		for i := 1 to arrOlahan.neffOlahan do
		begin
			writeln('- ',arrOlahan.arrBahanOlahan[i].nama); {menampilkan list nama olahan yang dapat dibuat}
		end;
	
		sudahTidur := false; {mengubah sudahTidur menjadi false agar procedure tidur bisa dijalankan setelah menjalankan procedure b ini}
		writeln('Nama Olahan Yang Ingin Dibuat : ');
		readln(namaOlahan);
		a:= 1;
		
		repeat
			if (namaOlahan = arrOlahan.arrBahanOlahan[a].nama) then {jika nama olahan yang dimasukkan user sama dengan yang ada di list nama olahan yang dapat dibuat}
			begin
				N := arrOlahan.arrBahanOlahan[a].jumlahBahan; {jumlah bahan mentah untuk membuat bahan olahan}
				writeln('Bahan pembuatnya : ');
				
					for k:= 1 to N do
					begin
						writeln(arrOlahan.arrBahanOlahan[a].bahanPembuat[k]);
					end;
					
					count:= 0;
					
					for l:= 1 to N do
					begin
					
						found := false;
						for i := 1 to invM.neffMentah do
						begin
						
							if (arrOlahan.arrBahanOlahan[a].bahanPembuat[l] = invM.arrayMentah[i].nama) then
							begin
								count := count +1;
								found := true;
							end;
							
							if (found = false) and (i = invM.neffMentah) then
							begin
								writeln(arrOlahan.arrBahanOlahan[a].bahanPembuat[l],' tidak ada dalam inventori mentah mu!');
							end;
						end;
						
					end;
					
					
					if (count = N) and (S.jumlahEnergi >= 1) then
					begin
						for l:= 1 to N do
						begin
							for i := 1 to invM.neffMentah do
							begin
						
								if (arrOlahan.arrBahanOlahan[a].bahanPembuat[l] = invM.arrayMentah[i].nama) then
								begin
									invM.arrayMentah[i].jumlah := invM.arrayMentah[i].jumlah - 1;
								end;
							end;
						end;	
						
						S.jumlahEnergi := S.jumlahEnergi-1;
						S.totalOlahanDibuat := S.totalOlahanDibuat+1;
						writeln('Bahan olahan ',namaOlahan,' sudah dibuat!');
						writeln('Energi anda berkurang 1'); 
						
						// Mengurangi inventori bahan mentah
						neff := invM.neffMentah;
						
						for i:= 1 to neff do
						begin
							if (invM.arrayMentah[i].jumlah <= 0) and (i <= invM.neffMentah) then
							begin
	
								for j := i to neff do
								begin
									invM.arrayMentah[j] := invM.arrayMentah[j+1];
								end;
				
								invM.neffMentah := invM.neffMentah - 1;
								
							end;
						end;
						
						// Menambah inventori bahan olahan
						
						invO.neffOlahan := invO.neffOlahan + 1;
						
						invO.arrayOlahan[invO.neffOlahan].nama := arrOlahan.arrBahanOlahan[a].nama;
						invO.arrayOlahan[invO.neffOlahan].tglBuat := S.tanggalSimulasi;
						invO.arrayOlahan[invO.neffOlahan].jumlah := invO.arrayOlahan[invO.neffOlahan].jumlah + 1;
						invO.arrayOlahan[invO.neffOlahan].hargaJual := arrOlahan.arrBahanOlahan[a].hargaJual;
						tglKadaluarsaO (invO.arrayOlahan[invO.neffOlahan], S);
						
						if S.jumlahEnergi = 0 then
						begin
							tidur(countMakan, countIstirahat, invM,invO,sudahTidur, isSimulasi, S); 
							{memanggil prosedur tidur karena secara otomatis lgsg tertidur jika energinya sudah habis}
						end else
						begin
							writeln('sisa energi anda ', S.jumlahEnergi);
						end;
					end;
			end;
						
			
			
			a := a + 1;
			
		until(namaOlahan = arrOlahan.arrBahanOlahan[a-1].nama);
		
	  end else if (isSimulasi) and (invO.neffOlahan >= S.maksInvOlahan) then {jika inventori penuh}
	  begin
		writeln('Inventori penuh! Apakah kamu ingin upgrade inventorimu? Ya/Tidak?');
			repeat
				readln(upgrade);
				
				if (upgrade = 'Ya') then
				begin
					upInvOlahan(S);
				
					if not(cukupUang(S.TotalUang, S)) then
					begin
						writeln('Uangmu tidak mencukupi untuk upgrade inventori:(');
					end else
					begin
						writeln('Inventorimu sudah diupgrade!');
						writeln('Silakan ulangi perintah OlahBahan');
					end;
				
				end else if (upgrade = 'Tidak') then
				begin
					writeln('Pengolahan bahan gagal. Inventorimu penuh.');
				end else if (upgrade <> 'Ya') or (upgrade <> 'Tidak') then
				begin
					writeln('Pilihanmu belum benar. Ya/Tidak?');
				end;
			
				until (upgrade = 'Ya') or (upgrade = 'Tidak');
		
	  
	  end else if (isSimulasi = false) then {jika simulasi belum dijalankan}
		begin
		writeln('Simulasi belum dimulai');
		end;
	end;
end.
