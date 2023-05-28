1) Сколько медалей выиграл Jesse Owens в 1936?

select count(*) from olimb where edition = 1936 and athlete = 'OWENS, Jesse' 

Ответ:4

2) Какая страна выиграла большинство золотых медалей мужчинами в бадминтоне?

select noc,count(*) as gold from olimb 
where sport = 'Badminton' and medal = 'Gold' and gender = 'Men'
group by noc
order by gold desc
limit 1

Ответ: INA| 8|

3) Какие три страны выйграли большинство медалей в последние годы (с 1984 по 2008)?

select noc, count(*) as count from olimb
where edition >= 1984 and edition <= 2008
group by noc
order by count desc
limit 3

Ответ:
USA| 1837|
AUS|  762|
GER|  691|

4) Покажите мужчин золотых медалистов по 100m. Выведите результаты по убыванию года выйгрыша. Покажите город в котором проходила олимпиала, год, имя атлета и страну за которую он выступал.
 
 
select edition,city,athlete,noc from olimb
where gender = 'Men' and event = '100m' AND medal = 'Gold' 
order by edition DESC

Ответ:
   2008|Beijing              |BOLT, Usain          |JAM|
   2004|Athens               |GATLIN, Justin       |USA|
   2000|Sydney               |GREENE, Maurice      |USA|
   1996|Atlanta              |BAILEY, Donovan      |CAN|
   1992|Barcelona            |CHRISTIE, Linford    |GBR|
   1988|Seoul                |LEWIS, Carl          |USA|
   1984|Los Angeles          |LEWIS, Carl          |USA|
   1980|Moscow               |WELLS, Allan         |GBR|
   1976|Montreal             |CRAWFORD, Hasely     |TRI|
   1972|Munich               |BORZOV, Valery       |URS|
   1968|Mexico               |HINES, James Ray     |USA|
   1964|Tokyo                |HAYES, Robert        |USA|
   1960|Rome                 |HARY, Armin          |EUA|
   1956|Melbourne / Stockholm|MORROW, Robert Joseph|USA|
   1952|Helsinki             |REMIGINO, Lindy      |USA|
   1948|London               |DILLARD, Harrison    |USA|
   1936|Berlin               |OWENS, Jesse         |USA|
   1932|Los Angeles          |TOLAN, Eddie         |USA|
   1928|Amsterdam            |WILLIAMS, Percy      |CAN|
   1924|Paris                |ABRAHAMS, Harold     |GBR|
   1920|Antwerp              |PADDOCK, Charles     |USA|
   1912|Stockholm            |CRAIG, Ralph         |USA|
   1908|London               |WALKER, Reginald     |RSA|
   1904|St Louis             |HAHN, Archie         |USA|
   1900|Paris                |JARVIS, Francis      |USA|
   1896|Athens               |BURKE, Thomas        |USA|
   
  5) Как много медалей было выйграно мужчинами и женщинами в истории олимпиады. Как много золотых, серебрянных и бронзовых медалей было выйграно каждым полом?
  
Серебро у мужчин:
select gender, count(*) from olimb 
where medal='Silver' and gender='Men' 
group by gender

Ответ:Men | 7181|

Золото у мужчин:
select gender, count(*) from olimb 
where medal='Gold' and gender='Men' 
group by gender

Ответ:Men | 7365|

Бронза у мужчин:
select gender, count(*) from olimb
where medal='Bronze' and gender='Men' 
group by gender

Ответ:Men | 7175|

Серебро у женщин:
select gender, count(*) from olimb
where medal='Silver' and gender='Women' 
group by gender

Ответ:Women | 2496|

Золото у женщин:
select gender, count(*) from olimb
where medal='Gold' and gender='Women' 
group by gender

Ответ:Women | 2485|

Бронза у женщин:
select gender, count(*) from olimb
where medal='Bronze' and gender='Women' 
group by gender

Ответ:Women | 2514|

 6) Выведите общее кол-во медалей для каждой олимпиады.
 
select city, edition, count(*) from olimb
group by city, edition
order by edition DESC

Ответ:
city                 |edition|count|
---------------------+-------+-----+
Beijing              |   2008| 2042|
Athens               |   2004| 1998|
Sydney               |   2000| 2015|
Atlanta              |   1996| 1859|
Barcelona            |   1992| 1705|
Seoul                |   1988| 1546|
Los Angeles          |   1984| 1459|
Moscow               |   1980| 1387|
Montreal             |   1976| 1305|
Munich               |   1972| 1185|
Mexico               |   1968| 1031|
Tokyo                |   1964| 1010|
Rome                 |   1960|  882|
Melbourne / Stockholm|   1956|  885|
Helsinki             |   1952|  889|
London               |   1948|  814|
Berlin               |   1936|  875|
Los Angeles          |   1932|  615|
Amsterdam            |   1928|  710|
Paris                |   1924|  884|
Antwerp              |   1920| 1298|
Stockholm            |   1912|  885|
London               |   1908|  804|
St Louis             |   1904|  470|
Paris                |   1900|  512|
Athens               |   1896|  151|

 7) Создайте список показывающий число всех медалей выйгранных каждой страной в течение всей истории олимпийских игр. Для каждой страны, необходимо показать год первой и последней заработанной медали.
 
 
select noc, min(edition) as A, max(edition) as B, 
count(*) from olimb 
group by noc
order by noc ASC

Ответ:
noc|a   |b   |count|
---+----+----+-----+
AFG|2008|2008|    1|
AHO|1988|1988|    1|
ALG|1984|2008|   14|
ANZ|1908|1912|   29|
ARG|1924|2008|  239|
ARM|1996|2008|    9|
AUS|1896|2008| 1075|
AUT|1896|2008|  146|
AZE|1996|2008|   16|
BAH|1956|2008|   23|
BAR|2000|2000|    1|
BDI|1996|1996|    1|
BEL|1900|2008|  408|
BER|1976|1976|    1|
BLR|1996|2008|   92|
BOH|1900|1908|    7|
BRA|1920|2008|  372|
BUL|1952|2008|  331|
BWI|1960|1960|    5|
CAN|1900|2008|  592|
CHI|1928|2008|   33|
CHN|1984|2008|  679|
CIV|1984|1984|    1|
CMR|1968|2008|   22|
COL|1972|2008|   11|
CRC|1988|2000|    4|
CRO|1992|2008|   79|
CUB|1900|2008|  395|
CZE|1996|2008|   41|
DEN|1896|2008|  491|
DJI|1988|1988|    1|
DOM|1984|2008|    4|
ECU|1996|2008|    2|
EGY|1928|2008|   24|
ERI|2004|2004|    1|
ESP|1900|2008|  377|
EST|1920|2008|   37|
ETH|1960|2008|   38|
EUA|1956|1964|  260|
EUN|1992|1992|  223|
FIN|1908|2008|  451|
FRA|1896|2008| 1314|
FRG|1968|1988|  490|
GBR|1896|2008| 1594|
GDR|1968|1988|  825|
GEO|1996|2008|   18|
GER|1896|2008| 1211|
GHA|1960|1992|   16|
GRE|1896|2008|  145|
GUY|1980|1980|    1|
HAI|1924|1928|    8|
HKG|1996|2004|    3|
HUN|1896|2008| 1053|
INA|1988|2008|   35|
IND|1900|2008|  178|
IOP|1992|1992|    3|
IRI|1948|2008|   48|
IRL|1928|2008|   24|
IRQ|1960|1960|    1|
ISL|1956|2008|   17|
ISR|1992|2008|    7|
ISV|1988|1988|    1|
ITA|1900|2008| 1228|
JAM|1948|2008|  102|
JPN|1920|2008|  704|
KAZ|1996|2008|   39|
KEN|1964|2008|   81|
KGZ|2000|2008|    3|
KOR|1948|2008|  466|
KSA|2000|2000|    2|
KUW|2000|2000|    1|
LAT|1932|2008|   17|
LIB|1952|1980|    4|
LTU|1992|2008|   50|
LUX|1920|1952|    2|
MAR|1960|2008|   21|
MAS|1992|2008|    6|
MDA|1996|2008|    6|
MEX|1932|2008|   80|
MGL|1968|2008|   19|
MKD|2000|2000|    1|
MOZ|1996|2000|    2|
MRI|2008|2008|    1|
NAM|1992|1996|    4|
NED|1900|2008|  782|
NGR|1964|2008|   84|
NIG|1972|1972|    1|
NOR|1900|2008|  537|
NZL|1920|2008|  164|
PAK|1956|1992|  121|
PAN|1948|2008|    3|
PAR|2004|2004|   17|
PER|1948|1992|   15|
PHI|1928|1996|    9|
POL|1924|2008|  499|
POR|1924|2008|   31|
PRK|1972|2008|   52|
PUR|1948|1996|    6|
QAT|1992|2000|    2|
ROU|1924|2008|  624|
RSA|1908|2008|   97|
RU1|1908|1912|   17|
RUS|1996|2008|  638|
SCG|2004|2004|   14|
SEN|1988|1988|    1|
SIN|1960|2008|    4|
SLO|1992|2008|   21|
SRB|2008|2008|   15|
SRI|1948|2000|    2|
SUD|2008|2008|    1|
SUI|1896|2008|  376|
SUR|1988|1992|    2|
SVK|1996|2008|   29|
SWE|1900|2008| 1021|
SYR|1984|2004|    3|
TAN|1980|1980|    2|
TCH|1920|1992|  329|
TGA|1996|1996|    1|
THA|1976|2008|   21|
TJK|2008|2008|    2|
TOG|2008|2008|    1|
TPE|1960|2008|   42|
TRI|1948|2008|   20|
TUN|1964|2008|    7|
TUR|1936|2008|   82|
UAE|2004|2004|    1|
UGA|1968|1996|    6|
UKR|1996|2008|  148|
URS|1952|1988| 2049|
URU|1924|2000|   76|
USA|1896|2008| 4335|
UZB|1996|2008|   17|
VEN|1952|2008|   11|
VIE|2000|2008|    2|
YUG|1924|2000|  435|
ZAM|1984|1996|    2|
ZIM|1980|2008|   23|
ZZX|1896|1904|   48|

 8) Атлеты выйгравшие медали в Beijing на дистанции 100m или 200m.
 
select athlete from olimb 
where city='Beijing' and (event='200m' or event='100m')

Ответ:
athlete                 |
------------------------+
DIX, Walter             |
BOLT, Usain             |
THOMPSON, Richard       |
FRASER, Shelly-ann      |
SIMPSON, Sherone        |
STEWART, Kerron         |
DIX, Walter             |
BOLT, Usain             |
CRAWFORD, Shawn         |
STEWART, Kerron         |
CAMPBELL-BROWN, Veronica|
FELIX, Allyson          |

 9) Найдите кол-во золотых медалей выйгранных США мужчинами и женщинами в атлетике на каждой олимпиаде.
 
 select edition,city,  
(select count(*) from olimb where gender = 'Men'),
(select count(*) from olimb where gender = 'Women' ) from olimb
where sport = 'Athletics' and noc = 'USA'
group by city, edition
order by edition DESC

Ответ:
edition|city                 |count|count|
-------+---------------------+-----+-----+
   2008|Beijing              |21721| 7495|
   2004|Athens               |21721| 7495|
   2000|Sydney               |21721| 7495|
   1996|Atlanta              |21721| 7495|
   1992|Barcelona            |21721| 7495|
   1988|Seoul                |21721| 7495|
   1984|Los Angeles          |21721| 7495|
   1976|Montreal             |21721| 7495|
   1972|Munich               |21721| 7495|
   1968|Mexico               |21721| 7495|
   1964|Tokyo                |21721| 7495|
   1960|Rome                 |21721| 7495|
   1956|Melbourne / Stockholm|21721| 7495|
   1952|Helsinki             |21721| 7495|
   1948|London               |21721| 7495|
   1936|Berlin               |21721| 7495|
   1932|Los Angeles          |21721| 7495|
   1928|Amsterdam            |21721| 7495|
   1924|Paris                |21721| 7495|
   1920|Antwerp              |21721| 7495|
   1912|Stockholm            |21721| 7495|
   1908|London               |21721| 7495|
   1904|St Louis             |21721| 7495|
   1900|Paris                |21721| 7495|
   1896|Athens               |21721| 7495|
   
   10) Найдите 5 атлетов которые выйграли большинство золотых медалей.
   
select athlete, count(*) as count from olimb
where medal = 'Gold' 
group by athlete
order by count desc
limit 5

Ответ:
athlete         |count|
----------------+-----+
PHELPS, Michael |   14|
LATYNINA, Larisa|    9|
NURMI, Paavo    |    9|
SPITZ, Mark     |    9|
LEWIS, Carl     |    9|

 11) Покажите суммарное количество медалей выйгранных странами в последних олимпийских играх.
 
 select noc, count(*) as medals from olimb
where edition = '2008' 
group by noc
order by medals DESC

Ответ:
noc|medals|
---+------+
USA|   315|
CHN|   184|
AUS|   149|
RUS|   143|
GER|   101|
KOR|    78|
GBR|    77|
FRA|    76|
BRA|    75|
ESP|    71|
NED|    62|
ARG|    51|
JPN|    51|
CUB|    47|
ITA|    42|
CAN|    34|
UKR|    31|
BLR|    30|
HUN|    27|
NGR|    24|
NOR|    22|
ROU|    22|
POL|    20|
DEN|    18|
JAM|    17|
SRB|    15|
NZL|    14|
KEN|    14|
ISL|    14|
KAZ|    13|
SUI|    11|
SVK|    10|
TUR|     8|
CZE|     7|
AZE|     7|
INA|     7|
ETH|     7|
GRE|     7|
SWE|     7|
PRK|     6|
GEO|     6|
UZB|     6|
ARM|     6|
BEL|     5|
BAH|     5|
TRI|     5|
CRO|     5|
LTU|     5|
SLO|     5|
FIN|     5|
BUL|     5|
MGL|     4|
MEX|     4|
THA|     4|
TPE|     4|
ZIM|     4|
AUT|     3|
IND|     3|
LAT|     3|
EST|     3|
IRL|     3|
SIN|     3|
IRI|     2|
DOM|     2|
ALG|     2|
TJK|     2|
MAR|     2|
COL|     2|
KGZ|     2|
POR|     2|
MDA|     1|
TUN|     1|
SUD|     1|
AFG|     1|
ECU|     1|
VEN|     1|
VIE|     1|
MAS|     1|
PAN|     1|
CMR|     1|
EGY|     1|
CHI|     1|
MRI|     1|
ISR|     1|
TOG|     1|
RSA|     1|

 12) Постройте таблицу в которой по годам всех олимпиад покажите топовых атлетов США(1 атлет на год) по общему количеству медалей. Включите дисциплину атлета.
 
select distinct on(edition) 
edition, athlete, discipline, count(*) as medals from olimb
where noc = 'USA'
group by edition, athlete, discipline
order by edition desc, medals DESC

Ответ:
edition|athlete                         |discipline   |medals|
-------+--------------------------------+-------------+------+
   2008|PHELPS, Michael                 |Swimming     |     8|
   2004|PHELPS, Michael                 |Swimming     |     8|
   2000|TORRES, Dara                    |Swimming     |     5|
   1996|MARTINO, Angel                  |Swimming     |     4|
   1992|MILLER, Shannon                 |Artistic G.  |     5|
   1988|BIONDI, Matthew                 |Swimming     |     7|
   1984|RETTON, Mary-Lou                |Artistic G.  |     5|
   1976|BABASHOFF, Shirley Farber       |Swimming     |     5|
   1972|SPITZ, Mark                     |Swimming     |     7|
   1968|PEDERSEN, Susan Jane            |Swimming     |     4|
   1964|STOUDER, Sharon Marie           |Swimming     |     4|
   1960|VON SALTZA, Susan Christina     |Swimming     |     4|
   1956|MORROW, Robert Joseph           |Athletics    |     3|
   1952|KONNO, Ford Hiroshi             |Swimming     |     3|
   1948|MCLANE, James Price Jr.         |Swimming     |     3|
   1936|OWENS, Jesse                    |Athletics    |     4|
   1932|DIDRIKSON, Mildred              |Athletics    |     3|
   1928|DESJARDINS, Ulise Joseph "Peter"|Diving       |     2|
   1924|RICHARDS, Vincent               |Tennis       |     3|
   1920|LEE, Willis                     |Shooting     |     7|
   1912|OSBURN, Carl Townsend           |Shooting     |     4|
   1908|SHERIDAN, Martin                |Athletics    |     3|
   1904|DOWNING, Burton                 |Cycling Track|     6|
   1900|BAXTER, Irving                  |Athletics    |     5|
   1896|GARRETT, Robert                 |Athletics    |     4|
 
