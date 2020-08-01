unit f9;

interface

	uses typetubes2018;
	
	procedure makan(var jEnergi: integer; var countMakan : integer; var sudahTidur: boolean; var isSimulasi: boolean);
	{I.S. mengakses data pada array simulasi
	 F.S. menambahkan jumlah energi sebanyak 3 buah pada data array simulasi}
	 
implementation
	// Fungsi Makan
	procedure makan(var jEnergi: integer; var countMakan : integer; var sudahTidur: boolean; var isSimulasi: boolean);
	
	var
		total : integer;
		
	begin
		if isSimulasi = true then // jika berada dalam simulasi
		begin
		
			if countMakan < 3 then 
			begin
				total := jEnergi + 3;
			
				if (total > 10) then total := 10; // maksimum energi sebanyak 10 buah
		
				jEnergi := total;
				countMakan := countMakan + 1;
				sudahTidur := false;
				
				writeln('Makan sudah selesai!');
				writeln('Energimu sekarang ', jEnergi);
				
			end else // jika makan sudah lebih dari 3 kali dalam sehari
			begin
				writeln('Kebanyakan Makan!');
			end;	
		end else // jika belum masuk ke simulasi
		begin
			writeln('Simulasi belum dimulai. Mulai simulasi untuk melakukan aksi ini.');
		end;
	end;
end.
	