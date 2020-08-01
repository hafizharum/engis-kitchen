unit f3;

interface
	uses typetubes2018;

 procedure startSimulasi(var i : integer; var S : inventoriSimulasi; var isSimulasi: boolean);
 {I.S isSimulasi, inventor simulasi pada S, dan indeks I terdefinisi} 
 {F.S Mengeluarkan pilihan2 yang akan dilakukan user dalam program }
  
implementation

  procedure startSimulasi(var i : integer; var S : inventoriSimulasi; var isSimulasi: boolean);
  {I.S isSimulasi, inventor simulasi pada S, dan indeks I terdefinisi} 
  {F.S Mengeluarkan pilihan2 yang akan dilakukan user dalam program }
  { Kamus lokal }
  { Algoritma lokal }
  begin
	isSimulasi := false;
	repeat 
		repeat
			write('Nomor simulasi yang ingin anda mainkan : ');
			readln(i); {Membaca pilihan nomor yang dipilih user}
			
			if i > S.neffSimulasi then {jika inputan nilainya lebih besar dari jumlah pilihan simulasi}
			begin
				writeln('Simulasi yang kamu masukan tidak ada. Ulangi sekali lagi.');
			end;
		until (i <= S.neffSimulasi);
		
		if S.arraySimulasi[i].jumlahHari <= 10 then {jiks hari belum sampai hari ke 10}
		begin
			writeln('Start Simulasi ',i);
			writeln('Selamat datang di Simulasi ', i,' Engis  Kitchen!');
			isSimulasi := true;
		end else {hari sudah mencapai hari ke 10}
		begin
			writeln('Simulasi yang ingin kamu mainkan tidak lagi memiliki hari yang tersisa.');
			writeln('Silakan coba nomor simulasi lain');
		end;
	until (isSimulasi);
  end;
end.
