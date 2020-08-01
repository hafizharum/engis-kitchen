unit f15;

interface
	
	uses typetubes2018;
	
	procedure cariResep (var arrResep{resep} : inventoriResep);
	{	melakukan pencarian resep, kalau input ada, ditampilkan nama resep beserta data lainnya yang sesuai,
	kalau input tidak sesuai, akan menampilkan pesan kesalahan	}
	{ I.S. : arrResep telah terdefinisi }
	{ F.S. : arrResep indeks ke-i akan tertulis di layar beserta keterangan lainnya sesuai dengan pencarian
	nama resep yang diinginkan }

implementation
	procedure cariResep (var arrResep{resep} : inventoriResep);
	
	var
		a		: integer;	{mengecek apakah ada resep yang dicari}
		i		: integer;	{indeks daftar resep}
		j 		: integer;
		cari	: string;
		found	: boolean;
	
	begin
		repeat
			found := false;
			a := 0;
			write('> Masukkan nama resep:');
			readln(cari);
	
			for i := 1 to arrResep.NeffResep do
			begin
				if (cari = arrResep.arrayResep[i].nama) then
				begin
					writeln('Nama Resep : ', arrResep.arrayResep[i].nama);
					
					writeln('Harga Jual : ', arrResep.arrayResep[i].hargaJual);
					
					writeln('Bahan yang diperlukan : ');
			
					for j := 1 to arrResep.arrayResep[i].jumlahBahan do
					begin
						writeln('- ', arrResep.arrayResep[i].bahanPembuat[j]);
					end;
					
					found := true;
			
				end else
				begin
					a := a + 1;
				end;
			end;
	
			if (a = arrResep.NeffResep) then
			begin
				writeln ('Resep yang Anda cari tidak ditemukan! Coba lagi.');
			end;
			
		until (found);
		
		
	end;
end.