unit f14;

interface

uses typetubes2018;

procedure lihatResep (var arrResep  : inventoriResep);
{	melihat data daftar resep yang tersedia yang ditampilkan secara terurut membesar berdasarkan
	nama resep	}
{ I.S. : kumpulan resep dalam arrResep sudah terdefinisi }
{ F.S. : arrResep beserta keterangannya tertulis di layar secara terurut membesar }

implementation

procedure lihatResep (var arrResep  : inventoriResep);

var
	i, 												{indeks nama resep}
	j					: integer	;				{indeks karakter pada nama resep}
	temp				: resep;					{wadah menukar}
	
begin
	writeln ('** Daftar Resep Makanan **');
	writeln ('----------------------------');
	
	
	
	(* MENGURUTKAN NAMA RESEP *)
	for i := 1 to arrResep.neffResep - 1 do
	begin
		for j := i to arrResep.neffResep do 
		begin
			if arrResep.arrayResep[j].nama < arrResep.arrayResep[i].nama then
			begin
				temp := arrResep.arrayResep[j];
				arrResep.arrayResep[j] := arrResep.arrayResep[i];
				arrResep.arrayResep[i] := temp;
			end;
		end;
	end;
	
	for i := 1 to arrResep.neffResep do
	begin
		write (i, '.', #9);
		writeln (arrResep.arrayResep[i].nama);
		write ('	Harga Jual = ', arrResep.arrayResep[i].hargaJual); writeln;
		write ('	Jumlah Bahan = ', arrResep.arrayResep[i].jumlahBahan);		writeln;
		writeln ('	Bahan Pembuat = ');
		
		for j := 1 to arrResep.arrayResep[i].jumlahBahan do
		begin
			write ('	- ', arrResep.arrayResep[i].bahanPembuat[j]); writeln;
		end;
		
		writeln;
	end;
end;

end.