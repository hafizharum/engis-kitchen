unit f16;

interface
	uses typetubes2018;
	
	procedure tambahResep (var arrResep : inventoriResep; var arrMentah : tabMentah ;var arrOlahan : tabOlahan);
	{ 	melakukan penambahan resep dari minimum 2 bahan pembuat per resep, bahan pembuat yang digunakan
	harus tersedia, dan harga minimumnya menjadi 12.5 % lebih besar dari total harga bahan pembuat	}
	{ I.S. : arrBahanMentah dan arrBahanOlahan terdefinisi, arrResep juga telah terdefinisi jika sudah ada
	yang tersedia di inventori, jika belum inventori resep masih 0 }
	{ F.S. : nama resep sekaligus keterangannya dalam arrResep akan bertambah }

implementation

	procedure tambahResep (var arrResep : inventoriResep; var arrMentah : tabMentah ;var arrOlahan : tabOlahan);
	var		
		Nbahan,										//jumlah bahan yang diperlukan
		ibahan,										//indeks bahan yang diperlukan
		a, imentah, iolahan	: integer;		//pembantu validasi
		namaresep			: string;
		namabahan			: array [arrMin..arrMax] of string;
		found				: boolean;
		hargabahan 			: array[arrMin..arrMax] of longint;


	begin
		writeln('Selamat datang di TambahResep!');
		write('> Masukan nama resep inovasimu: ');
		readln	(namaresep);
		write('> Masukan jumlah bahan yang dibutuhkan: ');
		repeat
			readln	(Nbahan);
		
			if (Nbahan < 2) then	
			begin
				writeln ('Maaf, masukan salah. Resep harus terdiri atas minimum 2 jenis bahan!');
				writeln('Silakan masukkan kembali jumlah bahan: ');
			end else
			begin
				a := 0;
				writeln ('Bahan pembuat: ');
				
				for ibahan := 1 to Nbahan do
				begin
					readln (namabahan[ibahan]);
					found := false;
					
					for imentah := 1 to arrMentah.neffMentah do
					begin
						if (namabahan[ibahan] = arrMentah.arrBahanMentah[imentah].nama) then
						begin
							found := true;
							hargabahan[ibahan] := arrMentah.arrBahanMentah[imentah].hargaBeli;
						end;
					end;
					
					if (found = false) then
					begin
					
						for iolahan := 1 to arrOlahan.neffOlahan do
						begin
							if (namabahan[ibahan] = arrOlahan.arrBahanOlahan[iolahan].nama) then
							begin
								found := true;
								hargabahan[ibahan] := arrOlahan.arrBahanOlahan[iolahan].hargaJual;
							end;
						end;
					end;
					
					if (found = true) then
					begin
						a := a + 1;
					end;
				end;
			end;
		until (Nbahan >= 2);
	
		if ( a = Nbahan ) then
		begin
			arrResep.neffResep := arrResep.neffResep + 1;
			
			arrResep.arrayResep[arrResep.neffResep].nama := namaresep ;
			arrResep.arrayResep[arrResep.neffResep].jumlahBahan := Nbahan;
			
			for ibahan := 1 to Nbahan do
			begin
				arrResep.arrayResep[arrResep.neffResep].hargaJual := arrResep.arrayResep[arrResep.neffResep].hargaJual + hargabahan[ibahan];
				arrResep.arrayResep[arrResep.neffResep].bahanPembuat[ibahan] := namabahan[ibahan];
			end;
			
			arrResep.arrayResep[arrResep.neffResep].hargaJual := trunc(arrResep.arrayResep[arrResep.neffResep].hargaJual * 0.125);
			
			writeln('Resep ', namaresep,' berhasil ditambahkan!');
		end else
		begin
			writeln('Penambahan resep gagal! Bahan tidak ditemukan.');
		end;
	end;
end.