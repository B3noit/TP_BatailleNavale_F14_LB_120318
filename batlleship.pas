PROGRAM BatlleShip;
//BUT:Créer un jeu de bataille navale  

{PRINCIPE:On délimite une valeur maximum et minimum que nos numéros de lignes et colonnes peuvent prendre (cela constitue notre "grille"),
		 	les bateaux sont ensuite créé, la valeur maximum qui est attribuer de manière aléatoire à leurs lignes et colonnes sont	comprises dans la grille,
		 	les flottes sont constituer des bateaux, tant qu'il reste des bateau l'état de la flotte est dite à flots, tant les flottes sont à flots,
		 	les deux joueurs sont dans un état de gagne. On demande au joueur des coordonnées, une ligne et une colonne, on obtient une variable du type enregistrement cellule,
		 	on compare la cellule obtenue avec les cellues contenues dans les tableaux des bateaux si cela correspond, la valeur de la cellule est remplacé
		 	et le tableau "perd" une case, lorsque la valeurs de l'état atrribué au bateau  est égal à 0 le bateau est dit coulé, lorsque le nombre de bateaux coulés
		 	est égale au nombre de bateaux initiaux dans la flotte,l'état de la flotte passe à sombrée et l'état du joueur dont la flotte à sombré passe à "perd", 
		 	Lorsque qu'un joueur perd, l'autre gagne.}

//ENTREE:Les coordonnées (ligne,colonne) que chaque joueur entre tour à tour pour attaquer la flotte de son adversaire, 

{SORTIE:Le jeu indique au joueur si un bateau est touché ou non, il indique aussi si le bateau a coulé si il a été suffisamment touché,
		le joueur qui remporte la partie est aussi indiqué}



USES crt;


CONST

	MINL=1;	
	MAXL=6;	
	MINC=1;
	MAXC=6;
	MINBATEAU=0;
	MAXBATEAU=2;	
	MAXCASE=5;	

TYPE

	cellule = RECORD
		ligne:integer;
		col:integer;
	end;
	
	bateau = RECORD
		nCase:array [1..MAXCASE] of cellule;
		taille:integer;
	end;
	
	flotte = RECORD
		nBateau:array [MINBATEAU..MAXBATEAU] of bateau;
	end;


	etatJoueur=(gagne,perd);
	positionBateau=(enLigne,enColonne,enDiag);	
	etatBateau=(toucher,couler);	
	etatFlotte=(aFlot,aSombrer);	
	


function tailleBateau(nBateau:bateau):integer;
var
	i,j:integer; 
Begin
	//bloc d'initialisation
	j:=0;
	i:=1;

	FOR i:=1 TO MAXCASE DO
	BEGIN

		IF (nBateau.nCase[i].ligne<>0) OR (nBateau.nCase[i].col<>0) THEN
		begin
			j:=j+1;
		end;
	end;
	
	tailleBateau:=j;
End;


function etatBat(nBateau:bateau):etatBateau;
var
	etat:integer;		
Begin
	etat:=tailleBateau(nBateau);
	
	IF (etat<nBateau.taille) AND (etat>0) THEN 
	begin
	etatBat:=toucher
	end
	ELSE IF (etat=0) THEN
	begin
	etatBat:=couler;
	end;
End;



function etatFlot(player:flotte):etatFlotte;
var
	i,j:integer;
Begin	
	//bloc d'initialisation
	i:=1;
	j:=0;

	FOR i:=1 TO MAXBATEAU DO
	begin
		IF (etatBat(player.nBateau[i])=couler) THEN
		begin
		j:=j+1;
		end;
	end;
	
	IF j=MAXBATEAU THEN 
	begin
	etatFlot:=aSombrer
	end
	ELSE
	begin
		etatFlot:=aFlot;
	end;
End;




PROCEDURE CreateCase(l,c:integer; VAR nCellule:cellule);//Cette procedure permet d'affecter des valeurs à une cellule
Begin
	nCellule.ligne:=l;
	nCellule.col:=c;
End;


FUNCTION comparCase(nCellule,tCellule:cellule):boolean;
Begin
	
	IF ((nCellule.col=tCellule.col) AND (nCellule.ligne=tCellule.ligne)) THEN
	begin
		comparCase:=true
	end
	ELSE
	begin
		comparCase:=false;
	end;
End;



FUNCTION createBateau(nCellule:cellule; taille:integer):bateau;//Cette procedure créer les bateaux et leurs attributs une disposition
var
	res:bateau;	
	posBateau:positionBateau;	
	i:integer;	
	pos:integer;	

Begin
	
	pos:=Random(3);
	posBateau:=positionBateau(pos);
	res.taille:=taille;
	
	FOR i:=1 TO MAXCASE DO
	begin

		IF (i<=taille) THEN
		begin
			res.nCase[i].ligne:=nCellule.ligne;
			res.nCase[i].col:=nCellule.col;
		end
		ELSE
		begin
			res.nCase[i].ligne:=0;
			res.nCase[i].col:=0;
		end;
		

		IF (posBateau=enLigne) THEN
			begin
				nCellule.col:=nCellule.col+1
			end
			ELSE IF (posBateau=enColonne) THEN
				begin
					nCellule.ligne:=nCellule.ligne+1
				end
				ELSE IF (posBateau=enDiag) THEN
					begin
						nCellule.ligne:=nCellule.ligne+1;
						nCellule.col:=nCellule.col+1;
					end;
		end;

	createBateau:=res;
End;


procedure attaquerBateau(var player:flotte); //Cette procedure permet au joueur d'attaquer des coordonnées et indique si le bateau 
var
	nCellule:cellule;
	touche:boolean;	
	i,j:integer;	
Begin
//bloc d'initialisation
i:=1;
j:=1;
	
	REPEAT
		writeln('Entrez le numéro de la ligne que vous souhaitz attaquer. (entre 1 et 6)');
		readln(nCellule.ligne);
		IF (nCellule.ligne<1) OR (nCellule.ligne>10) THEN 
		begin
		writeln('le numero doit etre compris entre 1 et 6, recommencez svp');
		end;
	UNTIL (nCellule.ligne>0) AND (nCellule.ligne<=10);
	
	REPEAT
		writeln('Entrez le numéro de la ligne que vous souhaitz attaquer. (entre 1 et 6)');
		readln(nCellule.col);
		IF (nCellule.col<1) OR (nCellule.col>50) THEN
		begin
		writeln('le numero doit etre compris entre 1 et 6, recommencez svp');
		end;
	UNTIL (nCellule.col>0) AND (nCellule.col<=50);
	
	FOR i:=1 TO MAXBATEAU DO
	begin
		FOR j:=1 TO player.nBateau[i].taille DO
		begin
			touche:=false;
			
			touche:=comparCase(nCellule,player.nBateau[i].nCase[j]);
		
			IF touche THEN
			begin
				writeln('TOUCHE !');
				CreateCase(0,0,player.nBateau[i].nCase[j]);
				IF etatBat(player.nBateau[i])=couler THEN
				begin
				writeln('LE NAVIRE EST COULE !');
				end;
			end;
		end;
	
	end;
End;


procedure IniPlayer (var nBateau:bateau;var nCellule:cellule);
Begin
	
	repeat
		nBateau.taille:=Random(MAXCASE)+3;
	until (nBateau.taille>2) and (nBateau.taille<=MAXCASE);
	
	
	REPEAT
		CreateCase((Random(MAXL)+MINL),(Random(MAXC)+MINL),nCellule);
	UNTIL (nCellule.ligne>=MINL) AND (nCellule.ligne<=MAXL-nBateau.taille) AND (nCellule.col>=MINC) AND (nCellule.col<=MAXC-nBateau.taille);

	nBateau:=createBateau(nCellule,nBateau.taille);
End;


procedure initialisation(var player:flotte; nCellule:cellule);//Cette procedure initialise les flottes et met en place les objectifs des joueurs.
var
  cpt : integer;	
Begin
//bloc d'initialisation
cpt:=1;
	FOR cpt:=1 TO MAXBATEAU DO
	begin
		IniPlayer(player.nBateau[cpt],nCellule);
	end;
End;





////////////PROGRAMME PRINCIPAL////////////////////
PROCEDURE algocomplet;//Cette procédure comporte tout l'algorithme et permet d'éviter d'avoir des variables globales
var
	nCellule:cellule;	
	joueur1,joueur2:flotte;	
	etatJ1,etatJ2:etatJoueur;	
	etatfl1,etatfl2:etatFlotte;	

	
Begin
	clrscr;
	randomize;
	//bloc d'initialisation
	etatJ1:=gagne;
	etatJ2:=gagne;
	etatfl1:=aFlot;
	etatfl2:=aFlot;
	initialisation(joueur1,nCellule);
	initialisation(joueur2,nCellule);
	writeln('Bienvenue dans la bataille navale !');
	readkey;
	writeln('Les regles sont les suivantes:');
	readkey;
	writeln('Chaque joueur dispose d une flotte, les bateaux constituant cette flotte font entre 2 à 5 cases de long,' );
	readkey;
	writeln('ces bateaux peuvent etre dispose de trois manieres differentes : ');
	writeln('-horizontale');
	writeln('-verticale');
	writeln('-diagonale');
	readkey;
	writeln('Les joueurs vont attaquer chacun leur tour les coordonnées qu ils ont mentionne,');
	writeln('le derniers joueur avrc sa flotte à flots remporte la victoire !');
	writeln('Bonne chance!');	
	readkey;

	REPEAT
		IF (etatJ1=gagne) AND (etatJ2=gagne) THEN
		begin
			writeln('Joueur 1, a vous : ');
			attaquerBateau(joueur1);
		end;
		
		etatfl1:=etatFlot(joueur1);		
		
		
		IF etatfl2=aSombrer THEN
		begin
			etatJ2:=perd;
		end;
		
		IF (etatJ1=gagne) AND (etatJ2=gagne) THEN
		begin
			writeln('Joueur 2, a vous : ');
			attaquerBateau(joueur2);
		end;
			
		etatfl2:=etatFlot(joueur2);
		
		
		IF etatfl1=aSombrer THEN
			etatJ1:=perd;
		
	UNTIL ((etatJ1=perd) OR (etatJ2=perd)) AND ((etatfl1=aSombrer) OR (etatfl2=aSombrer));
	
	IF etatJ1=perd THEN
	begin
		writeln('Tous les navires du Joueur1 ont ete coule ! Joueur2 remporte la victoire !');
	end
	ELSE
	begin
	writeln('Tous les navires de Joueur2 ont été coule ! Joueur1 remporte la victoire !');
	end;

	readkey;
End;

BEGIN
	algocomplet;
END.


