unit f12;

interface

uses typetubes2018;

procedure lihatStatistik (var Stat: simulasi; isSimulasi: boolean);
	{I.S Informasi-informasi dalam data simulasi yang bersangkutan}
	{F.S Menampilkan informasi-informasi dalam bentuk statistik simulasi yang bersangkutan}

implementation

procedure lihatStatistik (var Stat: simulasi; isSimulasi: boolean);
	{I.S Menggabungkan informasi-informasi dalam data simulasi yang bersangkutan apabila sedang berada dalam simulasi}
	{F.S Jika berada dalam simulasi akan ditampilkan informasi-informasi dalam bentuk statistik simulasi yang bersangkutan
		 Jika tidak berada dalam simulasi maka akan ditampilkan pemberitahuan untuk memulai simulasi terlebih dahulu}
	{ALGORITMA PROCEDURE}
	begin
		if isSimulasi = true then
		begin
		
			writeln('Nomor Simulasi : ', Stat.nomor);
			writeln('Tanggal : ', Stat.tanggalSimulasi.hari, '/', Stat.tanggalSimulasi.bulan, '/', Stat.tanggalSimulasi.tahun);
			writeln('Hari ke-', Stat.jumlahHari);
			writeln('Energi : ', Stat.jumlahEnergi);
			writeln('Kapasitas Maksimum Inventori Bahan Mentah: ', Stat.maksInvMentah);
			writeln('Kapasitas Maksimum Inventori Bahan Olahan: ', Stat.maksInvOlahan);
			writeln('Total Bahan Mentah yang Dibeli: ', Stat.totalMentahDibeli);
			writeln('Total Bahan Olahan yang Dibuat: ', Stat.totalOlahanDibuat);
			writeln('Total Bahan Olahan yang Dijual : ', Stat.totalOlahanDijual);
			writeln('Total Resep yang Dijual : ', Stat.totalResepDijual);
			writeln('Total Pemasukan: ', Stat.totalPemasukan);
			writeln('Total Pengeluaran : ', Stat.totalPengeluaran);
			writeln('Total Uang : ', Stat.totalUang);
			
		end else
		begin
			writeln('Simulasi belum dimulai. Silakan mulai dahulu simulasi');
		end;
	end;

end.
