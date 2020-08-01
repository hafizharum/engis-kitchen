unit f8;

interface

	uses typetubes2018, f11, f14;
	
	procedure jualResep(var im : inventoriMentah ; var io : inventoriOlahan; var data : simulasi; var countMakan : integer; 
						var countIstirahat: integer; var sudahTidur: boolean; var isSimulasi: boolean; var arrResep: inventoriResep);
	{I.S. mengakses data pada array simulasi
	 F.S. menghasilkan pesan kesalahan jika bahan untuk membuat resep tidak ada, atau mengurangi jumlah bahan mentah atau olahan 
	      yang dipakai, mengurangi energi, serta menambah uang jika bahan untuk membuat resep ada}
		  
	procedure cekAda (var res : resep; var im : inventoriMentah ;var io : inventoriOlahan; var cek : boolean);
	{I.S. terdapat nama resep yang ingin dibuat
	 F.S. menghasilkan boolean yang bernilai true apabila bahan bahan untuk membuat resep tersebut ada di inventori bahan mentah}
	 
implementation

	procedure cekAda (var res : resep; var im : inventoriMentah ;var io : inventoriOlahan; var cek : boolean);
	{I.S. terdapat nama resep yang ingin dibuat
	 F.S. menghasilkan boolean yang bernilai true apabila bahan bahan untuk membuat resep tersebut ada di inventori bahan mentah}
	
	{Kamus Lokal}
	var
		found : boolean;
		i,j : integer;
	
	{Algoritma}
	begin
		found := true;
		i := 1;
		
		while (found) and (i <= res.jumlahBahan) do //selama variabel found masih bernilai true
		begin
			found := false; //found dianggap false terlebih dahulu
			j := 1;
			
			while (not found) and (j <= im.neffMentah) do //selama found masih bernilai false dan nilai j belum melebihi neff inventori mentah
			begin
				if im.arrayMentah[j].nama =  res.bahanPembuat[i] then // jika nama bahan pembuat resep sama dengan nama di inventori mentah
					found := true
				else
					j := j + 1;
			end;
			
			if (not found) then //jika found bernilai false
			begin
				j := 1;
				while (not found) and (j <= io.neffOlahan) do //selama found masih bernilai false dan nila ij belum melebihi neff inventori olahan
				begin
					if io.arrayOlahan[j].nama =  res.bahanPembuat[i] then
						found := true
						
					else
						j := j + 1;
				end;
			end;
			i := i + 1;
		end;
		
		cek := found; //memasukkan nilai found ke cek
	end;
		
	procedure jualResep(var im : inventoriMentah ; var io : inventoriOlahan; var data : simulasi; var countMakan : integer; 
						var countIstirahat: integer; var sudahTidur: boolean; var isSimulasi: boolean; var arrResep: inventoriResep);
	{I.S. mengakses data pada array simulasi
	 F.S. menghasilkan pesan kesalahan jika bahan untuk membuat resep tidak ada, atau mengurangi jumlah bahan mentah atau olahan 
	      yang dipakai, mengurangi energi, serta menambah uang jika bahan untuk membuat resep ada}
	
	{Kamus Lokal}
	var
		i,j,k : integer;
		pass, found, foundNama : boolean;
		res	: resep;
	
	{Algoritma}
	begin
		
	  if (isSimulasi = true) then //jika sudah ada di dalam simulasi
	  begin
	  	sudahTidur := false; //variabel sudahTidur dijadikan bernilai false
		
		lihatResep(arrResep); //memanggil prosedur lihatResep
		writeln('Resep yang ingin anda jual : ');
		readln(res.nama); //menerima inputan pengguna untuk variabel res.nama
		foundNama := false;
		i := 1;
		
		while (not foundNama) and ( i <= arrResep.neffResep) do //selama foundNama bernilai false dan nilai i belum melebihi neff list resep
		begin
			if arrResep.arrayResep[i].nama = res.nama then //jika res.nama sama dengan nama resep di list resep
			begin
				foundNama := true;
				res := arrResep.arrayResep[i]; //foundNama bernilai true dan data - data di array resep dimasukkan ke variabel res 
			end else
			begin //jika res.nama tidak sama dengan nama resep di list resep
				i := i + 1;
			end;
		end;
				
		
		if (not foundNama) then //jika foundNama bernilai false (inputan pengguna tidak ada di list resep)
		begin
			writeln(res.nama,' tidak ada di daftar resep.');
		end else //jika foundNama bernilai true
		begin
			cekAda(res, im, io, pass); //memanggil prosedur cekAda
			
			if pass then //jika pass bernilai true
			begin
				i := 1;
				
				while (i <= res.jumlahBahan) do //selama nilai i belum melebihi res.jumlahBahan 
				begin
					found := false;
					j:= 1;
					while (not found) and (j <= im.neffMentah) do  //selama found masih bernilai false dan nilai j belum melebihi neff inventori mentah
					begin
						if (res.bahanPembuat[i] = im.arrayMentah[j].nama) then //jika bahan pembuat resep sama dengan nama bahan mentah
						begin
							found := true;
						end else //jika bahan pembuat resep tidak sama dengan nama bahan mentah
						begin
							j := j +1;
						end;
					end;
					
					if found then //jika found bernilai true
					begin
						im.arrayMentah[j].jumlah:= im.arrayMentah[j].jumlah - 1; //mengurangi jumlah bahan yang sesuai
						if im.arrayMentah[j].jumlah = 0 then //jika jumlah bahan menjadi 0
						begin
							for k:= j to (im.neffMentah - 1) do //menghilangkan bahan tersebut di inventori mentah lalu menggeser agar bahan-bahan selanjutnya menempati tempat yang kosong
							begin
								im.arrayMentah[k] := im.arrayMentah[k + 1] ;
							end;
							
							im.neffMentah := im.neffMentah - 1;
						end;
					end else //found bernilai false
					begin
						j := 1;
						while (not found) do //selama found masih bernilai false
						begin
							if res.bahanPembuat[i] = io.arrayOlahan[j].nama then //jika bahan pembuat resep sama dengan nama bahan olahan
							begin
								found := true;
							end else
							begin
								j := j + 1;
							end;
						end;
						
						io.arrayOlahan[j].jumlah:= io.arrayOlahan[j].jumlah - 1; //mengurangi jumlah bahan yang sesuai
						
						if io.arrayOlahan[j].jumlah = 0 then  //jika jumlah bahan menjadi 0
						begin
							for k:= j to (io.neffOlahan - 1) do //menghilangkan bahan tersebut di inventori olahan lalu menggeser agar bahan-bahan selanjutnya menempati tempat yang kosong
							begin
								io.arrayOlahan[k] := io.arrayOlahan[k + 1] ;
							end; 
							io.neffOlahan := io.neffOlahan - 1;
						end;
						
					end;
					i:= i +1;
				end;
				
				data.totalOlahanDijual := data.totalOlahanDijual+1; //menambah data totalOlahanDijual
				data.jumlahEnergi := data.jumlahEnergi - 1; //mengurangi energi
				data.totalUang := data.totalUang + res.hargaJual; //menambah total uang
				data.totalPemasukan := data.totalPemasukan + res.hargaJual; //menambah total pemasukan
				data.totalResepDijual := data.totalResepDijual + 1; //menambah data totalResepDijual
				writeln('Resep berhasil dijual!');
				writeln('Uang anda bertambah sebanyak ',res.hargaJual);
				writeln('Energi anda berkurang 1.');
				
				if data.jumlahEnergi = 0 then //jika energi 0
				begin
					writeln('Energimu habis! Kamu akan otomatis tidur.');
					tidur(countMakan, countIstirahat, im, io, sudahTidur, isSimulasi, data); //memanggil prosedur tidur
				end else //jika energi tidak 0
				begin
					write('sisa energi anda ', data.jumlahEnergi);
				end;
				
			end else //pass bernilai false
			begin
				writeln('Bahan tidak ada di inventori. Pembuatan resep gagal.');
			end;
				
			
		end;
	 end else {isSimulasi=false}
	 begin
		writeln('Simulasi belum dimulai');
	 end;
  
  end;
end.
