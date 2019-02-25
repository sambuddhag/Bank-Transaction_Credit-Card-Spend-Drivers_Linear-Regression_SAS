libname LR1 "/folders/myfolders/Linear Regression Case";

proc import datafile="/folders/myfolders/Linear Regression Case/Linear Regression Case.xlsx"
out=LR1.mydata dbms=xlsx replace;
run;

proc contents data=LR1.mydata varnum;
run;

/* Dataset Creation with Dependent Variable and Additional Variables */

data LR1.mydata;
set LR1.mydata;
total_spent= cardspent + card2spent;
Total_fee = cardfee + card2fee;
Total_items=carditems + card2items;
run;

proc univariate data=LR1.mydata;
var total_spent;
histogram ;
run;


data LR1.mydata;
set LR1.mydata;
ln_spent = log(total_spent);
run;


proc univariate data=LR1.mydata;
var ln_spent;
histogram ;
run;

/* Removing Variables */

data LR1.mydata1;
set LR1.mydata;
drop cardspent card2spent carditems card2items cardfee card2fee custid birthmonth;
run;

/* Descriptive Statistics  */

proc means data=LR1.mydata1 N Nmiss mean std min P1 P5 P10 P25 P50 P75 P90 P95 P99 max ;
run;

/* Transforming some Variables to Remove Missing Values */

data LR1.mydata2;
set LR1.mydata1;
if lntollmon = . then lntollmon = log(tollmon + 1);
if lntollten = . then lntollten = log(tollten + 1);
if lnequipmon = . then lnequipmon = log(equipmon + 1);
if lnequipten = . then lnequipten = log(equipten + 1);
if lncardmon = . then lncardmon = log(cardmon + 1);
if lncardten = . then lncardten = log(cardten + 1);
if lnwiremon = . then lnwiremon = log(wiremon + 1);
if lnwireten = . then lnwireten = log(wireten + 1);
run; 

/* Missing Value Treatment */

data LR1.mydata3;
set LR1.mydata2;
if townsize     = " " then  townsize    =3;
if lncreddebt   =.    then  lncreddebt  =-0.1304535;
if lnothdebt    =.    then  lnothdebt   =0.6969153;
if commutetime  =.    then  commutetime =25.3455382;
if longten      =.    then  longten     =708.8717531;
if lnlongten    =.    then  lnlongten   =5.6112979;
if cardten      =.    then  cardten     =720.4783914; 
run;


/* Outlier Capping p95 */

data LR1.mydata4;
set LR1.mydata3;
if region >5 then region=5;
if townsize >5 then townsize=5;
if gender >1 then gender=1;
if age >76 then age=76;
if agecat >6 then agecat=6;
if ed >20 then ed=20;
if edcat >5 then edcat=5;
if jobcat >6 then jobcat=6;
if union >1 then union=1;
if employ >31 then employ=31;
if empcat >5 then empcat=5;
if retire >1 then retire=1;
if income >147 then income=147;
if lninc >4.99 then lninc=4.99;
if inccat >5 then inccat=5;
if debtinc >22.2 then debtinc=22.2;
if creddebt >6.385 then creddebt=6.385;
if lncreddebt >1.86 then lncreddebt=1.86;
if othdebt >11.83 then othdebt=11.83;
if lnothdebt >2.47 then lnothdebt=2.47;
if default >1 then default=1;
if jobsat >5 then jobsat=5;
if marital >1 then marital=1;
if spoused >18 then spoused=18;
if spousedcat >4 then spousedcat=4;
if reside >5 then reside=5;
if pets >10 then pets=10;
if pets_cats >2 then pets_cats=2;
if pets_dogs >2 then pets_dogs=2;
if pets_birds >1 then pets_birds=1;
if pets_reptiles >0 then pets_reptiles=0;
if pets_small >1 then pets_small=1;
if pets_saltfish >0 then pets_saltfish=0;
if pets_freshfish >8 then pets_freshfish=8;
if homeown >1 then homeown=1;
if hometype >4 then hometype=4;
if address >40 then address=40;
if addresscat >5 then addresscat=5;
if cars >4 then cars=4;
if carown >1 then carown=1;
if cartype >1 then cartype=1;
if carvalue >72 then carvalue=72;
if carcatvalue >3 then carcatvalue=3;
if carbought >1 then carbought=1;
if carbuy >1 then carbuy=1;
if commute >8 then commute=8;
if commutecat >4 then commutecat=4;
if commutetime >35 then commutetime=35;
if commutecar >1 then commutecar=1;
if commutemotorcycle >1 then commutemotorcycle=1;
if commutecarpool >1 then commutecarpool=1;
if commutebus >1 then commutebus=1;
if commuterail >1 then commuterail=1;
if commutepublic >1 then commutepublic=1;
if commutebike >1 then commutebike=1;
if commutewalk >1 then commutewalk=1;
if commutenonmotor >1 then commutenonmotor=1;
if telecommute >1 then telecommute=1;
if reason >9 then reason=9;
if polview >6 then polview=6;
if polparty >1 then polparty=1;
if polcontrib >1 then polcontrib=1;
if vote >1 then vote=1;
if card >4 then card=4;
if cardtype >4 then cardtype=4;
if cardbenefit >4 then cardbenefit=4;
if cardtenure >38 then cardtenure=38;
if cardtenurecat >5 then cardtenurecat=5;
if card2 >5 then card2=5;
if card2type >4 then card2type=4;
if card2benefit >4 then card2benefit=4;
if card2tenure >29 then card2tenure=29;
if card2tenurecat >5 then card2tenurecat=5;
if active >1 then active=1;
if bfast >3 then bfast=3;
if tenure >72 then tenure=72;
if churn >1 then churn=1;
if longmon >36.825 then longmon=36.825;
if lnlongmon >3.605 then lnlongmon=3.605;
if longten >2576.85 then longten=2576.85;
if lnlongten >7.85 then lnlongten=7.85;
if tollfree >1 then tollfree=1;
if tollmon >43.5 then tollmon=43.5;
if tollten >2620.33 then tollten=2620.33;
if equip >1 then equip=1;
if equipmon >49.075 then equipmon=49.075;
if equipten >2601.35 then equipten=2601.35;
if callcard >1 then callcard=1;
if cardmon >42 then cardmon=42;
if cardten >2460 then cardten=2460;
if wireless >1 then wireless=1;
if wiremon >51.35 then wiremon=51.35;
if wireten >2691.28 then wireten=2691.28;
if multline >1 then multline=1;
if voice >1 then voice=1;
if pager >1 then pager=1;
if internet >4 then internet=4;
if callid >1 then callid=1;
if callwait >1 then callwait=1;
if forward >1 then forward=1;
if confer >1 then confer=1;
if ebill >1 then ebill=1;
if owntv >1 then owntv=1;
if hourstv >28 then hourstv=28;
if ownvcr >1 then ownvcr=1;
if owndvd >1 then owndvd=1;
if owncd >1 then owncd=1;
if ownpda >1 then ownpda=1;
if ownpc >1 then ownpc=1;
if ownipod >1 then ownipod=1;
if owngame >1 then owngame=1;
if ownfax >1 then ownfax=1;
if news >1 then news=1;
if response_01 >1 then response_01=1;
if response_02 >1 then response_02=1;
if response_03 >1 then response_03=1;
if lntollmon >3.93 then lntollmon=3.93;
if lntollten >8.11 then lntollten=8.11;
if lnequipmon >4.07 then lnequipmon=4.07;
if lnequipten >8.12 then lnequipten=8.12;
if lncardmon >3.84 then lncardmon=3.84;
if lncardten >7.92 then lncardten=7.92;
if lnwiremon >4.27 then lnwiremon=4.27;
if lnwireten >8.31 then lnwireten=8.31;
if total_spent >1145.48 then total_spent=1145.48;
if Total_fee >1 then Total_fee=1;
if Total_items >22 then Total_items=22;
run;


/* p5 */

data LR1.mydata5;
set LR1.mydata4;
if region <1 then region=1;
if townsize <1 then townsize=1;
if gender <0 then gender=0;
if age <20 then age=20;
if agecat <2 then agecat=2;
if ed <9 then ed=9;
if edcat <1 then edcat=1;
if jobcat <1 then jobcat=1;
if union <0 then union=0;
if employ <0 then employ=0;
if empcat <1 then empcat=1;
if retire <0 then retire=0;
if income <13 then income=13;
if lninc <2.56 then lninc=2.56;
if inccat <1 then inccat=1;
if debtinc <1.9 then debtinc=1.9;
if creddebt <0.1 then creddebt=0.1;
if lncreddebt <-2.29 then lncreddebt=-2.29;
if othdebt <0.29 then othdebt=0.29;
if lnothdebt <-1.25 then lnothdebt=-1.25;
if default <0 then default=0;
if jobsat <1 then jobsat=1;
if marital <0 then marital=0;
if spoused <-1 then spoused=-1;
if spousedcat <-1 then spousedcat=-1;
if reside <1 then reside=1;
if pets <0 then pets=0;
if pets_cats <0 then pets_cats=0;
if pets_dogs <0 then pets_dogs=0;
if pets_birds <0 then pets_birds=0;
if pets_reptiles <0 then pets_reptiles=0;
if pets_small <0 then pets_small=0;
if pets_saltfish <0 then pets_saltfish=0;
if pets_freshfish <0 then pets_freshfish=0;
if homeown <0 then homeown=0;
if hometype <1 then hometype=1;
if address <1 then address=1;
if addresscat <1 then addresscat=1;
if cars <0 then cars=0;
if carown <-1 then carown=-1;
if cartype <-1 then cartype=-1;
if carvalue <-1 then carvalue=-1;
if carcatvalue <-1 then carcatvalue=-1;
if carbought <-1 then carbought=-1;
if carbuy <0 then carbuy=0;
if commute <1 then commute=1;
if commutecat <1 then commutecat=1;
if commutetime <16 then commutetime=16;
if commutecar <0 then commutecar=0;
if commutemotorcycle <0 then commutemotorcycle=0;
if commutecarpool <0 then commutecarpool=0;
if commutebus <0 then commutebus=0;
if commuterail <0 then commuterail=0;
if commutepublic <0 then commutepublic=0;
if commutebike <0 then commutebike=0;
if commutewalk <0 then commutewalk=0;
if commutenonmotor <0 then commutenonmotor=0;
if telecommute <0 then telecommute=0;
if reason <1 then reason=1;
if polview <2 then polview=2;
if polparty <0 then polparty=0;
if polcontrib <0 then polcontrib=0;
if vote <0 then vote=0;
if card <1 then card=1;
if cardtype <1 then cardtype=1;
if cardbenefit <1 then cardbenefit=1;
if cardtenure <1 then cardtenure=1;
if cardtenurecat <1 then cardtenurecat=1;
if card2 <1 then card2=1;
if card2type <1 then card2type=1;
if card2benefit <1 then card2benefit=1;
if card2tenure <1 then card2tenure=1;
if card2tenurecat <1 then card2tenurecat=1;
if active <0 then active=0;
if bfast <1 then bfast=1;
if tenure <4 then tenure=4;
if churn <0 then churn=0;
if longmon <2.9 then longmon=2.9;
if lnlongmon <1.06 then lnlongmon=1.06;
if longten <12.5 then longten=12.5;
if lnlongten <2.53 then lnlongten=2.53;
if tollfree <0 then tollfree=0;
if tollmon <0 then tollmon=0;
if tollten <0 then tollten=0;
if equip <0 then equip=0;
if equipmon <0 then equipmon=0;
if equipten <0 then equipten=0;
if callcard <0 then callcard=0;
if cardmon <0 then cardmon=0;
if cardten <0 then cardten=0;
if wireless <0 then wireless=0;
if wiremon <0 then wiremon=0;
if wireten <0 then wireten=0;
if multline <0 then multline=0;
if voice <0 then voice=0;
if pager <0 then pager=0;
if internet <0 then internet=0;
if callid <0 then callid=0;
if callwait <0 then callwait=0;
if forward <0 then forward=0;
if confer <0 then confer=0;
if ebill <0 then ebill=0;
if owntv <1 then owntv=1;
if hourstv <12 then hourstv=12;
if ownvcr <0 then ownvcr=0;
if owndvd <0 then owndvd=0;
if owncd <0 then owncd=0;
if ownpda <0 then ownpda=0;
if ownpc <0 then ownpc=0;
if ownipod <0 then ownipod=0;
if owngame <0 then owngame=0;
if ownfax <0 then ownfax=0;
if news <0 then news=0;
if response_01 <0 then response_01=0;
if response_02 <0 then response_02=0;
if response_03 <0 then response_03=0;
if lntollmon <2.58 then lntollmon=2.58;
if lntollten <4.2 then lntollten=4.2;
if lnequipmon <3.14 then lnequipmon=3.14;
if lnequipten <4.25 then lnequipten=4.25;
if lncardmon <1.98 then lncardmon=1.98;
if lncardten <4.09 then lncardten=4.09;
if lnwiremon <2.99 then lnwiremon=2.99;
if lnwireten <4.1 then lnwireten=4.1;
if total_spent <133.07 then total_spent=133.07;
if Total_fee <0 then Total_fee=0;
if Total_items <8 then Total_items=8;
run;


/* Cross Checking Descriptive statistics  */

proc means data=LR1.mydata5 N Nmiss mean max;
run;


/* Transforming dependent variable to make it Normal */


data LR1.mydata6;
set LR1.mydata5;
ln_total_spent = log(total_spent);
run;


proc univariate data=LR1.mydata6;
var total_spent ln_total_spent;
histogram ;
run;

/* Correlation matrix */

proc corr data=LR1.mydata6;
var age
ed
income
lninc
debtinc
creddebt
lncreddebt
othdebt
lnothdebt
spoused
reside
pets
pets_cats
pets_dogs
pets_birds
pets_reptiles
pets_small
pets_saltfish
pets_freshfish
carvalue
commutetime
tenure
longmon
lnlongmon
longten
lnlongten
tollfree
tollmon
tollten
equipmon
equipten
lntollmon
lntollten
lnequipmon
lnequipten
lncardmon
lnwiremon
lnwireten
lncardten
cardmon
cardten
wiremon
wireten
hourstv
total_spent
Total_fee
Total_items;
run;


/* Filtering out Significant Categorical Variables */

proc anova data=LR1.mydata6;
class region;
model total_spent = region;
run;
proc anova data=LR1.mydata6;
class townsize;
model total_spent = townsize;
run;
proc anova data=LR1.mydata6;
class gender;
model total_spent = gender; 
run;
proc anova data=LR1.mydata6;
class agecat;
model total_spent = agecat; 
run;
proc anova data=LR1.mydata6;
class edcat;
model total_spent = edcat; 
run;
proc anova data=LR1.mydata6;
class jobcat;
model total_spent = jobcat;
run;
proc anova data=LR1.mydata6;
class union;
model total_spent = union;
run;
proc anova data=LR1.mydata6;
class employ;
model total_spent = employ; 
run;
proc anova data=LR1.mydata6;
class empcat;
model total_spent = empcat; 
run;
proc anova data=LR1.mydata6;
class retire;
model total_spent = retire; 
run;
proc anova data=LR1.mydata6;
class inccat;
model total_spent = inccat; 
run;
proc anova data=LR1.mydata6;
class default;
model total_spent = default;
run;
proc anova data=LR1.mydata6;
class jobsat;
model total_spent = jobsat; 
run;
proc anova data=LR1.mydata6;
class marital;
model total_spent = marital;
run;
proc anova data=LR1.mydata6;
class spousedcat;
model total_spent = spousedcat; 
run;
proc anova data=LR1.mydata6;
class homeown;
model total_spent = homeown; 
run;
proc anova data=LR1.mydata6;
class hometype;
model total_spent = hometype; 
run;
proc anova data=LR1.mydata6;
class address;
model total_spent = address; 
run;
proc anova data=LR1.mydata6;
class addresscat;
model total_spent = addresscat; 
run;
proc anova data=LR1.mydata6;
class cars;
model total_spent = cars;
run;
proc anova data=LR1.mydata6;
class carown;
model total_spent = carown; 
run;
proc anova data=LR1.mydata6;
class cartype;
model total_spent = cartype;
run;
proc anova data=LR1.mydata6;
class carcatvalue;
model total_spent = carcatvalue; 
run;
proc anova data=LR1.mydata6;
class carbought;
model total_spent = carbought;
run;
proc anova data=LR1.mydata6;
class carbuy;
model total_spent = carbuy;
run;
proc anova data=LR1.mydata6;
class commute;
model total_spent = commute;
run;
proc anova data=LR1.mydata6;
class commutecat;
model total_spent = commutecat;
run;
proc anova data=LR1.mydata6;
class commutecar;
model total_spent = commutecar;
run;
proc anova data=LR1.mydata6;
class commutemotorcycle;
model total_spent = commutemotorcycle;
run;
proc anova data=LR1.mydata6;
class commutecarpool;
model total_spent = commutecarpool;
run;
proc anova data=LR1.mydata6;
class commutebus;
model total_spent = commutebus;
run;
proc anova data=LR1.mydata6;
class commuterail;
model total_spent = commuterail;
run;
proc anova data=LR1.mydata6;
class commutepublic;
model total_spent = commutepublic;
run;
proc anova data=LR1.mydata6;
class commutebike;
model total_spent = commutebike; 
run;
proc anova data=LR1.mydata6;
class commutewalk;
model total_spent = commutewalk;
run;
proc anova data=LR1.mydata6;
class commutenonmotor;
model total_spent = commutenonmotor;
run;
proc anova data=LR1.mydata6;
class telecommute;
model total_spent = telecommute;
run;
proc anova data=LR1.mydata6;
class reason;
model total_spent = reason; 
run;
proc anova data=LR1.mydata6;
class polview;
model total_spent = polview;
run;
proc anova data=LR1.mydata6;
class polparty;
model total_spent = polparty;
run;
proc anova data=LR1.mydata6;
class polcontrib;
model total_spent = polcontrib;
run;
proc anova data=LR1.mydata6;
class vote;
model total_spent = vote; 
run;
proc anova data=LR1.mydata6;
class card;
model total_spent = card; 
run;
proc anova data=LR1.mydata6;
class cardtype;
model total_spent = cardtype;
run;
proc anova data=LR1.mydata6;
class cardbenefit;
model total_spent = cardbenefit;
run;
proc anova data=LR1.mydata6;
class cardtenure;
model total_spent = cardtenure; 
run;
proc anova data=LR1.mydata6;
class cardtenurecat;
model total_spent = cardtenurecat; 
run;
proc anova data=LR1.mydata6;
class card2;
model total_spent = card2; 
run;
proc anova data=LR1.mydata6;
class card2type;
model total_spent = card2type;
run;
proc anova data=LR1.mydata6;
class card2benefit;
model total_spent = card2benefit;
run;
proc anova data=LR1.mydata6;
class card2tenure;
model total_spent = card2tenure; 
run;
proc anova data=LR1.mydata6;
class card2tenurecat;
model total_spent = card2tenurecat; 
run;
proc anova data=LR1.mydata6;
class active;
model total_spent = active;
run;
proc anova data=LR1.mydata6;
class bfast;
model total_spent = bfast; 
run;
proc anova data=LR1.mydata6;
class churn;
model total_spent = churn;
run;
proc anova data=LR1.mydata6;
class tollfree;
model total_spent = tollfree; 
run;
proc anova data=LR1.mydata6;
class equip;
model total_spent = equip; 
run;
proc anova data=LR1.mydata6;
class callcard;
model total_spent = callcard;
run;
proc anova data=LR1.mydata6;
class wireless;
model total_spent = wireless; 
run;
proc anova data=LR1.mydata6;
class multline;
model total_spent = multline; 
run;
proc anova data=LR1.mydata6;
class voice;
model total_spent = voice; 
run;
proc anova data=LR1.mydata6;
class pager;
model total_spent = pager; 
run;
proc anova data=LR1.mydata6;
class internet;
model total_spent = internet; 
run;
proc anova data=LR1.mydata6;
class callid;
model total_spent = callid; 
run;
proc anova data=LR1.mydata6;
class callwait;
model total_spent = callwait; 
run;
proc anova data=LR1.mydata6;
class forward;
model total_spent = forward; 
run;
proc anova data=LR1.mydata6;
class confer;
model total_spent = confer; 
run;
proc anova data=LR1.mydata6;
class ebill;
model total_spent = ebill; 
run;
proc anova data=LR1.mydata6;
class owntv;
model total_spent = owntv;
run;
proc anova data=LR1.mydata6;
class ownvcr;
model total_spent = ownvcr; 
run;
proc anova data=LR1.mydata6;
class owndvd;
model total_spent = owndvd; 
run;
proc anova data=LR1.mydata6;
class owncd;
model total_spent = owncd; 
run;
proc anova data=LR1.mydata6;
class ownpda;
model total_spent = ownpda; 
run;
proc anova data=LR1.mydata6;
class ownpc;
model total_spent = ownpc; 
run;
proc anova data=LR1.mydata6;
class ownipod;
model total_spent = ownipod; 
run;
proc anova data=LR1.mydata6;
class owngame;
model total_spent = owngame;
run;
proc anova data=LR1.mydata6;
class ownfax;
model total_spent = ownfax;
run;
proc anova data=LR1.mydata6;
class news;
model total_spent = news; 
run;
proc anova data=LR1.mydata6;
class response_01;
model total_spent = response_01;
run;
proc anova data=LR1.mydata6;
class response_02;
model total_spent = response_02; 
run;
proc anova data=LR1.mydata6;
class response_03;
model total_spent = response_03; 
run;

/* Performing Stepwise Regression for Varibale Reduction */

proc reg data=LR1.mydata6;
model ln_total_spent = age
ed
income
lninc
debtinc
creddebt
lncreddebt
othdebt
lnothdebt
spoused
reside
pets
pets_cats
pets_dogs
pets_birds
pets_reptiles
pets_small
pets_saltfish
pets_freshfish
carvalue
commutetime
tenure
longmon
lnlongmon
longten
lnlongten
tollmon
tollten
equipmon
equipten
lntollmon
lntollten
lnequipmon
lnequipten
lncardmon
lnwiremon
lnwireten
lncardten
cardmon
cardten
wiremon
wireten
hourstv
Total_fee
Total_items
gender
agecat
edcat
jobcat
employ
empcat
retire
inccat
jobsat
spousedcat
homeown
hometype
address
addresscat
carown
carcatvalue
commutebike
reason
card
vote
cardtenure
cardtenurecat
card2
card2tenure
card2tenurecat
equip
tollfree
callcard
wireless
multline
voice
pager
internet
callid
callwait
forward
confer
ownvcr
owndvd
owncd
ownpda
ownpc
ownipod
owngame
ownfax
news
response_02
response_03
/ selection = stepwise slentry=0.05 slstay=0.1 VIF STB;
run;

/* Dummy Variable creation */


data LR1.mydata7;
set LR1.mydata6;

if gender= 0 then gender_dummy=1;else gender_dummy=0;
if card= 1 then card_dummy1=1;else card_dummy1=0;
if card=2 then card_dummy2=1;else card_dummy2=0;
if card=3 then card_dummy3=1;else card_dummy3=0;
if card=4 then card_dummy4=1;else card_dummy4=0;
if card2= 1 then card2_dummy1=1;else card2_dummy1=0;
if card2=2 then card2_dummy2=1;else card2_dummy2=0;
if card2=3 then card2_dummy3=1;else card2_dummy3=0;
if card2=4 then card2_dummy4=1;else card2_dummy4=0;
if cardtenurecat= 1 then cardtenurecat_dummy1=1;else cardtenurecat_dummy1=0;
if cardtenurecat=2 then cardtenurecat_dummy2=1;else cardtenurecat_dummy2=0;
if cardtenurecat=3 then cardtenurecat_dummy3=1;else cardtenurecat_dummy3=0;
if cardtenurecat=4 then cardtenurecat_dummy4=1;else cardtenurecat_dummy4=0;
if response_03= 0 then response_03_dummy = 1; else response_03_dummy = 0;
run;


/* Training & Validation Data set Creation */

data dev val;
set LR1.mydata7;
if ranuni(1000)<0.7 then output dev;
else output val;
run;


/* Running the Linear Regression */

proc reg data=dev;
model ln_total_spent =
income
lninc
equipten
card_dummy1
card_dummy2
card_dummy3
card_dummy4
card2_dummy1
card2_dummy2
card2_dummy3
card2_dummy4
gender_dummy
cardtenurecat_dummy1
cardtenurecat_dummy2
cardtenurecat_dummy3
cardtenurecat_dummy4
response_03_dummy
/ selection = stepwise slentry=0.05 slstay=0.1 VIF STB;
output out= dev1 cookd=cd;
run;

data dev2;
set dev1;
if cd < (4/3500);
run;


proc reg data=dev2;
model ln_total_spent =lninc
card_dummy1
card_dummy4
card2_dummy1
card2_dummy4
gender_dummy
cardtenurecat_dummy2/ selection = stepwise slentry=0.05 slstay=0.1 VIF STB;
run;

proc reg data=dev2;
model ln_total_spent =lninc
card_dummy1
card_dummy4
card2_dummy1
card2_dummy4
gender_dummy
cardtenurecat_dummy2/ selection = stepwise slentry=0.05 slstay=0.1 VIF STB;
output out= dev3 cookd=cd1;
run;

data dev4;
set dev3;
if cd1 < (4/3389);
run;

proc reg data=dev4;
model ln_total_spent =lninc
card_dummy1
card_dummy4
card2_dummy1
card2_dummy4
gender_dummy
cardtenurecat_dummy2/ selection = stepwise slentry=0.05 slstay=0.1 VIF STB;
run;

/* Final Regression */

proc reg data=dev4 outest=reg_est;
model ln_total_spent =lninc
card_dummy1
card_dummy4
card2_dummy1
card2_dummy4
gender_dummy
cardtenurecat_dummy2
/ selection = forward slentry=0.05 slstay=0.1 VIF STB;
output out=dev5 p=ln_pre_spent;
run;


/* Decile Analysis for Developement Data set */

data dev5;
set dev5;
Pred_spent=Exp(Ln_pre_spent);
run;


proc rank data=dev5 out=dev6 descending groups=10; 
var Pred_spent; 
ranks Decile; 
run; 

Proc sql;
/* Create table Deciling_Development Dataset*/

select decile, mean(Pred_spent) as Avg_Pred_spent, mean(total_spent) as Avg_actual_spent,
sum(Pred_spent) as Tot_Pred_spent, sum(total_spent) as Tot_actual_spent
from dev6 group by decile;
quit;


/* Decile Analysis for Validation Dataset */
/* Validation (scoring)*/

data val1;
set val;
Ln_pred_spent = (lninc*0.34579)+
(card_dummy1*0.55388)+
(card_dummy4*-0.09457)+
(card2_dummy1*0.37213)+
(card2_dummy4*-0.0583)+
(gender_dummy*0.04868)+
(cardtenurecat_dummy2*0.10186)+4.58089;
pred_spent = Exp(Ln_pred_spent);
run;


proc rank data=val1 out=val2 ties=low 
descending groups=10; 
var pred_spent; 
ranks Decile; 
run; 


Proc sql;
/* create table Deciling_Validation Dataset  */
select Decile, mean(Pred_spent) as Avg_Pred_spent, mean(total_spent) as Avg_actual_spent,
sum(Pred_spent) as Tot_Pred_spent, sum(total_spent) as Tot_actual_spent
from val2 group by Decile;
quit;


/*************************************************END*************************************************/




