unit f11;

interface

	uses typetubes2018, f4;
	
	function kabisat(tanggalSimulasi: integer):boolean;
	{fungsi yang mengecek apakah pada suatu tahun kabisat atau tidak}
	
	function cekkadaluarsa(tanggalbahan: tanggal; tanggalSimulasi: tanggal):boolean;
	{fungsi yang mengecek apakah tanggal simulasi sudah lewat dari tanggal kadaluarsan bahan}
	
	procedure remove(var mentah : inventoriMentah; var olahan: inventoriOlahan; tglSimulasi: tanggal);
	{I.S. mengakses array inventori mentah dan array inventori olahan
	 F.S. menghapus inventori mentah atau inventori olahan yang sudah kadaluarsa}
	 
	procedure tidur(var countMakan: integer; var countIstirahat: integer; var mentah: inventoriMentah; var olahan: inventoriOlahan; 
					var sudahTidur: boolean; var isSimulasi: boolean; var stat: simulasi);
	{I.S. mengakses array simulasi, array inventori mentah, array inventori olahan
	 F.S. menghasilkan jumlah energi sebanyak 10 buah dan menambahkan hari simulasi yang sedang berlangsung, serta menghapus data inventori yang kadaluarsa}
	 
implementation
	// FUNGSI KABISAT
	function kabisat(tanggalSimulasi: integer):boolean;
	
	begin
		kabisat := false;
		
		if (tanggalSimulasi mod 100 = 0) and (tanggalSimulasi mod 400 = 0) then
		begin
			kabisat := true;
		end else if (tanggalSimulasi mod 4 = 0) then 
		begin
			kabisat := true;
		end;
	end;
	
	// FUNGSI CEKKADALUARSA
	function cekkadaluarsa(tanggalbahan: tanggal; tanggalSimulasi: tanggal):boolean;
	
	begin
		cekkadaluarsa := false;
		
		if (tanggalSimulasi.tahun > tanggalbahan.tahun) then
		begin
			cekkadaluarsa := true;
		end else if	(tanggalSimulasi.tahun = tanggalbahan.tahun) then
		begin
			if (tanggalSimulasi.bulan > tanggalbahan.bulan) then
			begin
				cekkadaluarsa := true;
			end else if (tanggalSimulasi.bulan = tanggalbahan.bulan) then
			begin
				if (tanggalSimulasi.hari > tanggalbahan.hari) then
				begin
					cekkadaluarsa := true;
				end;
			end;
		end;
	end;

	
	// FUNGSI REMOVE
	procedure remove(var mentah : inventoriMentah; var olahan: inventoriOlahan; tglSimulasi: tanggal);
	
	var
		Neff : integer;
		i : integer;
		j : integer;
		
	begin
		// pada inventori mentah
		Neff := mentah.neffMentah;
		
		for i:= 1 to Neff do
		begin
			if (cekkadaluarsa(mentah.arrayMentah[i].tglKdlMentah,tglSimulasi)) then
			begin
				// jika kadaluarsa fungsi akan melakukan remove dari bahan yang sudah kadaluarsa
				for j := i to Neff do
				begin
					mentah.arrayMentah[j].nama := mentah.arrayMentah[j+1].nama;
					mentah.arrayMentah[j].hargaBeli := mentah.arrayMentah[j+1].hargaBeli;
					mentah.arrayMentah[j].kadaluarsa := mentah.arrayMentah[j+1].kadaluarsa;
					mentah.arrayMentah[j].tglKdlMentah := mentah.arrayMentah[j+1].tglKdlMentah;
					mentah.arrayMentah[j].tglBeli := mentah.arrayMentah[j+1].tglBeli;
				end;
				
				mentah.neffMentah := mentah.neffMentah - 1; // mengurangi jumlah inventori karena sudah dihapus satu
			end;
		end;
		
		//pada inventori olahan
		Neff := olahan.neffOlahan;
		
		for i := 1 to Neff do
		begin
			if (cekkadaluarsa(olahan.arrayOlahan[i].tglKdlOlahan,tglSimulasi)) then
			begin
				// jika kadaluarsa fungsi akan melakukan remove dari bahan yang sudah kadaluarsa
				for j := i to Neff do
				begin
					olahan.arrayOlahan[j].nama := olahan.arrayOlahan[j+1].nama;
					olahan.arrayOlahan[j].hargaJual := olahan.arrayOlahan[j+1].hargaJual;
					olahan.arrayOlahan[j].jumlahBahan := olahan.arrayOlahan[j+1].jumlahBahan;
					olahan.arrayOlahan[j].bahanPembuat := olahan.arrayOlahan[j+1].bahanPembuat;
					olahan.arrayOlahan[j].tglKdlOlahan := olahan.arrayOlahan[j+1].tglKdlOlahan;
					olahan.arrayOlahan[j].tglBuat := olahan.arrayOlahan[j+1].tglBuat;
					
					olahan.neffOlahan := olahan.neffOlahan - 1; // mengurangi jumlah inventori karena sudah dihapus satu
				end;
			end;
		end;
	end;
	
	// FUNGSI Tidur
	procedure tidur (var countMakan: integer; var countIstirahat: integer; var mentah: inventoriMentah; var olahan: inventoriOlahan; 
					var sudahTidur: boolean; var isSimulasi: boolean; var stat: simulasi);
	
	var
		tsb : integer;
		
	begin
		 // jika baru tidur maka tidak bisa tidur lagi, dan jika belum masuk ke simulasi maka tidak bisa tidur
		if ((sudahTidur = false) and (isSimulasi = true)) then
		begin
			// jika jumlah hari belum mencapai 10
			if (stat.jumlahHari < 10) then
			begin
		
				stat.jumlahEnergi := 10;
				countIstirahat := 0; //countMakan dan countIstirahat akan dari 0 lagi karena sudah ganti hari
				countMakan := 0;
				sudahTidur := true;
				stat.jumlahHari := stat.jumlahHari + 1;
			
				tsb := stat.tanggalSimulasi.bulan;
				
				//melakukan penambahan tanggal pada tanggal simulasi
				if (tsb = 1) or (tsb = 3) or (tsb = 5 ) or (tsb = 7) or (tsb = 8) or (tsb = 10) then
				begin
					if (stat.tanggalSimulasi.hari = 31) then
					begin
						stat.tanggalSimulasi.hari := 1;
						stat.tanggalSimulasi.bulan := stat.tanggalSimulasi.bulan + 1;
					end else
					begin
						stat.tanggalSimulasi.hari := stat.tanggalSimulasi.hari + 1;
					end;
				end else if (tsb = 12) then
				begin
					if (stat.tanggalSimulasi.hari = 31) then
					begin
						stat.tanggalSimulasi.hari := 1;
						stat.tanggalSimulasi.bulan := 1;
						stat.tanggalSimulasi.tahun := stat.tanggalSimulasi.tahun + 1;
					end else
					begin
						stat.tanggalSimulasi.hari := stat.tanggalSimulasi.hari + 1;
					end;
				end else if (tsb = 2) then
				begin
					if (kabisat(stat.tanggalSimulasi.tahun)) then
					begin
						if stat.tanggalSimulasi.hari = 29 then
						begin
							stat.tanggalSimulasi.hari := 1;
							stat.tanggalSimulasi.bulan := stat.tanggalSimulasi.bulan + 1;
						end else
						begin
							stat.tanggalSimulasi.hari := stat.tanggalSimulasi.hari + 1;
						end;
					end else
					begin
						if stat.tanggalSimulasi.hari = 28 then
						begin
							stat.tanggalSimulasi.hari := 1;
							stat.tanggalSimulasi.bulan := stat.tanggalSimulasi.bulan + 1;
						end else
						begin
							stat.tanggalSimulasi.hari := stat.tanggalSimulasi.hari + 1;
						end;
					end;
				end else 
				begin
					if stat.tanggalSimulasi.hari = 30 then
					begin
						stat.tanggalSimulasi.hari := 1;
						stat.tanggalSimulasi.bulan := stat.tanggalSimulasi.bulan + 1;
					end else
					begin
						stat.tanggalSimulasi.hari := stat.tanggalSimulasi.hari + 1;
					end;
				end;
			
			//melakukan remove inventori kadaluarsa
				remove(mentah, olahan, stat.tanggalSimulasi);
				writeln('Tidur sudah dilaksanakan. Hari ini adalah hari ke-', stat.jumlahHari);
			
			end else if (stat.jumlahHari >= 10) then // jika jumlah hari lebih dari 10 otomatis akan keluar dari simulasi
			begin
				writeln('Tidur sudah dilaksanakan.');
				writeln('Simulasi sudah mencapai 10 hari. Simulasi selesai.');
				stopSimulasi(isSimulasi,stat);				
			end;
			
		end else if (isSimulasi = false) then
		begin
			writeln('Maaf, simulasi belum berjalan. Silakan mulai simulasi untuk melakukan aksi.');
		end else if (sudahTidur = true) then
		begin
			writeln('Kebanyakan Tidur!');
		end;
	end;
	

	

end.


	{ALGORITMA}
	