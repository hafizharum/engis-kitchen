unit f7;

interface

	uses typetubes2018, f11, f17, f13;

	procedure jualOlahan(var im: inventoriMentah; var io : inventoriOlahan; var data : simulasi; var countMakan : integer; 
						var countIstirahat: integer; var sudahTidur: boolean; isSimulasi: boolean);
	{I.S Jika terdapat nama bahan yang sesuai di inventori bahan mentah, maka dapat melakukan jualOlahan
	 F.S Pesan kesalahan jika tidak ada bahan mentah yang dicari, atau bertambahnya bahan olahan, berkurangnya jumlah bahan mentah , 
		 energi, serta bertambahnya uang jika terdapat nama bahan yang dicari}
		 
implementation
	
	procedure jualOlahan (var im: inventoriMentah; var io : inventoriOlahan; var data : simulasi; var countMakan : integer; 
						var countIstirahat: integer; var sudahTidur: boolean; isSimulasi: boolean);
	{I.S Jika terdapat nama bahan yang sesuai di inventori bahan mentah, maka dapat melakukan jualOlahan
	 F.S Pesan kesalahan jika tidak ada bahan mentah yang dicari, atau bertambahnya bahan olahan, berkurangnya jumlah bahan mentah , 
		 energi, serta bertambahnya uang jika terdapat nama bahan yang dicari}
	
	{Kamus Lokal}
	var 
		i,j : integer;
		found : boolean;
		olahan : string;
	
	{Algoritma}
	begin
	  if (isSimulasi=true) then //jika berada di dalam simulasi
	  begin
		sudahTidur := false;
		
		writeln('>> jualBahanOlahan');
		lihatOlahan(io);
		
		write('Nama bahan olahan yang akan dijual: ');
		readln(olahan);
		
		i := 1;
		found := false;
		
		while (not found) and ( i <= arrMax) do //mencocokkan inputan user dengan nama-nama di daftar inventori olahan
		begin
			if (io.arrayOlahan[i].nama = olahan) then
				found := true
			else
				i := i + 1;
		end;
		
		if (found) then //jika inputan user sesuai dengsn salah satu nama di inventori olahan
		begin
			io.arrayOlahan[i].jumlah := io.arrayOlahan[i].jumlah - 1;
			data.totalUang := data.totalUang + io.arrayOlahan[i].hargaJual;
			data.totalPemasukan := data.totalPemasukan + io.arrayOlahan[i].hargaJual;
			data.jumlahEnergi := data.jumlahEnergi - 1;
			data.totalOlahanDijual := data.totalOlahanDijual+1;
			writeln('Penjualan ',olahan,' sukses');
			writeln('Uang anda bertambah sebanyak ', io.arrayOlahan[i].hargaJual);
			writeln('Energi anda berkurang 1');
		end else
		begin //jika inputan user tidak sesuai dengan nama di inventori olahan 
			writeln(olahan,' tidak ada di inventori, penjualan gagal, silakan coba lagi.');
		end;
		
		if io.arrayOlahan[i].jumlah <= 0 then //jika jumlah bahan olahan setelah dijual 0
		begin
			for j:= i to (io.neffOlahan - 1) do //menghilangkan bahan olahan tersebut dan menggeser bahan setelahnya untuk menempati tempat yang kosong
			begin
				io.arrayOlahan[j] := io.arrayOlahan[j + 1] ;
			end;
			
			io.neffOlahan := io.neffOlahan - 1;
		end;
		
		if data.jumlahEnergi = 0 then //jika energi pemain habis
		begin
			writeln('Energi habis, anda akan tidur.');
			tidur(countMakan, countIstirahat, im, io, sudahTidur, isSimulasi, data ); //melakukan prosedur tidur
		end else
		begin //jika energi pemain masih ada
			writeln('sisa energi anda ', data.jumlahEnergi); //dituliskan sisa energi pemain ke user
		end;
		
	end else //jika simulasi belum dimulai
	begin
		writeln('Simulasi belum dimulai');
	end;
end;

end.

