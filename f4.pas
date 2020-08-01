unit f4;

interface

uses typetubes2018, f12;


procedure stopSimulasi (var sim: boolean; var stat: simulasi);
	{I.S Dicek keadaan apakah ada simulasi yang sedang berjalan atau tidak}
	{F.S Jika ada simulasi yang sedang berjalan maka simulasi yang bersangkutan berhenti dan menampilkan statistik simulasi yang dihentikan
	     Jika tidak ada simulasi yang berjalan akan ditampilkan pemberitahuan bahwa simulasi belum dimulai}

implementation

procedure stopSimulasi (var sim: boolean; var stat: simulasi);
	{I.S}
	{F.S}
	{ALGORITMA PROCEDURE}
	begin
	
	if sim = true then
	begin
		writeln('Kamu telah keluar dari simulasi!');
		writeln('Berikut adalah statistikmu.');
		
		lihatStatistik(stat, sim);
		sim := false;
	end else
	begin
		writeln('Simulasi belum dimulai. Mulai dahulu simulasi.');
	end;
	
end;

end.
