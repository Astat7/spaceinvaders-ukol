# Ukol do PHR - Space Invaders
- Úkol do předmětu PHR o vytvoření kopie Space invaders
- Hra se skládá z několika uzlů
- Hra se ovládá pomocí tlačítek A, D a mezerník
## Uzel Enemies
- Tento uzel obsahuje všechny invadery kromě UFO
- Je ovládáný scriptem enemies_movement.gd
### enemies_movement.gd
- proměnné
1. velocity - Určuje směr a rychlost pohybu po ose x
2. moved - Určuje, jestli se může uzel pohnout dolů, toto je jakýsi "cooldown" aby se uzel pohnul jenom jednou při každém dotyku stěny
3. reskinned - Určuje fázy animace každého invadera
- funkce
1. callCooldown() - Nastavý reskinned na true, a po krátké době zpátky na false
2. _ready() - Godot funkce, která se volá při načtení uzlu a všech jeho potomků. Tato slouží k hýbání uzlu (a s ním i všechny invadery) po ose x, při každém pohnutí změní fázy spritu invaderů. Rychlost je nepřímě závislá k počtu invaderů. I když to je pouze výrazné v malém počtu.
### enemy_life.gd
- ovládá vlastnosti každého invadera zvlášť
- obsahuje několik proměnných
1. static enemyCount - statická proměnná, která určuje kolik invaderů je ještě na herním poli
2. score - určuje, kolik dostane hráč skóre za konkrétního invadera
3. inGame - určuje jestli je invader naživu
4. offSet - určuje pozici invadera v hracím poli relativně k uzlu Enemies
- funkce
1. destroy() - Slouží k "zabití" invadera. Přesune ho pryč z herního pole, a na krátkou chvíli zobrazí explozi. Také přičte hráči body za zničení
2. respawn() - Vrátí invadera zpět na hrací plochu, používané pro novou hru.
3. _ready() - nastaví proměnnou score, podle toho jaký typ invadera to je
4. _process() - Ovládá střelbu invaderů. Také posouvá uzel Enemies dolů a obrací jeho směr. Pokud se invadeří dostanou moc nízko, script vyvolá prohru.
## Uzel Explosions
- Tento uzel slouží k uchovávání dočasných explozí a projektylů od invaderů.
## Uzel Bunkers
- Obsahuje bunkry, za kterýma se dá schovat
- každý bunker je tvořen ze skupiny menších uzlů, které se dají jednotlivě "zničit"
- obsahuje script bunkers.gd
### bunkers.gd
- obsahuje funkci reset(), která obnoví zničené segmenty bunkrů
## Uzel UI
- Obshajue "UI" prvky. Např. ukazatel životů nebo skóre
- Obrázky "Laser Cannon", které odpovídají počtu životům jsou ovládány scriptem lifeCounter.gd
### lifeCounter.gd
- obsahuje proměnnou requiredLifes, která učuje, kolik životů je třeba k zobrazení obrázku
- funkce toggleVisibility() je připojená na signál změny životů a vyhodnocuje, jestli má být obrázek zobrazen
- script je poté rozdělen na dva další, které ho rozšiřují
- v těchto scriptech se funkce připojuje ja signál a nastavuje requiredLifes
## Uzel Menu
- obsahuje tlačítka pro vypnutí programu, pokračování ve hře a nové hry
- obsahuje script menu.gd
### menu.gd
- obsahuje proměnnou gameOn, která určuje, jestli se dá použít tlačítko pro pokračování ve hře
- obsahuje několik funkcí
1. endGame() - je volaná v případu prohry, zabraňuje v pokračování v prohrané hře
2. _input() - slouží k pozastavení hry a zobrazení menu pomocí tlačítka ESC
### quit_game.gd
- script pro tlačitko quit, který vypne program
### continue_game.gd
- script pro tlačítko continue, který funguje identicky k použítí ESC v menu. Dá se použít jenom, pokud hra už začala a není prohraná.
### new_game.gd
- script pro tlačítko new game, který resetuje celou hru.
## uzel Player
- Je to postavička hráče
- obsahuje obrázek "Laser Cannon" a kolize pro hráče
- je řízen scriptem movement.gd
### movement.gd
- proměnné
1. lifes - počet životů
2. veloc - vektor určující, kam se má hráč pohnout
- funkce
1. destroy() - "zničí" hráče a podle toho, kolik má životů, tak ho buďto "respawne" nebo vyvolá prohru. Také vytvoří explozi na krátkou dobu
2. reset() - resetuje hráče a životy, používá se při nové hře
3. _input() - slouží k vystřelení projektilu
4. _process() - slouží k pohnutí hráče
## Uzel Laser
- zpodobuje projektil hráče
- je ovládán scriptem projectile.gd
- tento script se používá i pro projektily invaderů
### projectile.gd
- proměnné
1. speed - určuje rychlost projektilu
2. enemySpawned - určuje, jestli projektil patří hráči nebo invaderovi
3. Tři konstanty barev (green, red, white), které projektil může mít v závislosti na pozici na herním poli
- funkce
1. destroy() - "zničí" projektil jestli patří hráči, nebo ho zničí doslova jestli patří invaderovi
2. _ready() - ovládá pohyb projektilu a ničení věcí, kterých se dotkne
3. _process() - ovládá barvu projektilu v závislosti na pozici na herním poli
## Uzel UFO
- představuje ufo, které se občas objeví na horní straně hracího pole
- je řízen scriptem ufo.gd
### ufo.gd
- proměnné
1. inGame - určuje, jestli se ufo "spawnuté" ve hře
2. score - určuje, kolik bodů za zničení hráč dostane
- funkce
1. destroy() - "zničí ufo, a jestli je zničené hráčem, tak přičte body"
2. spawn() - "spawne" ufo, které pak letí zleve do prava a "zničího" jakmile opustí herní pole
3. _process() - náhodně zavolá funkci spawn(), k vyslání ufa
## Extra
### start_paused.gd
- spustí hru s pozastavenou hrou, aby hra neběžela před zapnutím
