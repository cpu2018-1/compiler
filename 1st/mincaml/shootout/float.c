#include <math.h>
#include <stdio.h>
#include "float.h"

//必要に応じて実装を変更してください

float fadd(float a, float b){
    unsigned int x1,x2,x1a,x2a,s1a,s2a,sy,e1a,e2a,ey,m1a,m2a,my;
    unsigned int sm,m1b,m2b,mya,se,eya,eyb,myb,y;
    int i,bit;
    float r;

    x1 = *((unsigned int *)&a);
    x2 = *((unsigned int *)&b);
    if((x1 & 0x7fffffff) < (x2 & 0x7fffffff)){
	x1a = x2;
	x2a = x1;
    } else {
	x1a = x1;
	x2a = x2;
    }
    s1a = x1a >> 31;
    e1a = (x1a >> 23) & 0xff;
    m1a = x1a & 0x7fffff;
    s2a = x2a >> 31;
    e2a = (x2a >> 23) & 0xff;
    m2a = x2a & 0x7fffff;
    sm = e1a - e2a;
    m1b = (1 << 24) | (m1a << 1);
    if(sm < 32) m2b = ((1 << 24) | (m2a << 1)) >> sm;
    else m2b = 0;
    if(s1a == s2a) mya = m1b + m2b;
    else mya = m1b - m2b;
    for(i = 0;i < 26;i++){
	bit = (mya >> (25 - i)) & 1;
	if(bit == 1) break;
    }
    if(i == 26) se = 255;
    else se = i;
    sy = s1a;
    eya = e1a + 1;
    if(eya > se) eyb = eya - se;
    else eyb = 0;
    if(e2a == 0) ey = e1a;
    else ey = eyb;
    if (se < 32) myb = mya << se;
    else myb = 0;
    if(e2a == 0) my = m1a;
    else my = (myb >> 2) & 0x7fffff;
    y = (sy << 31) | (ey << 23) | my;
    r = *((float *)&y);
    
    return r;
}

float fsub(float a, float b){

    return fadd(a,-b);
  
}

float fmul(float a, float b){
    unsigned int x1,x2,s1,s2,sy,e1,e2,ey,m1,m2,my;
    unsigned int flag,e1a,e2a,eya,y,mya2;
    long mya;
    float r;
    x1 = *((unsigned int *)&a);
    x2 = *((unsigned int *)&b);
    s1 = x1 >> 31;
    e1 = (x1 & 0x7f800000) >> 23;
    m1 = x1 & 0x7fffff;
    s2 = x2 >> 31;
    e2 = (x2 & 0x7f800000) >> 23;
    m2 = x2 & 0x7fffff;
    sy = s1 ^ s2;
    mya = (long)((1 << 23) | m1) * (long)((1 << 23) | m2);
    mya = mya >> 20;
    mya2 = (unsigned int)mya;
    flag = (mya2 >> 27) & 1;
    if(flag == 1) my = (mya2 & 0x7ffffff) >> 4;
    else my = (mya2 & 0x3ffffff) >> 3;
    if(e2 == 0) e1a = 0;
    else e1a = e1;
    if(e1 == 0) e2a = 0;
    else e2a = e2;
    eya = e1a + e2a + flag;
    if(eya > 127) ey = eya - 127;
    else ey = 0;
    y = (sy << 31) | (ey << 23) | my;
    r = *((float *)&y);

    return r;

}

float fdiv(float a, float b){
    unsigned int x1,x2,sa,ea,ma,mal,mx0,mx2;
    x1 = *((unsigned int *)&a);
    x2 = *((unsigned int *)&b);
    sa = x2 >> 31; 
    ea = (x2 & 0x7fffffff) >> 23;
    ma = x2 & 0x7fffff;
    mal = ma >> 12;

    switch(mal){
    case 0:
        mx0 = 8384512;
        mx2 = 8380417;
        break;
    case 1:
        mx0 = 8376329;
        mx2 = 8364059;
        break;
    case 2:
        mx0 = 8368153;
        mx2 = 8347723;
        break;
    case 3:
        mx0 = 8359984;
        mx2 = 8331409;
        break;
    case 4:
        mx0 = 8351825;
        mx2 = 8315123;
        break;
    case 5:
        mx0 = 8343672;
        mx2 = 8298856;
        break;
    case 6:
        mx0 = 8335529;
        mx2 = 8282618;
        break;
    case 7:
        mx0 = 8327393;
        mx2 = 8266401;
        break;
    case 8:
        mx0 = 8319263;
        mx2 = 8250205;
        break;
    case 9:
        mx0 = 8311143;
        mx2 = 8234036;
        break;
    case 10:
        mx0 = 8303032;
        mx2 = 8217892;
        break;
    case 11:
        mx0 = 8294927;
        mx2 = 8201769;
        break;
    case 12:
        mx0 = 8286830;
        mx2 = 8185669;
        break;
    case 13:
        mx0 = 8278742;
        mx2 = 8169595;
        break;
    case 14:
        mx0 = 8270659;
        mx2 = 8153539;
        break;
    case 15:
        mx0 = 8262586;
        mx2 = 8137511;
        break;
    case 16:
        mx0 = 8254520;
        mx2 = 8121504;
        break;
    case 17:
        mx0 = 8246462;
        mx2 = 8105520;
        break;
    case 18:
        mx0 = 8238414;
        mx2 = 8089565;
        break;
    case 19:
        mx0 = 8230371;
        mx2 = 8073626;
        break;
    case 20:
        mx0 = 8222337;
        mx2 = 8057714;
        break;
    case 21:
        mx0 = 8214310;
        mx2 = 8041823;
        break;
    case 22:
        mx0 = 8206291;
        mx2 = 8025955;
        break;
    case 23:
        mx0 = 8198280;
        mx2 = 8010111;
        break;
    case 24:
        mx0 = 8190278;
        mx2 = 7994293;
        break;
    case 25:
        mx0 = 8182281;
        mx2 = 7978491;
        break;
    case 26:
        mx0 = 8174293;
        mx2 = 7962716;
        break;
    case 27:
        mx0 = 8166312;
        mx2 = 7946961;
        break;
    case 28:
        mx0 = 8158342;
        mx2 = 7931236;
        break;
    case 29:
        mx0 = 8150376;
        mx2 = 7915527;
        break;
    case 30:
        mx0 = 8142418;
        mx2 = 7899841;
        break;
    case 31:
        mx0 = 8134469;
        mx2 = 7884180;
        break;
    case 32:
        mx0 = 8126528;
        mx2 = 7868542;
        break;
    case 33:
        mx0 = 8118592;
        mx2 = 7852922;
        break;
    case 34:
        mx0 = 8110667;
        mx2 = 7837331;
        break;
    case 35:
        mx0 = 8102747;
        mx2 = 7821757;
        break;
    case 36:
        mx0 = 8094835;
        mx2 = 7806206;
        break;
    case 37:
        mx0 = 8086933;
        mx2 = 7790682;
        break;
    case 38:
        mx0 = 8079035;
        mx2 = 7775174;
        break;
    case 39:
        mx0 = 8071147;
        mx2 = 7759693;
        break;
    case 40:
        mx0 = 8063265;
        mx2 = 7744231;
        break;
    case 41:
        mx0 = 8055392;
        mx2 = 7728794;
        break;
    case 42:
        mx0 = 8047526;
        mx2 = 7713378;
        break;
    case 43:
        mx0 = 8039667;
        mx2 = 7697983;
        break;
    case 44:
        mx0 = 8031816;
        mx2 = 7682612;
        break;
    case 45:
        mx0 = 8023974;
        mx2 = 7667265;
        break;
    case 46:
        mx0 = 8016137;
        mx2 = 7651935;
        break;
    case 47:
        mx0 = 8008309;
        mx2 = 7636630;
        break;
    case 48:
        mx0 = 8000487;
        mx2 = 7621345;
        break;
    case 49:
        mx0 = 7992673;
        mx2 = 7606082;
        break;
    case 50:
        mx0 = 7984869;
        mx2 = 7590846;
        break;
    case 51:
        mx0 = 7977069;
        mx2 = 7575625;
        break;
    case 52:
        mx0 = 7969278;
        mx2 = 7560429;
        break;
    case 53:
        mx0 = 7961495;
        mx2 = 7545255;
        break;
    case 54:
        mx0 = 7953717;
        mx2 = 7530099;
        break;
    case 55:
        mx0 = 7945947;
        mx2 = 7514965;
        break;
    case 56:
        mx0 = 7938186;
        mx2 = 7499857;
        break;
    case 57:
        mx0 = 7930432;
        mx2 = 7484769;
        break;
    case 58:
        mx0 = 7922686;
        mx2 = 7469703;
        break;
    case 59:
        mx0 = 7914945;
        mx2 = 7454655;
        break;
    case 60:
        mx0 = 7907213;
        mx2 = 7439631;
        break;
    case 61:
        mx0 = 7899488;
        mx2 = 7424628;
        break;
    case 62:
        mx0 = 7891771;
        mx2 = 7409647;
        break;
    case 63:
        mx0 = 7884061;
        mx2 = 7394687;
        break;
    case 64:
        mx0 = 7876358;
        mx2 = 7379748;
        break;
    case 65:
        mx0 = 7868661;
        mx2 = 7364828;
        break;
    case 66:
        mx0 = 7860973;
        mx2 = 7349932;
        break;
    case 67:
        mx0 = 7853291;
        mx2 = 7335055;
        break;
    case 68:
        mx0 = 7845617;
        mx2 = 7320200;
        break;
    case 69:
        mx0 = 7837951;
        mx2 = 7305368;
        break;
    case 70:
        mx0 = 7830291;
        mx2 = 7290554;
        break;
    case 71:
        mx0 = 7822639;
        mx2 = 7275763;
        break;
    case 72:
        mx0 = 7814994;
        mx2 = 7260992;
        break;
    case 73:
        mx0 = 7807357;
        mx2 = 7246244;
        break;
    case 74:
        mx0 = 7799725;
        mx2 = 7231512;
        break;
    case 75:
        mx0 = 7792104;
        mx2 = 7216808;
        break;
    case 76:
        mx0 = 7784487;
        mx2 = 7202119;
        break;
    case 77:
        mx0 = 7776877;
        mx2 = 7187451;
        break;
    case 78:
        mx0 = 7769275;
        mx2 = 7172805;
        break;
    case 79:
        mx0 = 7761680;
        mx2 = 7158179;
        break;
    case 80:
        mx0 = 7754094;
        mx2 = 7143577;
        break;
    case 81:
        mx0 = 7746512;
        mx2 = 7128990;
        break;
    case 82:
        mx0 = 7738939;
        mx2 = 7114427;
        break;
    case 83:
        mx0 = 7731373;
        mx2 = 7099885;
        break;
    case 84:
        mx0 = 7723813;
        mx2 = 7085360;
        break;
    case 85:
        mx0 = 7716262;
        mx2 = 7070860;
        break;
    case 86:
        mx0 = 7708717;
        mx2 = 7056378;
        break;
    case 87:
        mx0 = 7701177;
        mx2 = 7041913;
        break;
    case 88:
        mx0 = 7693648;
        mx2 = 7027475;
        break;
    case 89:
        mx0 = 7686125;
        mx2 = 7013056;
        break;
    case 90:
        mx0 = 7678607;
        mx2 = 6998653;
        break;
    case 91:
        mx0 = 7671096;
        mx2 = 6984270;
        break;
    case 92:
        mx0 = 7663594;
        mx2 = 6969911;
        break;
    case 93:
        mx0 = 7656098;
        mx2 = 6955570;
        break;
    case 94:
        mx0 = 7648609;
        mx2 = 6941249;
        break;
    case 95:
        mx0 = 7641127;
        mx2 = 6926949;
        break;
    case 96:
        mx0 = 7633653;
        mx2 = 6912670;
        break;
    case 97:
        mx0 = 7626184;
        mx2 = 6898408;
        break;
    case 98:
        mx0 = 7618726;
        mx2 = 6884173;
        break;
    case 99:
        mx0 = 7611271;
        mx2 = 6869950;
        break;
    case 100:
        mx0 = 7603824;
        mx2 = 6855750;
        break;
    case 101:
        mx0 = 7596383;
        mx2 = 6841567;
        break;
    case 102:
        mx0 = 7588951;
        mx2 = 6827408;
        break;
    case 103:
        mx0 = 7581523;
        mx2 = 6813264;
        break;
    case 104:
        mx0 = 7574105;
        mx2 = 6799145;
        break;
    case 105:
        mx0 = 7566691;
        mx2 = 6785040;
        break;
    case 106:
        mx0 = 7559287;
        mx2 = 6770960;
        break;
    case 107:
        mx0 = 7551887;
        mx2 = 6756895;
        break;
    case 108:
        mx0 = 7544496;
        mx2 = 6742854;
        break;
    case 109:
        mx0 = 7537112;
        mx2 = 6728832;
        break;
    case 110:
        mx0 = 7529733;
        mx2 = 6714826;
        break;
    case 111:
        mx0 = 7522361;
        mx2 = 6700840;
        break;
    case 112:
        mx0 = 7514998;
        mx2 = 6686878;
        break;
    case 113:
        mx0 = 7507640;
        mx2 = 6672931;
        break;
    case 114:
        mx0 = 7500288;
        mx2 = 6659003;
        break;
    case 115:
        mx0 = 7492945;
        mx2 = 6645098;
        break;
    case 116:
        mx0 = 7485608;
        mx2 = 6631210;
        break;
    case 117:
        mx0 = 7478277;
        mx2 = 6617341;
        break;
    case 118:
        mx0 = 7470952;
        mx2 = 6603489;
        break;
    case 119:
        mx0 = 7463637;
        mx2 = 6589662;
        break;
    case 120:
        mx0 = 7456325;
        mx2 = 6575847;
        break;
    case 121:
        mx0 = 7449024;
        mx2 = 6562060;
        break;
    case 122:
        mx0 = 7441726;
        mx2 = 6548285;
        break;
    case 123:
        mx0 = 7434435;
        mx2 = 6534529;
        break;
    case 124:
        mx0 = 7427153;
        mx2 = 6520796;
        break;
    case 125:
        mx0 = 7419874;
        mx2 = 6507076;
        break;
    case 126:
        mx0 = 7412606;
        mx2 = 6493382;
        break;
    case 127:
        mx0 = 7405342;
        mx2 = 6479702;
        break;
    case 128:
        mx0 = 7398086;
        mx2 = 6466044;
        break;
    case 129:
        mx0 = 7390835;
        mx2 = 6452401;
        break;
    case 130:
        mx0 = 7383593;
        mx2 = 6438782;
        break;
    case 131:
        mx0 = 7376357;
        mx2 = 6425180;
        break;
    case 132:
        mx0 = 7369126;
        mx2 = 6411594;
        break;
    case 133:
        mx0 = 7361902;
        mx2 = 6398027;
        break;
    case 134:
        mx0 = 7354686;
        mx2 = 6384481;
        break;
    case 135:
        mx0 = 7347475;
        mx2 = 6370951;
        break;
    case 136:
        mx0 = 7340272;
        mx2 = 6357442;
        break;
    case 137:
        mx0 = 7333075;
        mx2 = 6343951;
        break;
    case 138:
        mx0 = 7325885;
        mx2 = 6330478;
        break;
    case 139:
        mx0 = 7318701;
        mx2 = 6317023;
        break;
    case 140:
        mx0 = 7311523;
        mx2 = 6303586;
        break;
    case 141:
        mx0 = 7304353;
        mx2 = 6290170;
        break;
    case 142:
        mx0 = 7297189;
        mx2 = 6276771;
        break;
    case 143:
        mx0 = 7290032;
        mx2 = 6263391;
        break;
    case 144:
        mx0 = 7282880;
        mx2 = 6250027;
        break;
    case 145:
        mx0 = 7275736;
        mx2 = 6236683;
        break;
    case 146:
        mx0 = 7268598;
        mx2 = 6223357;
        break;
    case 147:
        mx0 = 7261466;
        mx2 = 6210049;
        break;
    case 148:
        mx0 = 7254342;
        mx2 = 6196761;
        break;
    case 149:
        mx0 = 7247224;
        mx2 = 6183490;
        break;
    case 150:
        mx0 = 7240112;
        mx2 = 6170237;
        break;
    case 151:
        mx0 = 7233006;
        mx2 = 6157001;
        break;
    case 152:
        mx0 = 7225906;
        mx2 = 6143782;
        break;
    case 153:
        mx0 = 7218813;
        mx2 = 6130582;
        break;
    case 154:
        mx0 = 7211728;
        mx2 = 6117403;
        break;
    case 155:
        mx0 = 7204648;
        mx2 = 6104239;
        break;
    case 156:
        mx0 = 7197574;
        mx2 = 6091093;
        break;
    case 157:
        mx0 = 7190506;
        mx2 = 6077963;
        break;
    case 158:
        mx0 = 7183447;
        mx2 = 6064857;
        break;
    case 159:
        mx0 = 7176393;
        mx2 = 6051765;
        break;
    case 160:
        mx0 = 7169344;
        mx2 = 6038689;
        break;
    case 161:
        mx0 = 7162304;
        mx2 = 6025635;
        break;
    case 162:
        mx0 = 7155269;
        mx2 = 6012596;
        break;
    case 163:
        mx0 = 7148240;
        mx2 = 5999575;
        break;
    case 164:
        mx0 = 7141217;
        mx2 = 5986570;
        break;
    case 165:
        mx0 = 7134201;
        mx2 = 5973584;
        break;
    case 166:
        mx0 = 7127192;
        mx2 = 5960617;
        break;
    case 167:
        mx0 = 7120190;
        mx2 = 5947669;
        break;
    case 168:
        mx0 = 7113192;
        mx2 = 5934734;
        break;
    case 169:
        mx0 = 7106201;
        mx2 = 5921818;
        break;
    case 170:
        mx0 = 7099217;
        mx2 = 5908920;
        break;
    case 171:
        mx0 = 7092239;
        mx2 = 5896040;
        break;
    case 172:
        mx0 = 7085267;
        mx2 = 5883176;
        break;
    case 173:
        mx0 = 7078301;
        mx2 = 5870329;
        break;
    case 174:
        mx0 = 7071342;
        mx2 = 5857501;
        break;
    case 175:
        mx0 = 7064390;
        mx2 = 5844692;
        break;
    case 176:
        mx0 = 7057442;
        mx2 = 5831896;
        break;
    case 177:
        mx0 = 7050502;
        mx2 = 5819120;
        break;
    case 178:
        mx0 = 7043568;
        mx2 = 5806361;
        break;
    case 179:
        mx0 = 7036639;
        mx2 = 5793617;
        break;
    case 180:
        mx0 = 7029717;
        mx2 = 5780891;
        break;
    case 181:
        mx0 = 7022801;
        mx2 = 5768182;
        break;
    case 182:
        mx0 = 7015893;
        mx2 = 5755494;
        break;
    case 183:
        mx0 = 7008989;
        mx2 = 5742818;
        break;
    case 184:
        mx0 = 7002091;
        mx2 = 5730160;
        break;
    case 185:
        mx0 = 6995201;
        mx2 = 5717521;
        break;
    case 186:
        mx0 = 6988318;
        mx2 = 5704902;
        break;
    case 187:
        mx0 = 6981438;
        mx2 = 5692293;
        break;
    case 188:
        mx0 = 6974566;
        mx2 = 5679704;
        break;
    case 189:
        mx0 = 6967701;
        mx2 = 5667134;
        break;
    case 190:
        mx0 = 6960840;
        mx2 = 5654577;
        break;
    case 191:
        mx0 = 6953985;
        mx2 = 5642037;
        break;
    case 192:
        mx0 = 6947137;
        mx2 = 5629515;
        break;
    case 193:
        mx0 = 6940297;
        mx2 = 5617013;
        break;
    case 194:
        mx0 = 6933461;
        mx2 = 5604524;
        break;
    case 195:
        mx0 = 6926632;
        mx2 = 5592053;
        break;
    case 196:
        mx0 = 6919807;
        mx2 = 5579596;
        break;
    case 197:
        mx0 = 6912990;
        mx2 = 5567158;
        break;
    case 198:
        mx0 = 6906179;
        mx2 = 5554737;
        break;
    case 199:
        mx0 = 6899374;
        mx2 = 5542332;
        break;
    case 200:
        mx0 = 6892574;
        mx2 = 5529942;
        break;
    case 201:
        mx0 = 6885781;
        mx2 = 5517570;
        break;
    case 202:
        mx0 = 6878993;
        mx2 = 5505213;
        break;
    case 203:
        mx0 = 6872214;
        mx2 = 5492878;
        break;
    case 204:
        mx0 = 6865438;
        mx2 = 5480554;
        break;
    case 205:
        mx0 = 6858670;
        mx2 = 5468249;
        break;
    case 206:
        mx0 = 6851906;
        mx2 = 5455958;
        break;
    case 207:
        mx0 = 6845149;
        mx2 = 5443684;
        break;
    case 208:
        mx0 = 6838398;
        mx2 = 5431427;
        break;
    case 209:
        mx0 = 6831654;
        mx2 = 5419188;
        break;
    case 210:
        mx0 = 6824914;
        mx2 = 5406962;
        break;
    case 211:
        mx0 = 6818181;
        mx2 = 5394753;
        break;
    case 212:
        mx0 = 6811451;
        mx2 = 5382556;
        break;
    case 213:
        mx0 = 6804733;
        mx2 = 5370386;
        break;
    case 214:
        mx0 = 6798016;
        mx2 = 5358223;
        break;
    case 215:
        mx0 = 6791307;
        mx2 = 5346080;
        break;
    case 216:
        mx0 = 6784603;
        mx2 = 5333951;
        break;
    case 217:
        mx0 = 6777906;
        mx2 = 5321840;
        break;
    case 218:
        mx0 = 6771215;
        mx2 = 5309745;
        break;
    case 219:
        mx0 = 6764529;
        mx2 = 5297665;
        break;
    case 220:
        mx0 = 6757849;
        mx2 = 5285601;
        break;
    case 221:
        mx0 = 6751175;
        mx2 = 5273553;
        break;
    case 222:
        mx0 = 6744507;
        mx2 = 5261521;
        break;
    case 223:
        mx0 = 6737845;
        mx2 = 5249506;
        break;
    case 224:
        mx0 = 6731190;
        mx2 = 5237508;
        break;
    case 225:
        mx0 = 6724539;
        mx2 = 5225523;
        break;
    case 226:
        mx0 = 6717895;
        mx2 = 5213555;
        break;
    case 227:
        mx0 = 6711255;
        mx2 = 5201600;
        break;
    case 228:
        mx0 = 6704623;
        mx2 = 5189665;
        break;
    case 229:
        mx0 = 6697994;
        mx2 = 5177741;
        break;
    case 230:
        mx0 = 6691374;
        mx2 = 5165837;
        break;
    case 231:
        mx0 = 6684758;
        mx2 = 5153947;
        break;
    case 232:
        mx0 = 6678149;
        mx2 = 5142074;
        break;
    case 233:
        mx0 = 6671545;
        mx2 = 5130215;
        break;
    case 234:
        mx0 = 6664946;
        mx2 = 5118370;
        break;
    case 235:
        mx0 = 6658354;
        mx2 = 5106543;
        break;
    case 236:
        mx0 = 6651768;
        mx2 = 5094732;
        break;
    case 237:
        mx0 = 6645187;
        mx2 = 5082935;
        break;
    case 238:
        mx0 = 6638613;
        mx2 = 5071156;
        break;
    case 239:
        mx0 = 6632043;
        mx2 = 5059389;
        break;
    case 240:
        mx0 = 6625479;
        mx2 = 5047638;
        break;
    case 241:
        mx0 = 6618921;
        mx2 = 5035903;
        break;
    case 242:
        mx0 = 6612369;
        mx2 = 5024184;
        break;
    case 243:
        mx0 = 6605823;
        mx2 = 5012481;
        break;
    case 244:
        mx0 = 6599282;
        mx2 = 5000791;
        break;
    case 245:
        mx0 = 6592746;
        mx2 = 4989116;
        break;
    case 246:
        mx0 = 6586217;
        mx2 = 4977458;
        break;
    case 247:
        mx0 = 6579695;
        mx2 = 4965818;
        break;
    case 248:
        mx0 = 6573177;
        mx2 = 4954190;
        break;
    case 249:
        mx0 = 6566665;
        mx2 = 4942578;
        break;
    case 250:
        mx0 = 6560159;
        mx2 = 4930982;
        break;
    case 251:
        mx0 = 6553657;
        mx2 = 4919398;
        break;
    case 252:
        mx0 = 6547162;
        mx2 = 4907831;
        break;
    case 253:
        mx0 = 6540672;
        mx2 = 4896278;
        break;
    case 254:
        mx0 = 6534189;
        mx2 = 4884743;
        break;
    case 255:
        mx0 = 6527710;
        mx2 = 4873219;
        break;
    case 256:
        mx0 = 6521238;
        mx2 = 4861714;
        break;
    case 257:
        mx0 = 6514769;
        mx2 = 4850218;
        break;
    case 258:
        mx0 = 6508310;
        mx2 = 4838745;
        break;
    case 259:
        mx0 = 6501853;
        mx2 = 4827281;
        break;
    case 260:
        mx0 = 6495403;
        mx2 = 4815834;
        break;
    case 261:
        mx0 = 6488958;
        mx2 = 4804402;
        break;
    case 262:
        mx0 = 6482519;
        mx2 = 4792984;
        break;
    case 263:
        mx0 = 6476086;
        mx2 = 4781582;
        break;
    case 264:
        mx0 = 6469657;
        mx2 = 4770193;
        break;
    case 265:
        mx0 = 6463237;
        mx2 = 4758824;
        break;
    case 266:
        mx0 = 6456818;
        mx2 = 4747461;
        break;
    case 267:
        mx0 = 6450407;
        mx2 = 4736118;
        break;
    case 268:
        mx0 = 6444001;
        mx2 = 4724789;
        break;
    case 269:
        mx0 = 6437600;
        mx2 = 4713473;
        break;
    case 270:
        mx0 = 6431206;
        mx2 = 4702175;
        break;
    case 271:
        mx0 = 6424817;
        mx2 = 4690890;
        break;
    case 272:
        mx0 = 6418433;
        mx2 = 4679619;
        break;
    case 273:
        mx0 = 6412056;
        mx2 = 4668365;
        break;
    case 274:
        mx0 = 6405682;
        mx2 = 4657121;
        break;
    case 275:
        mx0 = 6399314;
        mx2 = 4645893;
        break;
    case 276:
        mx0 = 6392952;
        mx2 = 4634680;
        break;
    case 277:
        mx0 = 6386597;
        mx2 = 4623484;
        break;
    case 278:
        mx0 = 6380246;
        mx2 = 4612300;
        break;
    case 279:
        mx0 = 6373899;
        mx2 = 4601128;
        break;
    case 280:
        mx0 = 6367560;
        mx2 = 4589975;
        break;
    case 281:
        mx0 = 6361225;
        mx2 = 4578834;
        break;
    case 282:
        mx0 = 6354898;
        mx2 = 4567711;
        break;
    case 283:
        mx0 = 6348573;
        mx2 = 4556597;
        break;
    case 284:
        mx0 = 6342256;
        mx2 = 4545502;
        break;
    case 285:
        mx0 = 6335943;
        mx2 = 4534418;
        break;
    case 286:
        mx0 = 6329635;
        mx2 = 4523348;
        break;
    case 287:
        mx0 = 6323333;
        mx2 = 4512293;
        break;
    case 288:
        mx0 = 6317038;
        mx2 = 4501256;
        break;
    case 289:
        mx0 = 6310745;
        mx2 = 4490226;
        break;
    case 290:
        mx0 = 6304459;
        mx2 = 4479213;
        break;
    case 291:
        mx0 = 6298179;
        mx2 = 4468216;
        break;
    case 292:
        mx0 = 6291904;
        mx2 = 4457232;
        break;
    case 293:
        mx0 = 6285635;
        mx2 = 4446263;
        break;
    case 294:
        mx0 = 6279370;
        mx2 = 4435306;
        break;
    case 295:
        mx0 = 6273111;
        mx2 = 4424364;
        break;
    case 296:
        mx0 = 6266857;
        mx2 = 4413436;
        break;
    case 297:
        mx0 = 6260608;
        mx2 = 4402521;
        break;
    case 298:
        mx0 = 6254366;
        mx2 = 4391622;
        break;
    case 299:
        mx0 = 6248129;
        mx2 = 4380738;
        break;
    case 300:
        mx0 = 6241896;
        mx2 = 4369864;
        break;
    case 301:
        mx0 = 6235669;
        mx2 = 4359006;
        break;
    case 302:
        mx0 = 6229448;
        mx2 = 4348163;
        break;
    case 303:
        mx0 = 6223232;
        mx2 = 4337333;
        break;
    case 304:
        mx0 = 6217019;
        mx2 = 4326514;
        break;
    case 305:
        mx0 = 6210814;
        mx2 = 4315712;
        break;
    case 306:
        mx0 = 6204613;
        mx2 = 4304922;
        break;
    case 307:
        mx0 = 6198417;
        mx2 = 4294146;
        break;
    case 308:
        mx0 = 6192227;
        mx2 = 4283384;
        break;
    case 309:
        mx0 = 6186043;
        mx2 = 4272638;
        break;
    case 310:
        mx0 = 6179863;
        mx2 = 4261903;
        break;
    case 311:
        mx0 = 6173689;
        mx2 = 4251182;
        break;
    case 312:
        mx0 = 6167520;
        mx2 = 4240476;
        break;
    case 313:
        mx0 = 6161357;
        mx2 = 4229784;
        break;
    case 314:
        mx0 = 6155197;
        mx2 = 4219101;
        break;
    case 315:
        mx0 = 6149043;
        mx2 = 4208434;
        break;
    case 316:
        mx0 = 6142896;
        mx2 = 4197783;
        break;
    case 317:
        mx0 = 6136752;
        mx2 = 4187143;
        break;
    case 318:
        mx0 = 6130614;
        mx2 = 4176516;
        break;
    case 319:
        mx0 = 6124481;
        mx2 = 4165904;
        break;
    case 320:
        mx0 = 6118354;
        mx2 = 4155306;
        break;
    case 321:
        mx0 = 6112232;
        mx2 = 4144721;
        break;
    case 322:
        mx0 = 6106114;
        mx2 = 4134147;
        break;
    case 323:
        mx0 = 6100002;
        mx2 = 4123588;
        break;
    case 324:
        mx0 = 6093896;
        mx2 = 4113044;
        break;
    case 325:
        mx0 = 6087793;
        mx2 = 4102510;
        break;
    case 326:
        mx0 = 6081696;
        mx2 = 4091991;
        break;
    case 327:
        mx0 = 6075605;
        mx2 = 4081486;
        break;
    case 328:
        mx0 = 6069520;
        mx2 = 4070996;
        break;
    case 329:
        mx0 = 6063439;
        mx2 = 4060517;
        break;
    case 330:
        mx0 = 6057360;
        mx2 = 4050046;
        break;
    case 331:
        mx0 = 6051290;
        mx2 = 4039595;
        break;
    case 332:
        mx0 = 6045225;
        mx2 = 4029158;
        break;
    case 333:
        mx0 = 6039163;
        mx2 = 4018729;
        break;
    case 334:
        mx0 = 6033107;
        mx2 = 4008316;
        break;
    case 335:
        mx0 = 6027057;
        mx2 = 3997917;
        break;
    case 336:
        mx0 = 6021011;
        mx2 = 3987529;
        break;
    case 337:
        mx0 = 6014971;
        mx2 = 3977156;
        break;
    case 338:
        mx0 = 6008937;
        mx2 = 3966797;
        break;
    case 339:
        mx0 = 6002906;
        mx2 = 3956448;
        break;
    case 340:
        mx0 = 5996880;
        mx2 = 3946112;
        break;
    case 341:
        mx0 = 5990862;
        mx2 = 3935794;
        break;
    case 342:
        mx0 = 5984846;
        mx2 = 3925484;
        break;
    case 343:
        mx0 = 5978834;
        mx2 = 3915185;
        break;
    case 344:
        mx0 = 5972829;
        mx2 = 3904902;
        break;
    case 345:
        mx0 = 5966830;
        mx2 = 3894634;
        break;
    case 346:
        mx0 = 5960834;
        mx2 = 3884375;
        break;
    case 347:
        mx0 = 5954843;
        mx2 = 3874129;
        break;
    case 348:
        mx0 = 5948858;
        mx2 = 3863897;
        break;
    case 349:
        mx0 = 5942879;
        mx2 = 3853681;
        break;
    case 350:
        mx0 = 5936904;
        mx2 = 3843475;
        break;
    case 351:
        mx0 = 5930933;
        mx2 = 3833280;
        break;
    case 352:
        mx0 = 5924969;
        mx2 = 3823101;
        break;
    case 353:
        mx0 = 5919008;
        mx2 = 3812932;
        break;
    case 354:
        mx0 = 5913051;
        mx2 = 3802774;
        break;
    case 355:
        mx0 = 5907103;
        mx2 = 3792635;
        break;
    case 356:
        mx0 = 5901157;
        mx2 = 3782505;
        break;
    case 357:
        mx0 = 5895216;
        mx2 = 3772386;
        break;
    case 358:
        mx0 = 5889281;
        mx2 = 3762282;
        break;
    case 359:
        mx0 = 5883350;
        mx2 = 3752190;
        break;
    case 360:
        mx0 = 5877424;
        mx2 = 3742110;
        break;
    case 361:
        mx0 = 5871504;
        mx2 = 3732044;
        break;
    case 362:
        mx0 = 5865587;
        mx2 = 3721987;
        break;
    case 363:
        mx0 = 5859678;
        mx2 = 3711949;
        break;
    case 364:
        mx0 = 5853771;
        mx2 = 3701918;
        break;
    case 365:
        mx0 = 5847869;
        mx2 = 3691899;
        break;
    case 366:
        mx0 = 5841973;
        mx2 = 3681895;
        break;
    case 367:
        mx0 = 5836081;
        mx2 = 3671902;
        break;
    case 368:
        mx0 = 5830197;
        mx2 = 3661926;
        break;
    case 369:
        mx0 = 5824313;
        mx2 = 3651955;
        break;
    case 370:
        mx0 = 5818437;
        mx2 = 3642001;
        break;
    case 371:
        mx0 = 5812565;
        mx2 = 3632058;
        break;
    case 372:
        mx0 = 5806698;
        mx2 = 3622128;
        break;
    case 373:
        mx0 = 5800835;
        mx2 = 3612209;
        break;
    case 374:
        mx0 = 5794978;
        mx2 = 3602303;
        break;
    case 375:
        mx0 = 5789126;
        mx2 = 3592411;
        break;
    case 376:
        mx0 = 5783279;
        mx2 = 3582531;
        break;
    case 377:
        mx0 = 5777437;
        mx2 = 3572663;
        break;
    case 378:
        mx0 = 5771597;
        mx2 = 3562803;
        break;
    case 379:
        mx0 = 5765763;
        mx2 = 3552957;
        break;
    case 380:
        mx0 = 5759936;
        mx2 = 3543127;
        break;
    case 381:
        mx0 = 5754112;
        mx2 = 3533306;
        break;
    case 382:
        mx0 = 5748293;
        mx2 = 3523498;
        break;
    case 383:
        mx0 = 5742480;
        mx2 = 3513703;
        break;
    case 384:
        mx0 = 5736671;
        mx2 = 3503920;
        break;
    case 385:
        mx0 = 5730865;
        mx2 = 3494145;
        break;
    case 386:
        mx0 = 5725065;
        mx2 = 3484385;
        break;
    case 387:
        mx0 = 5719271;
        mx2 = 3474639;
        break;
    case 388:
        mx0 = 5713481;
        mx2 = 3464903;
        break;
    case 389:
        mx0 = 5707696;
        mx2 = 3455180;
        break;
    case 390:
        mx0 = 5701915;
        mx2 = 3445467;
        break;
    case 391:
        mx0 = 5696138;
        mx2 = 3435766;
        break;
    case 392:
        mx0 = 5690368;
        mx2 = 3426080;
        break;
    case 393:
        mx0 = 5684601;
        mx2 = 3416403;
        break;
    case 394:
        mx0 = 5678839;
        mx2 = 3406738;
        break;
    case 395:
        mx0 = 5673081;
        mx2 = 3397084;
        break;
    case 396:
        mx0 = 5667329;
        mx2 = 3387444;
        break;
    case 397:
        mx0 = 5661581;
        mx2 = 3377814;
        break;
    case 398:
        mx0 = 5655839;
        mx2 = 3368199;
        break;
    case 399:
        mx0 = 5650101;
        mx2 = 3358594;
        break;
    case 400:
        mx0 = 5644367;
        mx2 = 3349000;
        break;
    case 401:
        mx0 = 5638638;
        mx2 = 3339418;
        break;
    case 402:
        mx0 = 5632913;
        mx2 = 3329847;
        break;
    case 403:
        mx0 = 5627194;
        mx2 = 3320290;
        break;
    case 404:
        mx0 = 5621479;
        mx2 = 3310743;
        break;
    case 405:
        mx0 = 5615769;
        mx2 = 3301208;
        break;
    case 406:
        mx0 = 5610064;
        mx2 = 3291686;
        break;
    case 407:
        mx0 = 5604362;
        mx2 = 3282173;
        break;
    case 408:
        mx0 = 5598665;
        mx2 = 3272672;
        break;
    case 409:
        mx0 = 5592974;
        mx2 = 3263184;
        break;
    case 410:
        mx0 = 5587287;
        mx2 = 3253707;
        break;
    case 411:
        mx0 = 5581605;
        mx2 = 3244243;
        break;
    case 412:
        mx0 = 5575928;
        mx2 = 3234790;
        break;
    case 413:
        mx0 = 5570254;
        mx2 = 3225347;
        break;
    case 414:
        mx0 = 5564586;
        mx2 = 3215917;
        break;
    case 415:
        mx0 = 5558921;
        mx2 = 3206496;
        break;
    case 416:
        mx0 = 5553262;
        mx2 = 3197089;
        break;
    case 417:
        mx0 = 5547608;
        mx2 = 3187694;
        break;
    case 418:
        mx0 = 5541957;
        mx2 = 3178308;
        break;
    case 419:
        mx0 = 5536312;
        mx2 = 3168935;
        break;
    case 420:
        mx0 = 5530672;
        mx2 = 3159575;
        break;
    case 421:
        mx0 = 5525033;
        mx2 = 3150220;
        break;
    case 422:
        mx0 = 5519401;
        mx2 = 3140880;
        break;
    case 423:
        mx0 = 5513775;
        mx2 = 3131554;
        break;
    case 424:
        mx0 = 5508151;
        mx2 = 3122236;
        break;
    case 425:
        mx0 = 5502533;
        mx2 = 3112931;
        break;
    case 426:
        mx0 = 5496920;
        mx2 = 3103638;
        break;
    case 427:
        mx0 = 5491311;
        mx2 = 3094355;
        break;
    case 428:
        mx0 = 5485706;
        mx2 = 3085083;
        break;
    case 429:
        mx0 = 5480106;
        mx2 = 3075823;
        break;
    case 430:
        mx0 = 5474510;
        mx2 = 3066573;
        break;
    case 431:
        mx0 = 5468920;
        mx2 = 3057336;
        break;
    case 432:
        mx0 = 5463333;
        mx2 = 3048109;
        break;
    case 433:
        mx0 = 5457750;
        mx2 = 3038892;
        break;
    case 434:
        mx0 = 5452173;
        mx2 = 3029688;
        break;
    case 435:
        mx0 = 5446600;
        mx2 = 3020495;
        break;
    case 436:
        mx0 = 5441031;
        mx2 = 3011312;
        break;
    case 437:
        mx0 = 5435469;
        mx2 = 3002144;
        break;
    case 438:
        mx0 = 5429907;
        mx2 = 2992980;
        break;
    case 439:
        mx0 = 5424352;
        mx2 = 2983831;
        break;
    case 440:
        mx0 = 5418801;
        mx2 = 2974692;
        break;
    case 441:
        mx0 = 5413256;
        mx2 = 2965567;
        break;
    case 442:
        mx0 = 5407714;
        mx2 = 2956451;
        break;
    case 443:
        mx0 = 5402176;
        mx2 = 2947344;
        break;
    case 444:
        mx0 = 5396643;
        mx2 = 2938250;
        break;
    case 445:
        mx0 = 5391114;
        mx2 = 2929166;
        break;
    case 446:
        mx0 = 5385591;
        mx2 = 2920095;
        break;
    case 447:
        mx0 = 5380071;
        mx2 = 2911033;
        break;
    case 448:
        mx0 = 5374555;
        mx2 = 2901981;
        break;
    case 449:
        mx0 = 5369045;
        mx2 = 2892943;
        break;
    case 450:
        mx0 = 5363538;
        mx2 = 2883913;
        break;
    case 451:
        mx0 = 5358038;
        mx2 = 2874898;
        break;
    case 452:
        mx0 = 5352539;
        mx2 = 2865889;
        break;
    case 453:
        mx0 = 5347046;
        mx2 = 2856892;
        break;
    case 454:
        mx0 = 5341557;
        mx2 = 2847907;
        break;
    case 455:
        mx0 = 5336073;
        mx2 = 2838932;
        break;
    case 456:
        mx0 = 5330592;
        mx2 = 2829967;
        break;
    case 457:
        mx0 = 5325118;
        mx2 = 2821016;
        break;
    case 458:
        mx0 = 5319646;
        mx2 = 2812072;
        break;
    case 459:
        mx0 = 5314179;
        mx2 = 2803140;
        break;
    case 460:
        mx0 = 5308717;
        mx2 = 2794219;
        break;
    case 461:
        mx0 = 5303259;
        mx2 = 2785309;
        break;
    case 462:
        mx0 = 5297805;
        mx2 = 2776409;
        break;
    case 463:
        mx0 = 5292355;
        mx2 = 2767519;
        break;
    case 464:
        mx0 = 5286911;
        mx2 = 2758642;
        break;
    case 465:
        mx0 = 5281470;
        mx2 = 2749774;
        break;
    case 466:
        mx0 = 5276032;
        mx2 = 2740914;
        break;
    case 467:
        mx0 = 5270601;
        mx2 = 2732068;
        break;
    case 468:
        mx0 = 5265173;
        mx2 = 2723232;
        break;
    case 469:
        mx0 = 5259749;
        mx2 = 2714405;
        break;
    case 470:
        mx0 = 5254330;
        mx2 = 2705590;
        break;
    case 471:
        mx0 = 5248915;
        mx2 = 2696785;
        break;
    case 472:
        mx0 = 5243504;
        mx2 = 2687990;
        break;
    case 473:
        mx0 = 5238098;
        mx2 = 2679207;
        break;
    case 474:
        mx0 = 5232696;
        mx2 = 2670433;
        break;
    case 475:
        mx0 = 5227298;
        mx2 = 2661670;
        break;
    case 476:
        mx0 = 5221904;
        mx2 = 2652916;
        break;
    case 477:
        mx0 = 5216515;
        mx2 = 2644174;
        break;
    case 478:
        mx0 = 5211130;
        mx2 = 2635442;
        break;
    case 479:
        mx0 = 5205750;
        mx2 = 2626722;
        break;
    case 480:
        mx0 = 5200374;
        mx2 = 2618011;
        break;
    case 481:
        mx0 = 5195000;
        mx2 = 2609308;
        break;
    case 482:
        mx0 = 5189633;
        mx2 = 2600619;
        break;
    case 483:
        mx0 = 5184269;
        mx2 = 2591938;
        break;
    case 484:
        mx0 = 5178910;
        mx2 = 2583269;
        break;
    case 485:
        mx0 = 5173554;
        mx2 = 2574608;
        break;
    case 486:
        mx0 = 5168203;
        mx2 = 2565958;
        break;
    case 487:
        mx0 = 5162857;
        mx2 = 2557320;
        break;
    case 488:
        mx0 = 5157514;
        mx2 = 2548691;
        break;
    case 489:
        mx0 = 5152176;
        mx2 = 2540072;
        break;
    case 490:
        mx0 = 5146841;
        mx2 = 2531462;
        break;
    case 491:
        mx0 = 5141512;
        mx2 = 2522865;
        break;
    case 492:
        mx0 = 5136186;
        mx2 = 2514277;
        break;
    case 493:
        mx0 = 5130864;
        mx2 = 2505698;
        break;
    case 494:
        mx0 = 5125546;
        mx2 = 2497129;
        break;
    case 495:
        mx0 = 5120233;
        mx2 = 2488571;
        break;
    case 496:
        mx0 = 5114925;
        mx2 = 2480025;
        break;
    case 497:
        mx0 = 5109619;
        mx2 = 2471485;
        break;
    case 498:
        mx0 = 5104320;
        mx2 = 2462960;
        break;
    case 499:
        mx0 = 5099023;
        mx2 = 2454442;
        break;
    case 500:
        mx0 = 5093730;
        mx2 = 2445933;
        break;
    case 501:
        mx0 = 5088443;
        mx2 = 2437437;
        break;
    case 502:
        mx0 = 5083158;
        mx2 = 2428948;
        break;
    case 503:
        mx0 = 5077878;
        mx2 = 2420471;
        break;
    case 504:
        mx0 = 5072601;
        mx2 = 2412001;
        break;
    case 505:
        mx0 = 5067330;
        mx2 = 2403544;
        break;
    case 506:
        mx0 = 5062063;
        mx2 = 2395097;
        break;
    case 507:
        mx0 = 5056799;
        mx2 = 2386658;
        break;
    case 508:
        mx0 = 5051539;
        mx2 = 2378229;
        break;
    case 509:
        mx0 = 5046285;
        mx2 = 2369813;
        break;
    case 510:
        mx0 = 5041033;
        mx2 = 2361403;
        break;
    case 511:
        mx0 = 5035787;
        mx2 = 2353006;
        break;
    case 512:
        mx0 = 5030544;
        mx2 = 2344617;
        break;
    case 513:
        mx0 = 5025305;
        mx2 = 2336238;
        break;
    case 514:
        mx0 = 5020071;
        mx2 = 2327870;
        break;
    case 515:
        mx0 = 5014840;
        mx2 = 2319511;
        break;
    case 516:
        mx0 = 5009614;
        mx2 = 2311162;
        break;
    case 517:
        mx0 = 5004391;
        mx2 = 2302822;
        break;
    case 518:
        mx0 = 4999173;
        mx2 = 2294492;
        break;
    case 519:
        mx0 = 4993959;
        mx2 = 2286173;
        break;
    case 520:
        mx0 = 4988747;
        mx2 = 2277859;
        break;
    case 521:
        mx0 = 4983543;
        mx2 = 2269562;
        break;
    case 522:
        mx0 = 4978339;
        mx2 = 2261268;
        break;
    case 523:
        mx0 = 4973141;
        mx2 = 2252987;
        break;
    case 524:
        mx0 = 4967947;
        mx2 = 2244715;
        break;
    case 525:
        mx0 = 4962757;
        mx2 = 2236453;
        break;
    case 526:
        mx0 = 4957570;
        mx2 = 2228199;
        break;
    case 527:
        mx0 = 4952390;
        mx2 = 2219959;
        break;
    case 528:
        mx0 = 4947211;
        mx2 = 2211725;
        break;
    case 529:
        mx0 = 4942037;
        mx2 = 2203501;
        break;
    case 530:
        mx0 = 4936867;
        mx2 = 2195286;
        break;
    case 531:
        mx0 = 4931702;
        mx2 = 2187083;
        break;
    case 532:
        mx0 = 4926541;
        mx2 = 2178890;
        break;
    case 533:
        mx0 = 4921382;
        mx2 = 2170703;
        break;
    case 534:
        mx0 = 4916227;
        mx2 = 2162525;
        break;
    case 535:
        mx0 = 4911079;
        mx2 = 2154361;
        break;
    case 536:
        mx0 = 4905931;
        mx2 = 2146201;
        break;
    case 537:
        mx0 = 4900791;
        mx2 = 2138057;
        break;
    case 538:
        mx0 = 4895653;
        mx2 = 2129918;
        break;
    case 539:
        mx0 = 4890518;
        mx2 = 2121788;
        break;
    case 540:
        mx0 = 4885387;
        mx2 = 2113667;
        break;
    case 541:
        mx0 = 4880263;
        mx2 = 2105561;
        break;
    case 542:
        mx0 = 4875141;
        mx2 = 2097461;
        break;
    case 543:
        mx0 = 4870022;
        mx2 = 2089368;
        break;
    case 544:
        mx0 = 4864907;
        mx2 = 2081285;
        break;
    case 545:
        mx0 = 4859797;
        mx2 = 2073213;
        break;
    case 546:
        mx0 = 4854690;
        mx2 = 2065149;
        break;
    case 547:
        mx0 = 4849589;
        mx2 = 2057098;
        break;
    case 548:
        mx0 = 4844489;
        mx2 = 2049051;
        break;
    case 549:
        mx0 = 4839395;
        mx2 = 2041017;
        break;
    case 550:
        mx0 = 4834305;
        mx2 = 2032992;
        break;
    case 551:
        mx0 = 4829218;
        mx2 = 2024975;
        break;
    case 552:
        mx0 = 4824136;
        mx2 = 2016968;
        break;
    case 553:
        mx0 = 4819056;
        mx2 = 2008969;
        break;
    case 554:
        mx0 = 4813982;
        mx2 = 2000981;
        break;
    case 555:
        mx0 = 4808910;
        mx2 = 1993000;
        break;
    case 556:
        mx0 = 4803843;
        mx2 = 1985030;
        break;
    case 557:
        mx0 = 4798779;
        mx2 = 1977067;
        break;
    case 558:
        mx0 = 4793720;
        mx2 = 1969116;
        break;
    case 559:
        mx0 = 4788664;
        mx2 = 1961172;
        break;
    case 560:
        mx0 = 4783614;
        mx2 = 1953241;
        break;
    case 561:
        mx0 = 4778565;
        mx2 = 1945314;
        break;
    case 562:
        mx0 = 4773521;
        mx2 = 1937398;
        break;
    case 563:
        mx0 = 4768481;
        mx2 = 1929492;
        break;
    case 564:
        mx0 = 4763446;
        mx2 = 1921596;
        break;
    case 565:
        mx0 = 4758413;
        mx2 = 1913707;
        break;
    case 566:
        mx0 = 4753384;
        mx2 = 1905827;
        break;
    case 567:
        mx0 = 4748359;
        mx2 = 1897956;
        break;
    case 568:
        mx0 = 4743339;
        mx2 = 1890096;
        break;
    case 569:
        mx0 = 4738321;
        mx2 = 1882242;
        break;
    case 570:
        mx0 = 4733309;
        mx2 = 1874400;
        break;
    case 571:
        mx0 = 4728299;
        mx2 = 1866565;
        break;
    case 572:
        mx0 = 4723294;
        mx2 = 1858740;
        break;
    case 573:
        mx0 = 4718291;
        mx2 = 1850922;
        break;
    case 574:
        mx0 = 4713296;
        mx2 = 1843119;
        break;
    case 575:
        mx0 = 4708299;
        mx2 = 1835316;
        break;
    case 576:
        mx0 = 4703311;
        mx2 = 1827529;
        break;
    case 577:
        mx0 = 4698325;
        mx2 = 1819749;
        break;
    case 578:
        mx0 = 4693341;
        mx2 = 1811975;
        break;
    case 579:
        mx0 = 4688362;
        mx2 = 1804212;
        break;
    case 580:
        mx0 = 4683386;
        mx2 = 1796457;
        break;
    case 581:
        mx0 = 4678416;
        mx2 = 1788713;
        break;
    case 582:
        mx0 = 4673448;
        mx2 = 1780976;
        break;
    case 583:
        mx0 = 4668485;
        mx2 = 1773249;
        break;
    case 584:
        mx0 = 4663525;
        mx2 = 1765531;
        break;
    case 585:
        mx0 = 4658568;
        mx2 = 1757819;
        break;
    case 586:
        mx0 = 4653616;
        mx2 = 1750119;
        break;
    case 587:
        mx0 = 4648667;
        mx2 = 1742426;
        break;
    case 588:
        mx0 = 4643722;
        mx2 = 1734742;
        break;
    case 589:
        mx0 = 4638781;
        mx2 = 1727067;
        break;
    case 590:
        mx0 = 4633843;
        mx2 = 1719400;
        break;
    case 591:
        mx0 = 4628911;
        mx2 = 1711745;
        break;
    case 592:
        mx0 = 4623979;
        mx2 = 1704093;
        break;
    case 593:
        mx0 = 4619055;
        mx2 = 1696456;
        break;
    case 594:
        mx0 = 4614131;
        mx2 = 1688822;
        break;
    case 595:
        mx0 = 4609213;
        mx2 = 1681200;
        break;
    case 596:
        mx0 = 4604297;
        mx2 = 1673585;
        break;
    case 597:
        mx0 = 4599385;
        mx2 = 1665978;
        break;
    case 598:
        mx0 = 4594478;
        mx2 = 1658382;
        break;
    case 599:
        mx0 = 4589575;
        mx2 = 1650795;
        break;
    case 600:
        mx0 = 4584675;
        mx2 = 1643216;
        break;
    case 601:
        mx0 = 4579778;
        mx2 = 1635644;
        break;
    case 602:
        mx0 = 4574885;
        mx2 = 1628081;
        break;
    case 603:
        mx0 = 4569995;
        mx2 = 1620525;
        break;
    case 604:
        mx0 = 4565111;
        mx2 = 1612982;
        break;
    case 605:
        mx0 = 4560230;
        mx2 = 1605446;
        break;
    case 606:
        mx0 = 4555351;
        mx2 = 1597916;
        break;
    case 607:
        mx0 = 4550477;
        mx2 = 1590397;
        break;
    case 608:
        mx0 = 4545607;
        mx2 = 1582887;
        break;
    case 609:
        mx0 = 4540738;
        mx2 = 1575381;
        break;
    case 610:
        mx0 = 4535874;
        mx2 = 1567885;
        break;
    case 611:
        mx0 = 4531016;
        mx2 = 1560402;
        break;
    case 612:
        mx0 = 4526159;
        mx2 = 1552923;
        break;
    case 613:
        mx0 = 4521307;
        mx2 = 1545454;
        break;
    case 614:
        mx0 = 4516457;
        mx2 = 1537991;
        break;
    case 615:
        mx0 = 4511614;
        mx2 = 1530542;
        break;
    case 616:
        mx0 = 4506771;
        mx2 = 1523096;
        break;
    case 617:
        mx0 = 4501934;
        mx2 = 1515662;
        break;
    case 618:
        mx0 = 4497099;
        mx2 = 1508233;
        break;
    case 619:
        mx0 = 4492269;
        mx2 = 1500815;
        break;
    case 620:
        mx0 = 4487441;
        mx2 = 1493403;
        break;
    case 621:
        mx0 = 4482618;
        mx2 = 1486002;
        break;
    case 622:
        mx0 = 4477799;
        mx2 = 1478609;
        break;
    case 623:
        mx0 = 4472983;
        mx2 = 1471224;
        break;
    case 624:
        mx0 = 4468170;
        mx2 = 1463846;
        break;
    case 625:
        mx0 = 4463361;
        mx2 = 1456476;
        break;
    case 626:
        mx0 = 4458555;
        mx2 = 1449115;
        break;
    case 627:
        mx0 = 4453753;
        mx2 = 1441762;
        break;
    case 628:
        mx0 = 4448957;
        mx2 = 1434421;
        break;
    case 629:
        mx0 = 4444160;
        mx2 = 1427081;
        break;
    case 630:
        mx0 = 4439370;
        mx2 = 1419755;
        break;
    case 631:
        mx0 = 4434583;
        mx2 = 1412436;
        break;
    case 632:
        mx0 = 4429799;
        mx2 = 1405124;
        break;
    case 633:
        mx0 = 4425018;
        mx2 = 1397820;
        break;
    case 634:
        mx0 = 4420240;
        mx2 = 1390523;
        break;
    case 635:
        mx0 = 4415469;
        mx2 = 1383239;
        break;
    case 636:
        mx0 = 4410699;
        mx2 = 1375960;
        break;
    case 637:
        mx0 = 4405933;
        mx2 = 1368689;
        break;
    case 638:
        mx0 = 4401169;
        mx2 = 1361424;
        break;
    case 639:
        mx0 = 4396410;
        mx2 = 1354170;
        break;
    case 640:
        mx0 = 4391655;
        mx2 = 1346924;
        break;
    case 641:
        mx0 = 4386903;
        mx2 = 1339685;
        break;
    case 642:
        mx0 = 4382155;
        mx2 = 1332456;
        break;
    case 643:
        mx0 = 4377410;
        mx2 = 1325233;
        break;
    case 644:
        mx0 = 4372670;
        mx2 = 1318021;
        break;
    case 645:
        mx0 = 4367930;
        mx2 = 1310812;
        break;
    case 646:
        mx0 = 4363197;
        mx2 = 1303616;
        break;
    case 647:
        mx0 = 4358466;
        mx2 = 1296425;
        break;
    case 648:
        mx0 = 4353739;
        mx2 = 1289244;
        break;
    case 649:
        mx0 = 4349016;
        mx2 = 1282071;
        break;
    case 650:
        mx0 = 4344295;
        mx2 = 1274903;
        break;
    case 651:
        mx0 = 4339577;
        mx2 = 1267743;
        break;
    case 652:
        mx0 = 4334864;
        mx2 = 1260594;
        break;
    case 653:
        mx0 = 4330155;
        mx2 = 1253453;
        break;
    case 654:
        mx0 = 4325449;
        mx2 = 1246319;
        break;
    case 655:
        mx0 = 4320746;
        mx2 = 1239192;
        break;
    case 656:
        mx0 = 4316048;
        mx2 = 1232075;
        break;
    case 657:
        mx0 = 4311352;
        mx2 = 1224965;
        break;
    case 658:
        mx0 = 4306658;
        mx2 = 1217859;
        break;
    case 659:
        mx0 = 4301970;
        mx2 = 1210766;
        break;
    case 660:
        mx0 = 4297285;
        mx2 = 1203680;
        break;
    case 661:
        mx0 = 4292602;
        mx2 = 1196599;
        break;
    case 662:
        mx0 = 4287923;
        mx2 = 1189527;
        break;
    case 663:
        mx0 = 4283249;
        mx2 = 1182465;
        break;
    case 664:
        mx0 = 4278576;
        mx2 = 1175407;
        break;
    case 665:
        mx0 = 4273909;
        mx2 = 1168361;
        break;
    case 666:
        mx0 = 4269245;
        mx2 = 1161322;
        break;
    case 667:
        mx0 = 4264582;
        mx2 = 1154287;
        break;
    case 668:
        mx0 = 4259923;
        mx2 = 1147261;
        break;
    case 669:
        mx0 = 4255270;
        mx2 = 1140247;
        break;
    case 670:
        mx0 = 4250619;
        mx2 = 1133238;
        break;
    case 671:
        mx0 = 4245973;
        mx2 = 1126239;
        break;
    case 672:
        mx0 = 4241327;
        mx2 = 1119242;
        break;
    case 673:
        mx0 = 4236686;
        mx2 = 1112256;
        break;
    case 674:
        mx0 = 4232049;
        mx2 = 1105278;
        break;
    case 675:
        mx0 = 4227416;
        mx2 = 1098309;
        break;
    case 676:
        mx0 = 4222784;
        mx2 = 1091344;
        break;
    case 677:
        mx0 = 4218158;
        mx2 = 1084391;
        break;
    case 678:
        mx0 = 4213534;
        mx2 = 1077443;
        break;
    case 679:
        mx0 = 4208913;
        mx2 = 1070502;
        break;
    case 680:
        mx0 = 4204296;
        mx2 = 1063570;
        break;
    case 681:
        mx0 = 4199682;
        mx2 = 1056645;
        break;
    case 682:
        mx0 = 4195072;
        mx2 = 1049728;
        break;
    case 683:
        mx0 = 4190464;
        mx2 = 1042817;
        break;
    case 684:
        mx0 = 4185862;
        mx2 = 1035917;
        break;
    case 685:
        mx0 = 4181262;
        mx2 = 1029023;
        break;
    case 686:
        mx0 = 4176665;
        mx2 = 1022136;
        break;
    case 687:
        mx0 = 4172071;
        mx2 = 1015256;
        break;
    case 688:
        mx0 = 4167481;
        mx2 = 1008384;
        break;
    case 689:
        mx0 = 4162895;
        mx2 = 1001521;
        break;
    case 690:
        mx0 = 4158312;
        mx2 = 994665;
        break;
    case 691:
        mx0 = 4153731;
        mx2 = 987815;
        break;
    case 692:
        mx0 = 4149155;
        mx2 = 980974;
        break;
    case 693:
        mx0 = 4144581;
        mx2 = 974139;
        break;
    case 694:
        mx0 = 4140011;
        mx2 = 967312;
        break;
    case 695:
        mx0 = 4135446;
        mx2 = 960495;
        break;
    case 696:
        mx0 = 4130881;
        mx2 = 953681;
        break;
    case 697:
        mx0 = 4126322;
        mx2 = 946878;
        break;
    case 698:
        mx0 = 4121765;
        mx2 = 940081;
        break;
    case 699:
        mx0 = 4117211;
        mx2 = 933291;
        break;
    case 700:
        mx0 = 4112661;
        mx2 = 926509;
        break;
    case 701:
        mx0 = 4108113;
        mx2 = 919732;
        break;
    case 702:
        mx0 = 4103573;
        mx2 = 912970;
        break;
    case 703:
        mx0 = 4099031;
        mx2 = 906208;
        break;
    case 704:
        mx0 = 4094494;
        mx2 = 899455;
        break;
    case 705:
        mx0 = 4089960;
        mx2 = 892709;
        break;
    case 706:
        mx0 = 4085431;
        mx2 = 885973;
        break;
    case 707:
        mx0 = 4080904;
        mx2 = 879242;
        break;
    case 708:
        mx0 = 4076379;
        mx2 = 872517;
        break;
    case 709:
        mx0 = 4071859;
        mx2 = 865802;
        break;
    case 710:
        mx0 = 4067343;
        mx2 = 859095;
        break;
    case 711:
        mx0 = 4062827;
        mx2 = 852391;
        break;
    case 712:
        mx0 = 4058318;
        mx2 = 845699;
        break;
    case 713:
        mx0 = 4053809;
        mx2 = 839010;
        break;
    case 714:
        mx0 = 4049306;
        mx2 = 832332;
        break;
    case 715:
        mx0 = 4044807;
        mx2 = 825663;
        break;
    case 716:
        mx0 = 4040309;
        mx2 = 818997;
        break;
    case 717:
        mx0 = 4035814;
        mx2 = 812338;
        break;
    case 718:
        mx0 = 4031323;
        mx2 = 805688;
        break;
    case 719:
        mx0 = 4026835;
        mx2 = 799044;
        break;
    case 720:
        mx0 = 4022352;
        mx2 = 792410;
        break;
    case 721:
        mx0 = 4017870;
        mx2 = 785780;
        break;
    case 722:
        mx0 = 4013392;
        mx2 = 779159;
        break;
    case 723:
        mx0 = 4008917;
        mx2 = 772544;
        break;
    case 724:
        mx0 = 4004445;
        mx2 = 765936;
        break;
    case 725:
        mx0 = 3999977;
        mx2 = 759336;
        break;
    case 726:
        mx0 = 3995511;
        mx2 = 752742;
        break;
    case 727:
        mx0 = 3991049;
        mx2 = 746156;
        break;
    case 728:
        mx0 = 3986591;
        mx2 = 739578;
        break;
    case 729:
        mx0 = 3982135;
        mx2 = 733006;
        break;
    case 730:
        mx0 = 3977683;
        mx2 = 726441;
        break;
    case 731:
        mx0 = 3973233;
        mx2 = 719883;
        break;
    case 732:
        mx0 = 3968787;
        mx2 = 713332;
        break;
    case 733:
        mx0 = 3964344;
        mx2 = 706788;
        break;
    case 734:
        mx0 = 3959905;
        mx2 = 700252;
        break;
    case 735:
        mx0 = 3955470;
        mx2 = 693725;
        break;
    case 736:
        mx0 = 3951037;
        mx2 = 687203;
        break;
    case 737:
        mx0 = 3946606;
        mx2 = 680686;
        break;
    case 738:
        mx0 = 3942179;
        mx2 = 674177;
        break;
    case 739:
        mx0 = 3937755;
        mx2 = 667676;
        break;
    case 740:
        mx0 = 3933336;
        mx2 = 661183;
        break;
    case 741:
        mx0 = 3928919;
        mx2 = 654696;
        break;
    case 742:
        mx0 = 3924504;
        mx2 = 648215;
        break;
    case 743:
        mx0 = 3920093;
        mx2 = 641741;
        break;
    case 744:
        mx0 = 3915685;
        mx2 = 635275;
        break;
    case 745:
        mx0 = 3911280;
        mx2 = 628814;
        break;
    case 746:
        mx0 = 3906879;
        mx2 = 622363;
        break;
    case 747:
        mx0 = 3902481;
        mx2 = 615917;
        break;
    case 748:
        mx0 = 3898086;
        mx2 = 609479;
        break;
    case 749:
        mx0 = 3893694;
        mx2 = 603047;
        break;
    case 750:
        mx0 = 3889305;
        mx2 = 596622;
        break;
    case 751:
        mx0 = 3884919;
        mx2 = 590204;
        break;
    case 752:
        mx0 = 3880537;
        mx2 = 583794;
        break;
    case 753:
        mx0 = 3876157;
        mx2 = 577389;
        break;
    case 754:
        mx0 = 3871781;
        mx2 = 570992;
        break;
    case 755:
        mx0 = 3867408;
        mx2 = 564601;
        break;
    case 756:
        mx0 = 3863038;
        mx2 = 558218;
        break;
    case 757:
        mx0 = 3858670;
        mx2 = 551839;
        break;
    case 758:
        mx0 = 3854306;
        mx2 = 545469;
        break;
    case 759:
        mx0 = 3849945;
        mx2 = 539106;
        break;
    case 760:
        mx0 = 3845587;
        mx2 = 532749;
        break;
    case 761:
        mx0 = 3841233;
        mx2 = 526400;
        break;
    case 762:
        mx0 = 3836881;
        mx2 = 520056;
        break;
    case 763:
        mx0 = 3832534;
        mx2 = 513722;
        break;
    case 764:
        mx0 = 3828189;
        mx2 = 507393;
        break;
    case 765:
        mx0 = 3823846;
        mx2 = 501069;
        break;
    case 766:
        mx0 = 3819506;
        mx2 = 494752;
        break;
    case 767:
        mx0 = 3815170;
        mx2 = 488443;
        break;
    case 768:
        mx0 = 3810838;
        mx2 = 482142;
        break;
    case 769:
        mx0 = 3806509;
        mx2 = 475847;
        break;
    case 770:
        mx0 = 3802181;
        mx2 = 469556;
        break;
    case 771:
        mx0 = 3797856;
        mx2 = 463272;
        break;
    case 772:
        mx0 = 3793537;
        mx2 = 456999;
        break;
    case 773:
        mx0 = 3789219;
        mx2 = 450729;
        break;
    case 774:
        mx0 = 3784904;
        mx2 = 444466;
        break;
    case 775:
        mx0 = 3780592;
        mx2 = 438210;
        break;
    case 776:
        mx0 = 3776285;
        mx2 = 431963;
        break;
    case 777:
        mx0 = 3771979;
        mx2 = 425719;
        break;
    case 778:
        mx0 = 3767677;
        mx2 = 419484;
        break;
    case 779:
        mx0 = 3763377;
        mx2 = 413254;
        break;
    case 780:
        mx0 = 3759081;
        mx2 = 407032;
        break;
    case 781:
        mx0 = 3754787;
        mx2 = 400815;
        break;
    case 782:
        mx0 = 3750497;
        mx2 = 394606;
        break;
    case 783:
        mx0 = 3746210;
        mx2 = 388403;
        break;
    case 784:
        mx0 = 3741927;
        mx2 = 382208;
        break;
    case 785:
        mx0 = 3737645;
        mx2 = 376017;
        break;
    case 786:
        mx0 = 3733367;
        mx2 = 369834;
        break;
    case 787:
        mx0 = 3729091;
        mx2 = 363656;
        break;
    case 788:
        mx0 = 3724819;
        mx2 = 357486;
        break;
    case 789:
        mx0 = 3720551;
        mx2 = 351324;
        break;
    case 790:
        mx0 = 3716286;
        mx2 = 345169;
        break;
    case 791:
        mx0 = 3712023;
        mx2 = 339018;
        break;
    case 792:
        mx0 = 3707762;
        mx2 = 332873;
        break;
    case 793:
        mx0 = 3703505;
        mx2 = 326735;
        break;
    case 794:
        mx0 = 3699251;
        mx2 = 320604;
        break;
    case 795:
        mx0 = 3695000;
        mx2 = 314480;
        break;
    case 796:
        mx0 = 3690752;
        mx2 = 308362;
        break;
    case 797:
        mx0 = 3686506;
        mx2 = 302249;
        break;
    case 798:
        mx0 = 3682265;
        mx2 = 296145;
        break;
    case 799:
        mx0 = 3678025;
        mx2 = 290045;
        break;
    case 800:
        mx0 = 3673789;
        mx2 = 283953;
        break;
    case 801:
        mx0 = 3669555;
        mx2 = 277865;
        break;
    case 802:
        mx0 = 3665326;
        mx2 = 271787;
        break;
    case 803:
        mx0 = 3661098;
        mx2 = 265713;
        break;
    case 804:
        mx0 = 3656874;
        mx2 = 259647;
        break;
    case 805:
        mx0 = 3652654;
        mx2 = 253588;
        break;
    case 806:
        mx0 = 3648435;
        mx2 = 247533;
        break;
    case 807:
        mx0 = 3644219;
        mx2 = 241484;
        break;
    case 808:
        mx0 = 3640007;
        mx2 = 235444;
        break;
    case 809:
        mx0 = 3635797;
        mx2 = 229408;
        break;
    case 810:
        mx0 = 3631591;
        mx2 = 223380;
        break;
    case 811:
        mx0 = 3627387;
        mx2 = 217357;
        break;
    case 812:
        mx0 = 3623186;
        mx2 = 211341;
        break;
    case 813:
        mx0 = 3618989;
        mx2 = 205332;
        break;
    case 814:
        mx0 = 3614794;
        mx2 = 199328;
        break;
    case 815:
        mx0 = 3610602;
        mx2 = 193331;
        break;
    case 816:
        mx0 = 3606413;
        mx2 = 187340;
        break;
    case 817:
        mx0 = 3602227;
        mx2 = 181355;
        break;
    case 818:
        mx0 = 3598043;
        mx2 = 175376;
        break;
    case 819:
        mx0 = 3593864;
        mx2 = 169405;
        break;
    case 820:
        mx0 = 3589687;
        mx2 = 163440;
        break;
    case 821:
        mx0 = 3585513;
        mx2 = 157481;
        break;
    case 822:
        mx0 = 3581341;
        mx2 = 151526;
        break;
    case 823:
        mx0 = 3577171;
        mx2 = 145577;
        break;
    case 824:
        mx0 = 3573008;
        mx2 = 139640;
        break;
    case 825:
        mx0 = 3568843;
        mx2 = 133702;
        break;
    case 826:
        mx0 = 3564685;
        mx2 = 127776;
        break;
    case 827:
        mx0 = 3560527;
        mx2 = 121852;
        break;
    case 828:
        mx0 = 3556373;
        mx2 = 115936;
        break;
    case 829:
        mx0 = 3552222;
        mx2 = 110026;
        break;
    case 830:
        mx0 = 3548074;
        mx2 = 104123;
        break;
    case 831:
        mx0 = 3543928;
        mx2 = 98224;
        break;
    case 832:
        mx0 = 3539785;
        mx2 = 92332;
        break;
    case 833:
        mx0 = 3535646;
        mx2 = 86447;
        break;
    case 834:
        mx0 = 3531510;
        mx2 = 80569;
        break;
    case 835:
        mx0 = 3527375;
        mx2 = 74694;
        break;
    case 836:
        mx0 = 3523245;
        mx2 = 68829;
        break;
    case 837:
        mx0 = 3519117;
        mx2 = 62968;
        break;
    case 838:
        mx0 = 3514991;
        mx2 = 57112;
        break;
    case 839:
        mx0 = 3510867;
        mx2 = 51261;
        break;
    case 840:
        mx0 = 3506750;
        mx2 = 45422;
        break;
    case 841:
        mx0 = 3502632;
        mx2 = 39583;
        break;
    case 842:
        mx0 = 3498519;
        mx2 = 33754;
        break;
    case 843:
        mx0 = 3494407;
        mx2 = 27928;
        break;
    case 844:
        mx0 = 3490299;
        mx2 = 22110;
        break;
    case 845:
        mx0 = 3486194;
        mx2 = 16298;
        break;
    case 846:
        mx0 = 3482090;
        mx2 = 10489;
        break;
    case 847:
        mx0 = 3477992;
        mx2 = 4691;
        break;
    case 848:
        mx0 = 3473895;
        mx2 = 8386401;
        break;
    case 849:
        mx0 = 3469800;
        mx2 = 8374822;
        break;
    case 850:
        mx0 = 3465710;
        mx2 = 8363260;
        break;
    case 851:
        mx0 = 3461621;
        mx2 = 8351705;
        break;
    case 852:
        mx0 = 3457536;
        mx2 = 8340166;
        break;
    case 853:
        mx0 = 3453453;
        mx2 = 8328636;
        break;
    case 854:
        mx0 = 3449373;
        mx2 = 8317119;
        break;
    case 855:
        mx0 = 3445296;
        mx2 = 8305614;
        break;
    case 856:
        mx0 = 3441222;
        mx2 = 8294121;
        break;
    case 857:
        mx0 = 3437150;
        mx2 = 8282639;
        break;
    case 858:
        mx0 = 3433081;
        mx2 = 8271168;
        break;
    case 859:
        mx0 = 3429015;
        mx2 = 8259710;
        break;
    case 860:
        mx0 = 3424952;
        mx2 = 8248264;
        break;
    case 861:
        mx0 = 3420891;
        mx2 = 8236828;
        break;
    case 862:
        mx0 = 3416834;
        mx2 = 8225407;
        break;
    case 863:
        mx0 = 3412778;
        mx2 = 8213993;
        break;
    case 864:
        mx0 = 3408727;
        mx2 = 8202597;
        break;
    case 865:
        mx0 = 3404679;
        mx2 = 8191213;
        break;
    case 866:
        mx0 = 3400632;
        mx2 = 8179836;
        break;
    case 867:
        mx0 = 3396589;
        mx2 = 8168474;
        break;
    case 868:
        mx0 = 3392547;
        mx2 = 8157118;
        break;
    case 869:
        mx0 = 3388507;
        mx2 = 8145773;
        break;
    case 870:
        mx0 = 3384473;
        mx2 = 8134448;
        break;
    case 871:
        mx0 = 3380441;
        mx2 = 8123132;
        break;
    case 872:
        mx0 = 3376413;
        mx2 = 8111832;
        break;
    case 873:
        mx0 = 3372384;
        mx2 = 8100532;
        break;
    case 874:
        mx0 = 3368360;
        mx2 = 8089251;
        break;
    case 875:
        mx0 = 3364338;
        mx2 = 8077979;
        break;
    case 876:
        mx0 = 3360320;
        mx2 = 8066722;
        break;
    case 877:
        mx0 = 3356304;
        mx2 = 8055474;
        break;
    case 878:
        mx0 = 3352289;
        mx2 = 8044233;
        break;
    case 879:
        mx0 = 3348280;
        mx2 = 8033013;
        break;
    case 880:
        mx0 = 3344272;
        mx2 = 8021799;
        break;
    case 881:
        mx0 = 3340267;
        mx2 = 8010598;
        break;
    case 882:
        mx0 = 3336265;
        mx2 = 7999409;
        break;
    case 883:
        mx0 = 3332265;
        mx2 = 7988229;
        break;
    case 884:
        mx0 = 3328267;
        mx2 = 7977058;
        break;
    case 885:
        mx0 = 3324273;
        mx2 = 7965903;
        break;
    case 886:
        mx0 = 3320282;
        mx2 = 7954760;
        break;
    case 887:
        mx0 = 3316295;
        mx2 = 7943631;
        break;
    case 888:
        mx0 = 3312307;
        mx2 = 7932504;
        break;
    case 889:
        mx0 = 3308325;
        mx2 = 7921397;
        break;
    case 890:
        mx0 = 3304345;
        mx2 = 7910300;
        break;
    case 891:
        mx0 = 3300366;
        mx2 = 7899209;
        break;
    case 892:
        mx0 = 3296392;
        mx2 = 7888136;
        break;
    case 893:
        mx0 = 3292417;
        mx2 = 7877064;
        break;
    case 894:
        mx0 = 3288448;
        mx2 = 7866012;
        break;
    case 895:
        mx0 = 3284481;
        mx2 = 7854970;
        break;
    case 896:
        mx0 = 3280518;
        mx2 = 7843942;
        break;
    case 897:
        mx0 = 3276555;
        mx2 = 7832919;
        break;
    case 898:
        mx0 = 3272597;
        mx2 = 7821913;
        break;
    case 899:
        mx0 = 3268640;
        mx2 = 7810913;
        break;
    case 900:
        mx0 = 3264686;
        mx2 = 7799925;
        break;
    case 901:
        mx0 = 3260735;
        mx2 = 7788950;
        break;
    case 902:
        mx0 = 3256786;
        mx2 = 7777984;
        break;
    case 903:
        mx0 = 3252841;
        mx2 = 7767032;
        break;
    case 904:
        mx0 = 3248899;
        mx2 = 7756093;
        break;
    case 905:
        mx0 = 3244959;
        mx2 = 7745163;
        break;
    case 906:
        mx0 = 3241021;
        mx2 = 7734242;
        break;
    case 907:
        mx0 = 3237086;
        mx2 = 7723333;
        break;
    case 908:
        mx0 = 3233153;
        mx2 = 7712434;
        break;
    case 909:
        mx0 = 3229224;
        mx2 = 7701549;
        break;
    case 910:
        mx0 = 3225296;
        mx2 = 7690671;
        break;
    case 911:
        mx0 = 3221374;
        mx2 = 7679813;
        break;
    case 912:
        mx0 = 3217451;
        mx2 = 7668955;
        break;
    case 913:
        mx0 = 3213533;
        mx2 = 7658116;
        break;
    case 914:
        mx0 = 3209616;
        mx2 = 7647283;
        break;
    case 915:
        mx0 = 3205702;
        mx2 = 7636461;
        break;
    case 916:
        mx0 = 3201792;
        mx2 = 7625655;
        break;
    case 917:
        mx0 = 3197882;
        mx2 = 7614852;
        break;
    case 918:
        mx0 = 3193977;
        mx2 = 7604066;
        break;
    case 919:
        mx0 = 3190073;
        mx2 = 7593287;
        break;
    case 920:
        mx0 = 3186174;
        mx2 = 7582526;
        break;
    case 921:
        mx0 = 3182277;
        mx2 = 7571773;
        break;
    case 922:
        mx0 = 3178381;
        mx2 = 7561027;
        break;
    case 923:
        mx0 = 3174487;
        mx2 = 7550290;
        break;
    case 924:
        mx0 = 3170598;
        mx2 = 7539570;
        break;
    case 925:
        mx0 = 3166711;
        mx2 = 7528860;
        break;
    case 926:
        mx0 = 3162825;
        mx2 = 7518156;
        break;
    case 927:
        mx0 = 3158944;
        mx2 = 7507469;
        break;
    case 928:
        mx0 = 3155064;
        mx2 = 7496788;
        break;
    case 929:
        mx0 = 3151187;
        mx2 = 7486120;
        break;
    case 930:
        mx0 = 3147312;
        mx2 = 7475460;
        break;
    case 931:
        mx0 = 3143441;
        mx2 = 7464815;
        break;
    case 932:
        mx0 = 3139571;
        mx2 = 7454177;
        break;
    case 933:
        mx0 = 3135704;
        mx2 = 7443550;
        break;
    case 934:
        mx0 = 3131840;
        mx2 = 7432935;
        break;
    case 935:
        mx0 = 3127979;
        mx2 = 7422332;
        break;
    case 936:
        mx0 = 3124121;
        mx2 = 7411740;
        break;
    case 937:
        mx0 = 3120264;
        mx2 = 7401155;
        break;
    case 938:
        mx0 = 3116410;
        mx2 = 7390582;
        break;
    case 939:
        mx0 = 3112560;
        mx2 = 7380023;
        break;
    case 940:
        mx0 = 3108712;
        mx2 = 7369473;
        break;
    case 941:
        mx0 = 3104865;
        mx2 = 7358930;
        break;
    case 942:
        mx0 = 3101023;
        mx2 = 7348403;
        break;
    case 943:
        mx0 = 3097182;
        mx2 = 7337883;
        break;
    case 944:
        mx0 = 3093344;
        mx2 = 7327375;
        break;
    case 945:
        mx0 = 3089509;
        mx2 = 7316879;
        break;
    case 946:
        mx0 = 3085674;
        mx2 = 7306385;
        break;
    case 947:
        mx0 = 3081843;
        mx2 = 7295907;
        break;
    case 948:
        mx0 = 3078016;
        mx2 = 7285443;
        break;
    case 949:
        mx0 = 3074191;
        mx2 = 7274987;
        break;
    case 950:
        mx0 = 3070367;
        mx2 = 7264538;
        break;
    case 951:
        mx0 = 3066547;
        mx2 = 7254104;
        break;
    case 952:
        mx0 = 3062729;
        mx2 = 7243678;
        break;
    case 953:
        mx0 = 3058914;
        mx2 = 7233264;
        break;
    case 954:
        mx0 = 3055102;
        mx2 = 7222862;
        break;
    case 955:
        mx0 = 3051291;
        mx2 = 7212465;
        break;
    case 956:
        mx0 = 3047485;
        mx2 = 7202086;
        break;
    case 957:
        mx0 = 3043680;
        mx2 = 7191713;
        break;
    case 958:
        mx0 = 3039875;
        mx2 = 7181344;
        break;
    case 959:
        mx0 = 3036078;
        mx2 = 7171000;
        break;
    case 960:
        mx0 = 3032279;
        mx2 = 7160654;
        break;
    case 961:
        mx0 = 3028485;
        mx2 = 7150324;
        break;
    case 962:
        mx0 = 3024691;
        mx2 = 7139999;
        break;
    case 963:
        mx0 = 3020902;
        mx2 = 7129690;
        break;
    case 964:
        mx0 = 3017114;
        mx2 = 7119387;
        break;
    case 965:
        mx0 = 3013329;
        mx2 = 7109096;
        break;
    case 966:
        mx0 = 3009546;
        mx2 = 7098814;
        break;
    case 967:
        mx0 = 3005768;
        mx2 = 7088549;
        break;
    case 968:
        mx0 = 3001991;
        mx2 = 7078290;
        break;
    case 969:
        mx0 = 2998215;
        mx2 = 7068037;
        break;
    case 970:
        mx0 = 2994443;
        mx2 = 7057799;
        break;
    case 971:
        mx0 = 2990672;
        mx2 = 7047566;
        break;
    case 972:
        mx0 = 2986906;
        mx2 = 7037350;
        break;
    case 973:
        mx0 = 2983141;
        mx2 = 7027141;
        break;
    case 974:
        mx0 = 2979378;
        mx2 = 7016940;
        break;
    case 975:
        mx0 = 2975617;
        mx2 = 7006748;
        break;
    case 976:
        mx0 = 2971862;
        mx2 = 6996576;
        break;
    case 977:
        mx0 = 2968106;
        mx2 = 6986405;
        break;
    case 978:
        mx0 = 2964354;
        mx2 = 6976247;
        break;
    case 979:
        mx0 = 2960605;
        mx2 = 6966101;
        break;
    case 980:
        mx0 = 2956857;
        mx2 = 6955961;
        break;
    case 981:
        mx0 = 2953111;
        mx2 = 6945830;
        break;
    case 982:
        mx0 = 2949369;
        mx2 = 6935713;
        break;
    case 983:
        mx0 = 2945627;
        mx2 = 6925599;
        break;
    case 984:
        mx0 = 2941890;
        mx2 = 6915503;
        break;
    case 985:
        mx0 = 2938155;
        mx2 = 6905415;
        break;
    case 986:
        mx0 = 2934424;
        mx2 = 6895341;
        break;
    case 987:
        mx0 = 2930694;
        mx2 = 6885273;
        break;
    case 988:
        mx0 = 2926966;
        mx2 = 6875213;
        break;
    case 989:
        mx0 = 2923241;
        mx2 = 6865166;
        break;
    case 990:
        mx0 = 2919517;
        mx2 = 6855124;
        break;
    case 991:
        mx0 = 2915797;
        mx2 = 6845096;
        break;
    case 992:
        mx0 = 2912080;
        mx2 = 6835080;
        break;
    case 993:
        mx0 = 2908363;
        mx2 = 6825067;
        break;
    case 994:
        mx0 = 2904649;
        mx2 = 6815065;
        break;
    case 995:
        mx0 = 2900939;
        mx2 = 6805077;
        break;
    case 996:
        mx0 = 2897232;
        mx2 = 6795101;
        break;
    case 997:
        mx0 = 2893526;
        mx2 = 6785131;
        break;
    case 998:
        mx0 = 2889822;
        mx2 = 6775169;
        break;
    case 999:
        mx0 = 2886122;
        mx2 = 6765222;
        break;
    case 1000:
        mx0 = 2882424;
        mx2 = 6755283;
        break;
    case 1001:
        mx0 = 2878727;
        mx2 = 6745350;
        break;
    case 1002:
        mx0 = 2875033;
        mx2 = 6735428;
        break;
    case 1003:
        mx0 = 2871343;
        mx2 = 6725520;
        break;
    case 1004:
        mx0 = 2867655;
        mx2 = 6715621;
        break;
    case 1005:
        mx0 = 2863967;
        mx2 = 6705725;
        break;
    case 1006:
        mx0 = 2860283;
        mx2 = 6695843;
        break;
    case 1007:
        mx0 = 2856602;
        mx2 = 6685973;
        break;
    case 1008:
        mx0 = 2852923;
        mx2 = 6676111;
        break;
    case 1009:
        mx0 = 2849246;
        mx2 = 6666257;
        break;
    case 1010:
        mx0 = 2845571;
        mx2 = 6656412;
        break;
    case 1011:
        mx0 = 2841899;
        mx2 = 6646579;
        break;
    case 1012:
        mx0 = 2838231;
        mx2 = 6636759;
        break;
    case 1013:
        mx0 = 2834563;
        mx2 = 6626943;
        break;
    case 1014:
        mx0 = 2830898;
        mx2 = 6617137;
        break;
    case 1015:
        mx0 = 2827237;
        mx2 = 6607346;
        break;
    case 1016:
        mx0 = 2823577;
        mx2 = 6597560;
        break;
    case 1017:
        mx0 = 2819920;
        mx2 = 6587786;
        break;
    case 1018:
        mx0 = 2816264;
        mx2 = 6578018;
        break;
    case 1019:
        mx0 = 2812610;
        mx2 = 6568258;
        break;
    case 1020:
        mx0 = 2808960;
        mx2 = 6558512;
        break;
    case 1021:
        mx0 = 2805312;
        mx2 = 6548774;
        break;
    case 1022:
        mx0 = 2801669;
        mx2 = 6539053;
        break;
    case 1023:
        mx0 = 2798024;
        mx2 = 6529330;
        break;
    case 1024:
        mx0 = 2794383;
        mx2 = 6519621;
        break;
    case 1025:
        mx0 = 2790744;
        mx2 = 6509920;
        break;
    case 1026:
        mx0 = 2787109;
        mx2 = 6500233;
        break;
    case 1027:
        mx0 = 2783474;
        mx2 = 6490549;
        break;
    case 1028:
        mx0 = 2779842;
        mx2 = 6480876;
        break;
    case 1029:
        mx0 = 2776214;
        mx2 = 6471217;
        break;
    case 1030:
        mx0 = 2772586;
        mx2 = 6461562;
        break;
    case 1031:
        mx0 = 2768962;
        mx2 = 6451920;
        break;
    case 1032:
        mx0 = 2765341;
        mx2 = 6442289;
        break;
    case 1033:
        mx0 = 2761721;
        mx2 = 6432664;
        break;
    case 1034:
        mx0 = 2758104;
        mx2 = 6423049;
        break;
    case 1035:
        mx0 = 2754488;
        mx2 = 6413441;
        break;
    case 1036:
        mx0 = 2750875;
        mx2 = 6403844;
        break;
    case 1037:
        mx0 = 2747266;
        mx2 = 6394261;
        break;
    case 1038:
        mx0 = 2743658;
        mx2 = 6384683;
        break;
    case 1039:
        mx0 = 2740053;
        mx2 = 6375116;
        break;
    case 1040:
        mx0 = 2736449;
        mx2 = 6365555;
        break;
    case 1041:
        mx0 = 2732848;
        mx2 = 6356006;
        break;
    case 1042:
        mx0 = 2729250;
        mx2 = 6346467;
        break;
    case 1043:
        mx0 = 2725653;
        mx2 = 6336934;
        break;
    case 1044:
        mx0 = 2722059;
        mx2 = 6327412;
        break;
    case 1045:
        mx0 = 2718467;
        mx2 = 6317898;
        break;
    case 1046:
        mx0 = 2714879;
        mx2 = 6308398;
        break;
    case 1047:
        mx0 = 2711291;
        mx2 = 6298901;
        break;
    case 1048:
        mx0 = 2707707;
        mx2 = 6289418;
        break;
    case 1049:
        mx0 = 2704125;
        mx2 = 6279943;
        break;
    case 1050:
        mx0 = 2700544;
        mx2 = 6270474;
        break;
    case 1051:
        mx0 = 2696967;
        mx2 = 6261018;
        break;
    case 1052:
        mx0 = 2693391;
        mx2 = 6251569;
        break;
    case 1053:
        mx0 = 2689818;
        mx2 = 6242130;
        break;
    case 1054:
        mx0 = 2686248;
        mx2 = 6232702;
        break;
    case 1055:
        mx0 = 2682679;
        mx2 = 6223279;
        break;
    case 1056:
        mx0 = 2679113;
        mx2 = 6213868;
        break;
    case 1057:
        mx0 = 2675550;
        mx2 = 6204468;
        break;
    case 1058:
        mx0 = 2671986;
        mx2 = 6195068;
        break;
    case 1059:
        mx0 = 2668429;
        mx2 = 6185689;
        break;
    case 1060:
        mx0 = 2664871;
        mx2 = 6176311;
        break;
    case 1061:
        mx0 = 2661315;
        mx2 = 6166941;
        break;
    case 1062:
        mx0 = 2657763;
        mx2 = 6157585;
        break;
    case 1063:
        mx0 = 2654213;
        mx2 = 6148237;
        break;
    case 1064:
        mx0 = 2650665;
        mx2 = 6138897;
        break;
    case 1065:
        mx0 = 2647120;
        mx2 = 6129569;
        break;
    case 1066:
        mx0 = 2643577;
        mx2 = 6120248;
        break;
    case 1067:
        mx0 = 2640034;
        mx2 = 6110930;
        break;
    case 1068:
        mx0 = 2636497;
        mx2 = 6101632;
        break;
    case 1069:
        mx0 = 2632960;
        mx2 = 6092336;
        break;
    case 1070:
        mx0 = 2629426;
        mx2 = 6083051;
        break;
    case 1071:
        mx0 = 2625894;
        mx2 = 6073774;
        break;
    case 1072:
        mx0 = 2622363;
        mx2 = 6064503;
        break;
    case 1073:
        mx0 = 2618837;
        mx2 = 6055248;
        break;
    case 1074:
        mx0 = 2615312;
        mx2 = 6045998;
        break;
    case 1075:
        mx0 = 2611789;
        mx2 = 6036757;
        break;
    case 1076:
        mx0 = 2608267;
        mx2 = 6027522;
        break;
    case 1077:
        mx0 = 2604750;
        mx2 = 6018302;
        break;
    case 1078:
        mx0 = 2601232;
        mx2 = 6009083;
        break;
    case 1079:
        mx0 = 2597719;
        mx2 = 5999879;
        break;
    case 1080:
        mx0 = 2594207;
        mx2 = 5990682;
        break;
    case 1081:
        mx0 = 2590698;
        mx2 = 5981495;
        break;
    case 1082:
        mx0 = 2587191;
        mx2 = 5972316;
        break;
    case 1083:
        mx0 = 2583687;
        mx2 = 5963148;
        break;
    case 1084:
        mx0 = 2580183;
        mx2 = 5953983;
        break;
    case 1085:
        mx0 = 2576682;
        mx2 = 5944829;
        break;
    case 1086:
        mx0 = 2573184;
        mx2 = 5935686;
        break;
    case 1087:
        mx0 = 2569688;
        mx2 = 5926550;
        break;
    case 1088:
        mx0 = 2566195;
        mx2 = 5917426;
        break;
    case 1089:
        mx0 = 2562703;
        mx2 = 5908307;
        break;
    case 1090:
        mx0 = 2559214;
        mx2 = 5899198;
        break;
    case 1091:
        mx0 = 2555727;
        mx2 = 5890098;
        break;
    case 1092:
        mx0 = 2552241;
        mx2 = 5881003;
        break;
    case 1093:
        mx0 = 2548759;
        mx2 = 5871922;
        break;
    case 1094:
        mx0 = 2545279;
        mx2 = 5862849;
        break;
    case 1095:
        mx0 = 2541801;
        mx2 = 5853784;
        break;
    case 1096:
        mx0 = 2538325;
        mx2 = 5844727;
        break;
    case 1097:
        mx0 = 2534850;
        mx2 = 5835675;
        break;
    case 1098:
        mx0 = 2531379;
        mx2 = 5826637;
        break;
    case 1099:
        mx0 = 2527910;
        mx2 = 5817607;
        break;
    case 1100:
        mx0 = 2524442;
        mx2 = 5808582;
        break;
    case 1101:
        mx0 = 2520977;
        mx2 = 5799568;
        break;
    case 1102:
        mx0 = 2517514;
        mx2 = 5790562;
        break;
    case 1103:
        mx0 = 2514054;
        mx2 = 5781566;
        break;
    case 1104:
        mx0 = 2510595;
        mx2 = 5772577;
        break;
    case 1105:
        mx0 = 2507139;
        mx2 = 5763597;
        break;
    case 1106:
        mx0 = 2503685;
        mx2 = 5754626;
        break;
    case 1107:
        mx0 = 2500233;
        mx2 = 5745663;
        break;
    case 1108:
        mx0 = 2496784;
        mx2 = 5736710;
        break;
    case 1109:
        mx0 = 2493337;
        mx2 = 5727766;
        break;
    case 1110:
        mx0 = 2489891;
        mx2 = 5718827;
        break;
    case 1111:
        mx0 = 2486448;
        mx2 = 5709898;
        break;
    case 1112:
        mx0 = 2483007;
        mx2 = 5700978;
        break;
    case 1113:
        mx0 = 2479567;
        mx2 = 5692063;
        break;
    case 1114:
        mx0 = 2476131;
        mx2 = 5683161;
        break;
    case 1115:
        mx0 = 2472697;
        mx2 = 5674267;
        break;
    case 1116:
        mx0 = 2469265;
        mx2 = 5665381;
        break;
    case 1117:
        mx0 = 2465835;
        mx2 = 5656503;
        break;
    case 1118:
        mx0 = 2462407;
        mx2 = 5647633;
        break;
    case 1119:
        mx0 = 2458981;
        mx2 = 5638771;
        break;
    case 1120:
        mx0 = 2455558;
        mx2 = 5629920;
        break;
    case 1121:
        mx0 = 2452136;
        mx2 = 5621074;
        break;
    case 1122:
        mx0 = 2448717;
        mx2 = 5612239;
        break;
    case 1123:
        mx0 = 2445299;
        mx2 = 5603408;
        break;
    case 1124:
        mx0 = 2441886;
        mx2 = 5594594;
        break;
    case 1125:
        mx0 = 2438473;
        mx2 = 5585782;
        break;
    case 1126:
        mx0 = 2435062;
        mx2 = 5576979;
        break;
    case 1127:
        mx0 = 2431653;
        mx2 = 5568183;
        break;
    case 1128:
        mx0 = 2428247;
        mx2 = 5559398;
        break;
    case 1129:
        mx0 = 2424842;
        mx2 = 5550618;
        break;
    case 1130:
        mx0 = 2421441;
        mx2 = 5541851;
        break;
    case 1131:
        mx0 = 2418040;
        mx2 = 5533087;
        break;
    case 1132:
        mx0 = 2414642;
        mx2 = 5524333;
        break;
    case 1133:
        mx0 = 2411248;
        mx2 = 5515593;
        break;
    case 1134:
        mx0 = 2407853;
        mx2 = 5506852;
        break;
    case 1135:
        mx0 = 2404463;
        mx2 = 5498128;
        break;
    case 1136:
        mx0 = 2401072;
        mx2 = 5489403;
        break;
    case 1137:
        mx0 = 2397686;
        mx2 = 5480694;
        break;
    case 1138:
        mx0 = 2394301;
        mx2 = 5471990;
        break;
    case 1139:
        mx0 = 2390918;
        mx2 = 5463295;
        break;
    case 1140:
        mx0 = 2387537;
        mx2 = 5454607;
        break;
    case 1141:
        mx0 = 2384158;
        mx2 = 5445927;
        break;
    case 1142:
        mx0 = 2380782;
        mx2 = 5437257;
        break;
    case 1143:
        mx0 = 2377407;
        mx2 = 5428593;
        break;
    case 1144:
        mx0 = 2374035;
        mx2 = 5419939;
        break;
    case 1145:
        mx0 = 2370665;
        mx2 = 5411292;
        break;
    case 1146:
        mx0 = 2367297;
        mx2 = 5402654;
        break;
    case 1147:
        mx0 = 2363931;
        mx2 = 5394024;
        break;
    case 1148:
        mx0 = 2360568;
        mx2 = 5385404;
        break;
    case 1149:
        mx0 = 2357206;
        mx2 = 5376789;
        break;
    case 1150:
        mx0 = 2353846;
        mx2 = 5368182;
        break;
    case 1151:
        mx0 = 2350488;
        mx2 = 5359583;
        break;
    case 1152:
        mx0 = 2347133;
        mx2 = 5350994;
        break;
    case 1153:
        mx0 = 2343779;
        mx2 = 5342410;
        break;
    case 1154:
        mx0 = 2340429;
        mx2 = 5333840;
        break;
    case 1155:
        mx0 = 2337079;
        mx2 = 5325272;
        break;
    case 1156:
        mx0 = 2333733;
        mx2 = 5316717;
        break;
    case 1157:
        mx0 = 2330387;
        mx2 = 5308164;
        break;
    case 1158:
        mx0 = 2327043;
        mx2 = 5299620;
        break;
    case 1159:
        mx0 = 2323704;
        mx2 = 5291091;
        break;
    case 1160:
        mx0 = 2320365;
        mx2 = 5282564;
        break;
    case 1161:
        mx0 = 2317027;
        mx2 = 5274043;
        break;
    case 1162:
        mx0 = 2313694;
        mx2 = 5265537;
        break;
    case 1163:
        mx0 = 2310361;
        mx2 = 5257034;
        break;
    case 1164:
        mx0 = 2307031;
        mx2 = 5248541;
        break;
    case 1165:
        mx0 = 2303703;
        mx2 = 5240055;
        break;
    case 1166:
        mx0 = 2300376;
        mx2 = 5231575;
        break;
    case 1167:
        mx0 = 2297051;
        mx2 = 5223103;
        break;
    case 1168:
        mx0 = 2293729;
        mx2 = 5214641;
        break;
    case 1169:
        mx0 = 2290409;
        mx2 = 5206187;
        break;
    case 1170:
        mx0 = 2287091;
        mx2 = 5197740;
        break;
    case 1171:
        mx0 = 2283776;
        mx2 = 5189304;
        break;
    case 1172:
        mx0 = 2280462;
        mx2 = 5180873;
        break;
    case 1173:
        mx0 = 2277150;
        mx2 = 5172449;
        break;
    case 1174:
        mx0 = 2273839;
        mx2 = 5164031;
        break;
    case 1175:
        mx0 = 2270533;
        mx2 = 5155628;
        break;
    case 1176:
        mx0 = 2267226;
        mx2 = 5147225;
        break;
    case 1177:
        mx0 = 2263923;
        mx2 = 5138835;
        break;
    case 1178:
        mx0 = 2260622;
        mx2 = 5130453;
        break;
    case 1179:
        mx0 = 2257321;
        mx2 = 5122073;
        break;
    case 1180:
        mx0 = 2254024;
        mx2 = 5113706;
        break;
    case 1181:
        mx0 = 2250728;
        mx2 = 5105344;
        break;
    case 1182:
        mx0 = 2247435;
        mx2 = 5096992;
        break;
    case 1183:
        mx0 = 2244144;
        mx2 = 5088648;
        break;
    case 1184:
        mx0 = 2240855;
        mx2 = 5080311;
        break;
    case 1185:
        mx0 = 2237567;
        mx2 = 5071980;
        break;
    case 1186:
        mx0 = 2234282;
        mx2 = 5063659;
        break;
    case 1187:
        mx0 = 2230999;
        mx2 = 5055345;
        break;
    case 1188:
        mx0 = 2227718;
        mx2 = 5047039;
        break;
    case 1189:
        mx0 = 2224439;
        mx2 = 5038741;
        break;
    case 1190:
        mx0 = 2221162;
        mx2 = 5030450;
        break;
    case 1191:
        mx0 = 2217886;
        mx2 = 5022165;
        break;
    case 1192:
        mx0 = 2214614;
        mx2 = 5013892;
        break;
    case 1193:
        mx0 = 2211342;
        mx2 = 5005621;
        break;
    case 1194:
        mx0 = 2208073;
        mx2 = 4997361;
        break;
    case 1195:
        mx0 = 2204807;
        mx2 = 4989111;
        break;
    case 1196:
        mx0 = 2201541;
        mx2 = 4980864;
        break;
    case 1197:
        mx0 = 2198279;
        mx2 = 4972629;
        break;
    case 1198:
        mx0 = 2195016;
        mx2 = 4964394;
        break;
    case 1199:
        mx0 = 2191758;
        mx2 = 4956174;
        break;
    case 1200:
        mx0 = 2188501;
        mx2 = 4947959;
        break;
    case 1201:
        mx0 = 2185246;
        mx2 = 4939752;
        break;
    case 1202:
        mx0 = 2181993;
        mx2 = 4931553;
        break;
    case 1203:
        mx0 = 2178742;
        mx2 = 4923361;
        break;
    case 1204:
        mx0 = 2175493;
        mx2 = 4915176;
        break;
    case 1205:
        mx0 = 2172246;
        mx2 = 4906999;
        break;
    case 1206:
        mx0 = 2169001;
        mx2 = 4898830;
        break;
    case 1207:
        mx0 = 2165758;
        mx2 = 4890668;
        break;
    case 1208:
        mx0 = 2162518;
        mx2 = 4882516;
        break;
    case 1209:
        mx0 = 2159278;
        mx2 = 4874367;
        break;
    case 1210:
        mx0 = 2156041;
        mx2 = 4866228;
        break;
    case 1211:
        mx0 = 2152806;
        mx2 = 4858096;
        break;
    case 1212:
        mx0 = 2149573;
        mx2 = 4849972;
        break;
    case 1213:
        mx0 = 2146342;
        mx2 = 4841855;
        break;
    case 1214:
        mx0 = 2143113;
        mx2 = 4833746;
        break;
    case 1215:
        mx0 = 2139886;
        mx2 = 4825645;
        break;
    case 1216:
        mx0 = 2136659;
        mx2 = 4817546;
        break;
    case 1217:
        mx0 = 2133438;
        mx2 = 4809464;
        break;
    case 1218:
        mx0 = 2130216;
        mx2 = 4801382;
        break;
    case 1219:
        mx0 = 2126997;
        mx2 = 4793311;
        break;
    case 1220:
        mx0 = 2123779;
        mx2 = 4785244;
        break;
    case 1221:
        mx0 = 2120565;
        mx2 = 4777190;
        break;
    case 1222:
        mx0 = 2117351;
        mx2 = 4769138;
        break;
    case 1223:
        mx0 = 2114139;
        mx2 = 4761094;
        break;
    case 1224:
        mx0 = 2110930;
        mx2 = 4753060;
        break;
    case 1225:
        mx0 = 2107722;
        mx2 = 4745030;
        break;
    case 1226:
        mx0 = 2104517;
        mx2 = 4737011;
        break;
    case 1227:
        mx0 = 2101313;
        mx2 = 4728997;
        break;
    case 1228:
        mx0 = 2098112;
        mx2 = 4720992;
        break;
    case 1229:
        mx0 = 2094912;
        mx2 = 4712993;
        break;
    case 1230:
        mx0 = 2091714;
        mx2 = 4705001;
        break;
    case 1231:
        mx0 = 2088519;
        mx2 = 4697018;
        break;
    case 1232:
        mx0 = 2085326;
        mx2 = 4689044;
        break;
    case 1233:
        mx0 = 2082134;
        mx2 = 4681074;
        break;
    case 1234:
        mx0 = 2078944;
        mx2 = 4673112;
        break;
    case 1235:
        mx0 = 2075757;
        mx2 = 4665159;
        break;
    case 1236:
        mx0 = 2072570;
        mx2 = 4657209;
        break;
    case 1237:
        mx0 = 2069386;
        mx2 = 4649269;
        break;
    case 1238:
        mx0 = 2066203;
        mx2 = 4641334;
        break;
    case 1239:
        mx0 = 2063023;
        mx2 = 4633408;
        break;
    case 1240:
        mx0 = 2059846;
        mx2 = 4625493;
        break;
    case 1241:
        mx0 = 2056670;
        mx2 = 4617582;
        break;
    case 1242:
        mx0 = 2053495;
        mx2 = 4609677;
        break;
    case 1243:
        mx0 = 2050323;
        mx2 = 4601781;
        break;
    case 1244:
        mx0 = 2047152;
        mx2 = 4593890;
        break;
    case 1245:
        mx0 = 2043983;
        mx2 = 4586006;
        break;
    case 1246:
        mx0 = 2040816;
        mx2 = 4578130;
        break;
    case 1247:
        mx0 = 2037651;
        mx2 = 4570262;
        break;
    case 1248:
        mx0 = 2034489;
        mx2 = 4562403;
        break;
    case 1249:
        mx0 = 2031328;
        mx2 = 4554549;
        break;
    case 1250:
        mx0 = 2028169;
        mx2 = 4546702;
        break;
    case 1251:
        mx0 = 2025013;
        mx2 = 4538865;
        break;
    case 1252:
        mx0 = 2021857;
        mx2 = 4531030;
        break;
    case 1253:
        mx0 = 2018703;
        mx2 = 4523203;
        break;
    case 1254:
        mx0 = 2015552;
        mx2 = 4515386;
        break;
    case 1255:
        mx0 = 2012402;
        mx2 = 4507573;
        break;
    case 1256:
        mx0 = 2009255;
        mx2 = 4499770;
        break;
    case 1257:
        mx0 = 2006110;
        mx2 = 4491975;
        break;
    case 1258:
        mx0 = 2002966;
        mx2 = 4484185;
        break;
    case 1259:
        mx0 = 1999824;
        mx2 = 4476401;
        break;
    case 1260:
        mx0 = 1996683;
        mx2 = 4468623;
        break;
    case 1261:
        mx0 = 1993545;
        mx2 = 4460854;
        break;
    case 1262:
        mx0 = 1990409;
        mx2 = 4453093;
        break;
    case 1263:
        mx0 = 1987275;
        mx2 = 4445339;
        break;
    case 1264:
        mx0 = 1984144;
        mx2 = 4437594;
        break;
    case 1265:
        mx0 = 1981013;
        mx2 = 4429852;
        break;
    case 1266:
        mx0 = 1977885;
        mx2 = 4422120;
        break;
    case 1267:
        mx0 = 1974758;
        mx2 = 4414393;
        break;
    case 1268:
        mx0 = 1971632;
        mx2 = 4406670;
        break;
    case 1269:
        mx0 = 1968510;
        mx2 = 4398960;
        break;
    case 1270:
        mx0 = 1965389;
        mx2 = 4391254;
        break;
    case 1271:
        mx0 = 1962270;
        mx2 = 4383556;
        break;
    case 1272:
        mx0 = 1959152;
        mx2 = 4375862;
        break;
    case 1273:
        mx0 = 1956038;
        mx2 = 4368181;
        break;
    case 1274:
        mx0 = 1952923;
        mx2 = 4360499;
        break;
    case 1275:
        mx0 = 1949813;
        mx2 = 4352832;
        break;
    case 1276:
        mx0 = 1946702;
        mx2 = 4345165;
        break;
    case 1277:
        mx0 = 1943594;
        mx2 = 4337508;
        break;
    case 1278:
        mx0 = 1940488;
        mx2 = 4329858;
        break;
    case 1279:
        mx0 = 1937384;
        mx2 = 4322215;
        break;
    case 1280:
        mx0 = 1934282;
        mx2 = 4314579;
        break;
    case 1281:
        mx0 = 1931181;
        mx2 = 4306948;
        break;
    case 1282:
        mx0 = 1928082;
        mx2 = 4299325;
        break;
    case 1283:
        mx0 = 1924986;
        mx2 = 4291710;
        break;
    case 1284:
        mx0 = 1921890;
        mx2 = 4284099;
        break;
    case 1285:
        mx0 = 1918798;
        mx2 = 4276499;
        break;
    case 1286:
        mx0 = 1915707;
        mx2 = 4268904;
        break;
    case 1287:
        mx0 = 1912617;
        mx2 = 4261314;
        break;
    case 1288:
        mx0 = 1909530;
        mx2 = 4253733;
        break;
    case 1289:
        mx0 = 1906445;
        mx2 = 4246160;
        break;
    case 1290:
        mx0 = 1903361;
        mx2 = 4238591;
        break;
    case 1291:
        mx0 = 1900279;
        mx2 = 4231030;
        break;
    case 1292:
        mx0 = 1897199;
        mx2 = 4223476;
        break;
    case 1293:
        mx0 = 1894120;
        mx2 = 4215926;
        break;
    case 1294:
        mx0 = 1891045;
        mx2 = 4208389;
        break;
    case 1295:
        mx0 = 1887969;
        mx2 = 4200851;
        break;
    case 1296:
        mx0 = 1884897;
        mx2 = 4193325;
        break;
    case 1297:
        mx0 = 1881826;
        mx2 = 4185804;
        break;
    case 1298:
        mx0 = 1878758;
        mx2 = 4178293;
        break;
    case 1299:
        mx0 = 1875690;
        mx2 = 4170784;
        break;
    case 1300:
        mx0 = 1872625;
        mx2 = 4163284;
        break;
    case 1301:
        mx0 = 1869561;
        mx2 = 4155789;
        break;
    case 1302:
        mx0 = 1866501;
        mx2 = 4148306;
        break;
    case 1303:
        mx0 = 1863440;
        mx2 = 4140823;
        break;
    case 1304:
        mx0 = 1860382;
        mx2 = 4133350;
        break;
    case 1305:
        mx0 = 1857326;
        mx2 = 4125884;
        break;
    case 1306:
        mx0 = 1854271;
        mx2 = 4118422;
        break;
    case 1307:
        mx0 = 1851218;
        mx2 = 4110967;
        break;
    case 1308:
        mx0 = 1848168;
        mx2 = 4103522;
        break;
    case 1309:
        mx0 = 1845120;
        mx2 = 4096084;
        break;
    case 1310:
        mx0 = 1842072;
        mx2 = 4088648;
        break;
    case 1311:
        mx0 = 1839027;
        mx2 = 4081222;
        break;
    case 1312:
        mx0 = 1835984;
        mx2 = 4073803;
        break;
    case 1313:
        mx0 = 1832942;
        mx2 = 4066389;
        break;
    case 1314:
        mx0 = 1829902;
        mx2 = 4058981;
        break;
    case 1315:
        mx0 = 1826864;
        mx2 = 4051581;
        break;
    case 1316:
        mx0 = 1823827;
        mx2 = 4044185;
        break;
    case 1317:
        mx0 = 1820792;
        mx2 = 4036797;
        break;
    case 1318:
        mx0 = 1817760;
        mx2 = 4029417;
        break;
    case 1319:
        mx0 = 1814729;
        mx2 = 4022043;
        break;
    case 1320:
        mx0 = 1811701;
        mx2 = 4014678;
        break;
    case 1321:
        mx0 = 1808673;
        mx2 = 4007315;
        break;
    case 1322:
        mx0 = 1805648;
        mx2 = 3999962;
        break;
    case 1323:
        mx0 = 1802624;
        mx2 = 3992613;
        break;
    case 1324:
        mx0 = 1799602;
        mx2 = 3985271;
        break;
    case 1325:
        mx0 = 1796582;
        mx2 = 3977937;
        break;
    case 1326:
        mx0 = 1793563;
        mx2 = 3970607;
        break;
    case 1327:
        mx0 = 1790547;
        mx2 = 3963286;
        break;
    case 1328:
        mx0 = 1787533;
        mx2 = 3955972;
        break;
    case 1329:
        mx0 = 1784520;
        mx2 = 3948663;
        break;
    case 1330:
        mx0 = 1781509;
        mx2 = 3941361;
        break;
    case 1331:
        mx0 = 1778499;
        mx2 = 3934064;
        break;
    case 1332:
        mx0 = 1775491;
        mx2 = 3926774;
        break;
    case 1333:
        mx0 = 1772487;
        mx2 = 3919495;
        break;
    case 1334:
        mx0 = 1769481;
        mx2 = 3912214;
        break;
    case 1335:
        mx0 = 1766480;
        mx2 = 3904947;
        break;
    case 1336:
        mx0 = 1763479;
        mx2 = 3897682;
        break;
    case 1337:
        mx0 = 1760481;
        mx2 = 3890427;
        break;
    case 1338:
        mx0 = 1757483;
        mx2 = 3883173;
        break;
    case 1339:
        mx0 = 1754488;
        mx2 = 3875929;
        break;
    case 1340:
        mx0 = 1751495;
        mx2 = 3868692;
        break;
    case 1341:
        mx0 = 1748503;
        mx2 = 3861460;
        break;
    case 1342:
        mx0 = 1745513;
        mx2 = 3854235;
        break;
    case 1343:
        mx0 = 1742526;
        mx2 = 3847019;
        break;
    case 1344:
        mx0 = 1739538;
        mx2 = 3839802;
        break;
    case 1345:
        mx0 = 1736554;
        mx2 = 3832598;
        break;
    case 1346:
        mx0 = 1733573;
        mx2 = 3825403;
        break;
    case 1347:
        mx0 = 1730591;
        mx2 = 3818207;
        break;
    case 1348:
        mx0 = 1727611;
        mx2 = 3811019;
        break;
    case 1349:
        mx0 = 1724634;
        mx2 = 3803840;
        break;
    case 1350:
        mx0 = 1721658;
        mx2 = 3796665;
        break;
    case 1351:
        mx0 = 1718683;
        mx2 = 3789495;
        break;
    case 1352:
        mx0 = 1715712;
        mx2 = 3782337;
        break;
    case 1353:
        mx0 = 1712741;
        mx2 = 3775180;
        break;
    case 1354:
        mx0 = 1709771;
        mx2 = 3768029;
        break;
    case 1355:
        mx0 = 1706806;
        mx2 = 3760891;
        break;
    case 1356:
        mx0 = 1703840;
        mx2 = 3753753;
        break;
    case 1357:
        mx0 = 1700877;
        mx2 = 3746624;
        break;
    case 1358:
        mx0 = 1697915;
        mx2 = 3739500;
        break;
    case 1359:
        mx0 = 1694954;
        mx2 = 3732381;
        break;
    case 1360:
        mx0 = 1691995;
        mx2 = 3725268;
        break;
    case 1361:
        mx0 = 1689040;
        mx2 = 3718167;
        break;
    case 1362:
        mx0 = 1686085;
        mx2 = 3711068;
        break;
    case 1363:
        mx0 = 1683131;
        mx2 = 3703974;
        break;
    case 1364:
        mx0 = 1680179;
        mx2 = 3696886;
        break;
    case 1365:
        mx0 = 1677231;
        mx2 = 3689810;
        break;
    case 1366:
        mx0 = 1674281;
        mx2 = 3682731;
        break;
    case 1367:
        mx0 = 1671336;
        mx2 = 3675667;
        break;
    case 1368:
        mx0 = 1668391;
        mx2 = 3668604;
        break;
    case 1369:
        mx0 = 1665448;
        mx2 = 3661549;
        break;
    case 1370:
        mx0 = 1662507;
        mx2 = 3654500;
        break;
    case 1371:
        mx0 = 1659568;
        mx2 = 3647458;
        break;
    case 1372:
        mx0 = 1656631;
        mx2 = 3640423;
        break;
    case 1373:
        mx0 = 1653695;
        mx2 = 3633392;
        break;
    case 1374:
        mx0 = 1650761;
        mx2 = 3626369;
        break;
    case 1375:
        mx0 = 1647829;
        mx2 = 3619352;
        break;
    case 1376:
        mx0 = 1644897;
        mx2 = 3612337;
        break;
    case 1377:
        mx0 = 1641968;
        mx2 = 3605331;
        break;
    case 1378:
        mx0 = 1639040;
        mx2 = 3598330;
        break;
    case 1379:
        mx0 = 1636115;
        mx2 = 3591338;
        break;
    case 1380:
        mx0 = 1633191;
        mx2 = 3584350;
        break;
    case 1381:
        mx0 = 1630270;
        mx2 = 3577372;
        break;
    case 1382:
        mx0 = 1627349;
        mx2 = 3570396;
        break;
    case 1383:
        mx0 = 1624430;
        mx2 = 3563426;
        break;
    case 1384:
        mx0 = 1621512;
        mx2 = 3556461;
        break;
    case 1385:
        mx0 = 1618597;
        mx2 = 3549505;
        break;
    case 1386:
        mx0 = 1615683;
        mx2 = 3542554;
        break;
    case 1387:
        mx0 = 1612771;
        mx2 = 3535609;
        break;
    case 1388:
        mx0 = 1609861;
        mx2 = 3528671;
        break;
    case 1389:
        mx0 = 1606952;
        mx2 = 3521738;
        break;
    case 1390:
        mx0 = 1604046;
        mx2 = 3514813;
        break;
    case 1391:
        mx0 = 1601139;
        mx2 = 3507888;
        break;
    case 1392:
        mx0 = 1598238;
        mx2 = 3500980;
        break;
    case 1393:
        mx0 = 1595335;
        mx2 = 3494069;
        break;
    case 1394:
        mx0 = 1592434;
        mx2 = 3487164;
        break;
    case 1395:
        mx0 = 1589537;
        mx2 = 3480272;
        break;
    case 1396:
        mx0 = 1586639;
        mx2 = 3473378;
        break;
    case 1397:
        mx0 = 1583744;
        mx2 = 3466494;
        break;
    case 1398:
        mx0 = 1580850;
        mx2 = 3459614;
        break;
    case 1399:
        mx0 = 1577959;
        mx2 = 3452744;
        break;
    case 1400:
        mx0 = 1575069;
        mx2 = 3445877;
        break;
    case 1401:
        mx0 = 1572179;
        mx2 = 3439013;
        break;
    case 1402:
        mx0 = 1569294;
        mx2 = 3432163;
        break;
    case 1403:
        mx0 = 1566408;
        mx2 = 3425312;
        break;
    case 1404:
        mx0 = 1563525;
        mx2 = 3418470;
        break;
    case 1405:
        mx0 = 1560643;
        mx2 = 3411633;
        break;
    case 1406:
        mx0 = 1557763;
        mx2 = 3404802;
        break;
    case 1407:
        mx0 = 1554885;
        mx2 = 3397978;
        break;
    case 1408:
        mx0 = 1552008;
        mx2 = 3391159;
        break;
    case 1409:
        mx0 = 1549133;
        mx2 = 3384346;
        break;
    case 1410:
        mx0 = 1546259;
        mx2 = 3377538;
        break;
    case 1411:
        mx0 = 1543387;
        mx2 = 3370736;
        break;
    case 1412:
        mx0 = 1540518;
        mx2 = 3363943;
        break;
    case 1413:
        mx0 = 1537648;
        mx2 = 3357150;
        break;
    case 1414:
        mx0 = 1534782;
        mx2 = 3350368;
        break;
    case 1415:
        mx0 = 1531917;
        mx2 = 3343591;
        break;
    case 1416:
        mx0 = 1529054;
        mx2 = 3336820;
        break;
    case 1417:
        mx0 = 1526191;
        mx2 = 3330051;
        break;
    case 1418:
        mx0 = 1523331;
        mx2 = 3323292;
        break;
    case 1419:
        mx0 = 1520473;
        mx2 = 3316539;
        break;
    case 1420:
        mx0 = 1517616;
        mx2 = 3309790;
        break;
    case 1421:
        mx0 = 1514761;
        mx2 = 3303048;
        break;
    case 1422:
        mx0 = 1511907;
        mx2 = 3296310;
        break;
    case 1423:
        mx0 = 1509056;
        mx2 = 3289581;
        break;
    case 1424:
        mx0 = 1506205;
        mx2 = 3282855;
        break;
    case 1425:
        mx0 = 1503357;
        mx2 = 3276137;
        break;
    case 1426:
        mx0 = 1500510;
        mx2 = 3269423;
        break;
    case 1427:
        mx0 = 1497664;
        mx2 = 3262714;
        break;
    case 1428:
        mx0 = 1494819;
        mx2 = 3256009;
        break;
    case 1429:
        mx0 = 1491978;
        mx2 = 3249316;
        break;
    case 1430:
        mx0 = 1489138;
        mx2 = 3242626;
        break;
    case 1431:
        mx0 = 1486298;
        mx2 = 3235939;
        break;
    case 1432:
        mx0 = 1483462;
        mx2 = 3229263;
        break;
    case 1433:
        mx0 = 1480626;
        mx2 = 3222589;
        break;
    case 1434:
        mx0 = 1477793;
        mx2 = 3215924;
        break;
    case 1435:
        mx0 = 1474960;
        mx2 = 3209261;
        break;
    case 1436:
        mx0 = 1472130;
        mx2 = 3202606;
        break;
    case 1437:
        mx0 = 1469299;
        mx2 = 3195952;
        break;
    case 1438:
        mx0 = 1466473;
        mx2 = 3189311;
        break;
    case 1439:
        mx0 = 1463647;
        mx2 = 3182672;
        break;
    case 1440:
        mx0 = 1460823;
        mx2 = 3176039;
        break;
    case 1441:
        mx0 = 1458000;
        mx2 = 3169411;
        break;
    case 1442:
        mx0 = 1455178;
        mx2 = 3162787;
        break;
    case 1443:
        mx0 = 1452360;
        mx2 = 3156174;
        break;
    case 1444:
        mx0 = 1449543;
        mx2 = 3149566;
        break;
    case 1445:
        mx0 = 1446727;
        mx2 = 3142961;
        break;
    case 1446:
        mx0 = 1443911;
        mx2 = 3136359;
        break;
    case 1447:
        mx0 = 1441099;
        mx2 = 3129768;
        break;
    case 1448:
        mx0 = 1438287;
        mx2 = 3123179;
        break;
    case 1449:
        mx0 = 1435478;
        mx2 = 3116598;
        break;
    case 1450:
        mx0 = 1432669;
        mx2 = 3110020;
        break;
    case 1451:
        mx0 = 1429863;
        mx2 = 3103450;
        break;
    case 1452:
        mx0 = 1427058;
        mx2 = 3096885;
        break;
    case 1453:
        mx0 = 1424254;
        mx2 = 3090324;
        break;
    case 1454:
        mx0 = 1421453;
        mx2 = 3083772;
        break;
    case 1455:
        mx0 = 1418653;
        mx2 = 3077224;
        break;
    case 1456:
        mx0 = 1415855;
        mx2 = 3070682;
        break;
    case 1457:
        mx0 = 1413058;
        mx2 = 3064145;
        break;
    case 1458:
        mx0 = 1410262;
        mx2 = 3057612;
        break;
    case 1459:
        mx0 = 1407470;
        mx2 = 3051090;
        break;
    case 1460:
        mx0 = 1404677;
        mx2 = 3044568;
        break;
    case 1461:
        mx0 = 1401886;
        mx2 = 3038052;
        break;
    case 1462:
        mx0 = 1399097;
        mx2 = 3031543;
        break;
    case 1463:
        mx0 = 1396310;
        mx2 = 3025040;
        break;
    case 1464:
        mx0 = 1393525;
        mx2 = 3018544;
        break;
    case 1465:
        mx0 = 1390741;
        mx2 = 3012052;
        break;
    case 1466:
        mx0 = 1387957;
        mx2 = 3005562;
        break;
    case 1467:
        mx0 = 1385176;
        mx2 = 2999080;
        break;
    case 1468:
        mx0 = 1382397;
        mx2 = 2992606;
        break;
    case 1469:
        mx0 = 1379618;
        mx2 = 2986133;
        break;
    case 1470:
        mx0 = 1376842;
        mx2 = 2979668;
        break;
    case 1471:
        mx0 = 1374069;
        mx2 = 2973213;
        break;
    case 1472:
        mx0 = 1371295;
        mx2 = 2966757;
        break;
    case 1473:
        mx0 = 1368523;
        mx2 = 2960308;
        break;
    case 1474:
        mx0 = 1365753;
        mx2 = 2953865;
        break;
    case 1475:
        mx0 = 1362985;
        mx2 = 2947428;
        break;
    case 1476:
        mx0 = 1360218;
        mx2 = 2940996;
        break;
    case 1477:
        mx0 = 1357453;
        mx2 = 2934570;
        break;
    case 1478:
        mx0 = 1354689;
        mx2 = 2928149;
        break;
    case 1479:
        mx0 = 1351927;
        mx2 = 2921734;
        break;
    case 1480:
        mx0 = 1349167;
        mx2 = 2915325;
        break;
    case 1481:
        mx0 = 1346408;
        mx2 = 2908920;
        break;
    case 1482:
        mx0 = 1343650;
        mx2 = 2902520;
        break;
    case 1483:
        mx0 = 1340896;
        mx2 = 2896131;
        break;
    case 1484:
        mx0 = 1338139;
        mx2 = 2889736;
        break;
    case 1485:
        mx0 = 1335387;
        mx2 = 2883355;
        break;
    case 1486:
        mx0 = 1332637;
        mx2 = 2876980;
        break;
    case 1487:
        mx0 = 1329887;
        mx2 = 2870607;
        break;
    case 1488:
        mx0 = 1327139;
        mx2 = 2864241;
        break;
    case 1489:
        mx0 = 1324392;
        mx2 = 2857879;
        break;
    case 1490:
        mx0 = 1321647;
        mx2 = 2851523;
        break;
    case 1491:
        mx0 = 1318903;
        mx2 = 2845171;
        break;
    case 1492:
        mx0 = 1316162;
        mx2 = 2838828;
        break;
    case 1493:
        mx0 = 1313422;
        mx2 = 2832489;
        break;
    case 1494:
        mx0 = 1310683;
        mx2 = 2826154;
        break;
    case 1495:
        mx0 = 1307946;
        mx2 = 2819826;
        break;
    case 1496:
        mx0 = 1305210;
        mx2 = 2813502;
        break;
    case 1497:
        mx0 = 1302475;
        mx2 = 2807182;
        break;
    case 1498:
        mx0 = 1299743;
        mx2 = 2800870;
        break;
    case 1499:
        mx0 = 1297013;
        mx2 = 2794565;
        break;
    case 1500:
        mx0 = 1294283;
        mx2 = 2788262;
        break;
    case 1501:
        mx0 = 1291554;
        mx2 = 2781962;
        break;
    case 1502:
        mx0 = 1288829;
        mx2 = 2775674;
        break;
    case 1503:
        mx0 = 1286104;
        mx2 = 2769388;
        break;
    case 1504:
        mx0 = 1283381;
        mx2 = 2763108;
        break;
    case 1505:
        mx0 = 1280658;
        mx2 = 2756829;
        break;
    case 1506:
        mx0 = 1277938;
        mx2 = 2750560;
        break;
    case 1507:
        mx0 = 1275219;
        mx2 = 2744294;
        break;
    case 1508:
        mx0 = 1272503;
        mx2 = 2738037;
        break;
    case 1509:
        mx0 = 1269787;
        mx2 = 2731782;
        break;
    case 1510:
        mx0 = 1267072;
        mx2 = 2725531;
        break;
    case 1511:
        mx0 = 1264360;
        mx2 = 2719289;
        break;
    case 1512:
        mx0 = 1261648;
        mx2 = 2713048;
        break;
    case 1513:
        mx0 = 1258938;
        mx2 = 2706814;
        break;
    case 1514:
        mx0 = 1256231;
        mx2 = 2700588;
        break;
    case 1515:
        mx0 = 1253525;
        mx2 = 2694367;
        break;
    case 1516:
        mx0 = 1250819;
        mx2 = 2688147;
        break;
    case 1517:
        mx0 = 1248115;
        mx2 = 2681933;
        break;
    case 1518:
        mx0 = 1245414;
        mx2 = 2675728;
        break;
    case 1519:
        mx0 = 1242713;
        mx2 = 2669525;
        break;
    case 1520:
        mx0 = 1240014;
        mx2 = 2663328;
        break;
    case 1521:
        mx0 = 1237318;
        mx2 = 2657140;
        break;
    case 1522:
        mx0 = 1234622;
        mx2 = 2650954;
        break;
    case 1523:
        mx0 = 1231927;
        mx2 = 2644771;
        break;
    case 1524:
        mx0 = 1229233;
        mx2 = 2638593;
        break;
    case 1525:
        mx0 = 1226542;
        mx2 = 2632423;
        break;
    case 1526:
        mx0 = 1223851;
        mx2 = 2626255;
        break;
    case 1527:
        mx0 = 1221163;
        mx2 = 2620096;
        break;
    case 1528:
        mx0 = 1218477;
        mx2 = 2613942;
        break;
    case 1529:
        mx0 = 1215792;
        mx2 = 2607793;
        break;
    case 1530:
        mx0 = 1213107;
        mx2 = 2601646;
        break;
    case 1531:
        mx0 = 1210425;
        mx2 = 2595507;
        break;
    case 1532:
        mx0 = 1207744;
        mx2 = 2589372;
        break;
    case 1533:
        mx0 = 1205065;
        mx2 = 2583244;
        break;
    case 1534:
        mx0 = 1202386;
        mx2 = 2577117;
        break;
    case 1535:
        mx0 = 1199710;
        mx2 = 2570998;
        break;
    case 1536:
        mx0 = 1197035;
        mx2 = 2564884;
        break;
    case 1537:
        mx0 = 1194362;
        mx2 = 2558776;
        break;
    case 1538:
        mx0 = 1191690;
        mx2 = 2552672;
        break;
    case 1539:
        mx0 = 1189019;
        mx2 = 2546572;
        break;
    case 1540:
        mx0 = 1186350;
        mx2 = 2540478;
        break;
    case 1541:
        mx0 = 1183683;
        mx2 = 2534391;
        break;
    case 1542:
        mx0 = 1181017;
        mx2 = 2528307;
        break;
    case 1543:
        mx0 = 1178352;
        mx2 = 2522228;
        break;
    case 1544:
        mx0 = 1175690;
        mx2 = 2516157;
        break;
    case 1545:
        mx0 = 1173029;
        mx2 = 2510090;
        break;
    case 1546:
        mx0 = 1170368;
        mx2 = 2504024;
        break;
    case 1547:
        mx0 = 1167709;
        mx2 = 2497965;
        break;
    case 1548:
        mx0 = 1165052;
        mx2 = 2491912;
        break;
    case 1549:
        mx0 = 1162396;
        mx2 = 2485863;
        break;
    case 1550:
        mx0 = 1159743;
        mx2 = 2479823;
        break;
    case 1551:
        mx0 = 1157090;
        mx2 = 2473784;
        break;
    case 1552:
        mx0 = 1154438;
        mx2 = 2467749;
        break;
    case 1553:
        mx0 = 1151788;
        mx2 = 2461721;
        break;
    case 1554:
        mx0 = 1149140;
        mx2 = 2455699;
        break;
    case 1555:
        mx0 = 1146494;
        mx2 = 2449682;
        break;
    case 1556:
        mx0 = 1143849;
        mx2 = 2443670;
        break;
    case 1557:
        mx0 = 1141204;
        mx2 = 2437660;
        break;
    case 1558:
        mx0 = 1138563;
        mx2 = 2431660;
        break;
    case 1559:
        mx0 = 1135921;
        mx2 = 2425660;
        break;
    case 1560:
        mx0 = 1133282;
        mx2 = 2419668;
        break;
    case 1561:
        mx0 = 1130643;
        mx2 = 2413678;
        break;
    case 1562:
        mx0 = 1128007;
        mx2 = 2407696;
        break;
    case 1563:
        mx0 = 1125372;
        mx2 = 2401718;
        break;
    case 1564:
        mx0 = 1122738;
        mx2 = 2395744;
        break;
    case 1565:
        mx0 = 1120106;
        mx2 = 2389776;
        break;
    case 1566:
        mx0 = 1117475;
        mx2 = 2383813;
        break;
    case 1567:
        mx0 = 1114847;
        mx2 = 2377857;
        break;
    case 1568:
        mx0 = 1112218;
        mx2 = 2371901;
        break;
    case 1569:
        mx0 = 1109592;
        mx2 = 2365954;
        break;
    case 1570:
        mx0 = 1106967;
        mx2 = 2360010;
        break;
    case 1571:
        mx0 = 1104343;
        mx2 = 2354070;
        break;
    case 1572:
        mx0 = 1101722;
        mx2 = 2348139;
        break;
    case 1573:
        mx0 = 1099102;
        mx2 = 2342212;
        break;
    case 1574:
        mx0 = 1096482;
        mx2 = 2336286;
        break;
    case 1575:
        mx0 = 1093865;
        mx2 = 2330369;
        break;
    case 1576:
        mx0 = 1091249;
        mx2 = 2324455;
        break;
    case 1577:
        mx0 = 1088633;
        mx2 = 2318544;
        break;
    case 1578:
        mx0 = 1086020;
        mx2 = 2312640;
        break;
    case 1579:
        mx0 = 1083408;
        mx2 = 2306741;
        break;
    case 1580:
        mx0 = 1080798;
        mx2 = 2300847;
        break;
    case 1581:
        mx0 = 1078189;
        mx2 = 2294958;
        break;
    case 1582:
        mx0 = 1075581;
        mx2 = 2289072;
        break;
    case 1583:
        mx0 = 1072975;
        mx2 = 2283193;
        break;
    case 1584:
        mx0 = 1070370;
        mx2 = 2277317;
        break;
    case 1585:
        mx0 = 1067767;
        mx2 = 2271448;
        break;
    case 1586:
        mx0 = 1065166;
        mx2 = 2265584;
        break;
    case 1587:
        mx0 = 1062566;
        mx2 = 2259725;
        break;
    case 1588:
        mx0 = 1059966;
        mx2 = 2253867;
        break;
    case 1589:
        mx0 = 1057368;
        mx2 = 2248015;
        break;
    case 1590:
        mx0 = 1054773;
        mx2 = 2242172;
        break;
    case 1591:
        mx0 = 1052177;
        mx2 = 2236328;
        break;
    case 1592:
        mx0 = 1049584;
        mx2 = 2230492;
        break;
    case 1593:
        mx0 = 1046992;
        mx2 = 2224660;
        break;
    case 1594:
        mx0 = 1044402;
        mx2 = 2218835;
        break;
    case 1595:
        mx0 = 1041813;
        mx2 = 2213013;
        break;
    case 1596:
        mx0 = 1039226;
        mx2 = 2207197;
        break;
    case 1597:
        mx0 = 1036639;
        mx2 = 2201383;
        break;
    case 1598:
        mx0 = 1034054;
        mx2 = 2195575;
        break;
    case 1599:
        mx0 = 1031471;
        mx2 = 2189773;
        break;
    case 1600:
        mx0 = 1028889;
        mx2 = 2183974;
        break;
    case 1601:
        mx0 = 1026308;
        mx2 = 2178180;
        break;
    case 1602:
        mx0 = 1023730;
        mx2 = 2172394;
        break;
    case 1603:
        mx0 = 1021152;
        mx2 = 2166610;
        break;
    case 1604:
        mx0 = 1018576;
        mx2 = 2160831;
        break;
    case 1605:
        mx0 = 1016001;
        mx2 = 2155057;
        break;
    case 1606:
        mx0 = 1013427;
        mx2 = 2149286;
        break;
    case 1607:
        mx0 = 1010856;
        mx2 = 2143524;
        break;
    case 1608:
        mx0 = 1008285;
        mx2 = 2137763;
        break;
    case 1609:
        mx0 = 1005715;
        mx2 = 2132006;
        break;
    case 1610:
        mx0 = 1003147;
        mx2 = 2126255;
        break;
    case 1611:
        mx0 = 1000582;
        mx2 = 2120512;
        break;
    case 1612:
        mx0 = 998017;
        mx2 = 2114771;
        break;
    case 1613:
        mx0 = 995453;
        mx2 = 2109034;
        break;
    case 1614:
        mx0 = 992890;
        mx2 = 2103300;
        break;
    case 1615:
        mx0 = 990329;
        mx2 = 2097573;
        break;
    case 1616:
        mx0 = 987770;
        mx2 = 2091851;
        break;
    case 1617:
        mx0 = 985212;
        mx2 = 2086134;
        break;
    case 1618:
        mx0 = 982655;
        mx2 = 2080420;
        break;
    case 1619:
        mx0 = 980101;
        mx2 = 2074714;
        break;
    case 1620:
        mx0 = 977546;
        mx2 = 2069008;
        break;
    case 1621:
        mx0 = 974994;
        mx2 = 2063310;
        break;
    case 1622:
        mx0 = 972443;
        mx2 = 2057616;
        break;
    case 1623:
        mx0 = 969894;
        mx2 = 2051928;
        break;
    case 1624:
        mx0 = 967345;
        mx2 = 2046241;
        break;
    case 1625:
        mx0 = 964798;
        mx2 = 2040560;
        break;
    case 1626:
        mx0 = 962253;
        mx2 = 2034886;
        break;
    case 1627:
        mx0 = 959709;
        mx2 = 2029215;
        break;
    case 1628:
        mx0 = 957166;
        mx2 = 2023548;
        break;
    case 1629:
        mx0 = 954625;
        mx2 = 2017886;
        break;
    case 1630:
        mx0 = 952085;
        mx2 = 2012229;
        break;
    case 1631:
        mx0 = 949546;
        mx2 = 2006576;
        break;
    case 1632:
        mx0 = 947009;
        mx2 = 2000928;
        break;
    case 1633:
        mx0 = 944474;
        mx2 = 1995286;
        break;
    case 1634:
        mx0 = 941939;
        mx2 = 1989646;
        break;
    case 1635:
        mx0 = 939405;
        mx2 = 1984010;
        break;
    case 1636:
        mx0 = 936874;
        mx2 = 1978382;
        break;
    case 1637:
        mx0 = 934344;
        mx2 = 1972758;
        break;
    case 1638:
        mx0 = 931815;
        mx2 = 1967137;
        break;
    case 1639:
        mx0 = 929287;
        mx2 = 1961520;
        break;
    case 1640:
        mx0 = 926761;
        mx2 = 1955909;
        break;
    case 1641:
        mx0 = 924237;
        mx2 = 1950304;
        break;
    case 1642:
        mx0 = 921713;
        mx2 = 1944701;
        break;
    case 1643:
        mx0 = 919190;
        mx2 = 1939101;
        break;
    case 1644:
        mx0 = 916670;
        mx2 = 1933510;
        break;
    case 1645:
        mx0 = 914150;
        mx2 = 1927920;
        break;
    case 1646:
        mx0 = 911633;
        mx2 = 1922338;
        break;
    case 1647:
        mx0 = 909116;
        mx2 = 1916758;
        break;
    case 1648:
        mx0 = 906601;
        mx2 = 1911183;
        break;
    case 1649:
        mx0 = 904087;
        mx2 = 1905612;
        break;
    case 1650:
        mx0 = 901574;
        mx2 = 1900046;
        break;
    case 1651:
        mx0 = 899063;
        mx2 = 1894485;
        break;
    case 1652:
        mx0 = 896553;
        mx2 = 1888927;
        break;
    case 1653:
        mx0 = 894045;
        mx2 = 1883376;
        break;
    case 1654:
        mx0 = 891537;
        mx2 = 1877826;
        break;
    case 1655:
        mx0 = 889031;
        mx2 = 1872282;
        break;
    case 1656:
        mx0 = 886527;
        mx2 = 1866744;
        break;
    case 1657:
        mx0 = 884024;
        mx2 = 1861210;
        break;
    case 1658:
        mx0 = 881522;
        mx2 = 1855679;
        break;
    case 1659:
        mx0 = 879023;
        mx2 = 1850157;
        break;
    case 1660:
        mx0 = 876523;
        mx2 = 1844634;
        break;
    case 1661:
        mx0 = 874025;
        mx2 = 1839116;
        break;
    case 1662:
        mx0 = 871529;
        mx2 = 1833605;
        break;
    case 1663:
        mx0 = 869034;
        mx2 = 1828097;
        break;
    case 1664:
        mx0 = 866541;
        mx2 = 1822595;
        break;
    case 1665:
        mx0 = 864048;
        mx2 = 1817095;
        break;
    case 1666:
        mx0 = 861558;
        mx2 = 1811603;
        break;
    case 1667:
        mx0 = 859067;
        mx2 = 1806110;
        break;
    case 1668:
        mx0 = 856578;
        mx2 = 1800623;
        break;
    case 1669:
        mx0 = 854093;
        mx2 = 1795146;
        break;
    case 1670:
        mx0 = 851607;
        mx2 = 1789669;
        break;
    case 1671:
        mx0 = 849122;
        mx2 = 1784195;
        break;
    case 1672:
        mx0 = 846639;
        mx2 = 1778727;
        break;
    case 1673:
        mx0 = 844158;
        mx2 = 1773265;
        break;
    case 1674:
        mx0 = 841678;
        mx2 = 1767806;
        break;
    case 1675:
        mx0 = 839199;
        mx2 = 1762352;
        break;
    case 1676:
        mx0 = 836721;
        mx2 = 1756901;
        break;
    case 1677:
        mx0 = 834245;
        mx2 = 1751455;
        break;
    case 1678:
        mx0 = 831770;
        mx2 = 1746014;
        break;
    case 1679:
        mx0 = 829296;
        mx2 = 1740576;
        break;
    case 1680:
        mx0 = 826824;
        mx2 = 1735144;
        break;
    case 1681:
        mx0 = 824354;
        mx2 = 1729718;
        break;
    case 1682:
        mx0 = 821883;
        mx2 = 1724291;
        break;
    case 1683:
        mx0 = 819415;
        mx2 = 1718872;
        break;
    case 1684:
        mx0 = 816948;
        mx2 = 1713457;
        break;
    case 1685:
        mx0 = 814482;
        mx2 = 1708045;
        break;
    case 1686:
        mx0 = 812018;
        mx2 = 1702639;
        break;
    case 1687:
        mx0 = 809555;
        mx2 = 1697237;
        break;
    case 1688:
        mx0 = 807093;
        mx2 = 1691839;
        break;
    case 1689:
        mx0 = 804633;
        mx2 = 1686446;
        break;
    case 1690:
        mx0 = 802174;
        mx2 = 1681057;
        break;
    case 1691:
        mx0 = 799716;
        mx2 = 1675672;
        break;
    case 1692:
        mx0 = 797260;
        mx2 = 1670292;
        break;
    case 1693:
        mx0 = 794805;
        mx2 = 1664916;
        break;
    case 1694:
        mx0 = 792351;
        mx2 = 1659544;
        break;
    case 1695:
        mx0 = 789898;
        mx2 = 1654175;
        break;
    case 1696:
        mx0 = 787447;
        mx2 = 1648812;
        break;
    case 1697:
        mx0 = 784997;
        mx2 = 1643453;
        break;
    case 1698:
        mx0 = 782549;
        mx2 = 1638100;
        break;
    case 1699:
        mx0 = 780102;
        mx2 = 1632750;
        break;
    case 1700:
        mx0 = 777656;
        mx2 = 1627404;
        break;
    case 1701:
        mx0 = 775210;
        mx2 = 1622059;
        break;
    case 1702:
        mx0 = 772767;
        mx2 = 1616722;
        break;
    case 1703:
        mx0 = 770326;
        mx2 = 1611391;
        break;
    case 1704:
        mx0 = 767886;
        mx2 = 1606064;
        break;
    case 1705:
        mx0 = 765446;
        mx2 = 1600738;
        break;
    case 1706:
        mx0 = 763007;
        mx2 = 1595415;
        break;
    case 1707:
        mx0 = 760570;
        mx2 = 1590099;
        break;
    case 1708:
        mx0 = 758136;
        mx2 = 1584790;
        break;
    case 1709:
        mx0 = 755700;
        mx2 = 1579478;
        break;
    case 1710:
        mx0 = 753268;
        mx2 = 1574177;
        break;
    case 1711:
        mx0 = 750836;
        mx2 = 1568877;
        break;
    case 1712:
        mx0 = 748406;
        mx2 = 1563582;
        break;
    case 1713:
        mx0 = 745976;
        mx2 = 1558290;
        break;
    case 1714:
        mx0 = 743549;
        mx2 = 1553005;
        break;
    case 1715:
        mx0 = 741122;
        mx2 = 1547721;
        break;
    case 1716:
        mx0 = 738697;
        mx2 = 1542443;
        break;
    case 1717:
        mx0 = 736273;
        mx2 = 1537169;
        break;
    case 1718:
        mx0 = 733850;
        mx2 = 1531898;
        break;
    case 1719:
        mx0 = 731429;
        mx2 = 1526634;
        break;
    case 1720:
        mx0 = 729008;
        mx2 = 1521370;
        break;
    case 1721:
        mx0 = 726590;
        mx2 = 1516115;
        break;
    case 1722:
        mx0 = 724173;
        mx2 = 1510863;
        break;
    case 1723:
        mx0 = 721755;
        mx2 = 1505610;
        break;
    case 1724:
        mx0 = 719341;
        mx2 = 1500367;
        break;
    case 1725:
        mx0 = 716927;
        mx2 = 1495126;
        break;
    case 1726:
        mx0 = 714516;
        mx2 = 1489892;
        break;
    case 1727:
        mx0 = 712104;
        mx2 = 1484658;
        break;
    case 1728:
        mx0 = 709694;
        mx2 = 1479430;
        break;
    case 1729:
        mx0 = 707286;
        mx2 = 1474207;
        break;
    case 1730:
        mx0 = 704878;
        mx2 = 1468985;
        break;
    case 1731:
        mx0 = 702472;
        mx2 = 1463770;
        break;
    case 1732:
        mx0 = 700067;
        mx2 = 1458558;
        break;
    case 1733:
        mx0 = 697665;
        mx2 = 1453354;
        break;
    case 1734:
        mx0 = 695262;
        mx2 = 1448148;
        break;
    case 1735:
        mx0 = 692861;
        mx2 = 1442949;
        break;
    case 1736:
        mx0 = 690462;
        mx2 = 1437756;
        break;
    case 1737:
        mx0 = 688063;
        mx2 = 1432563;
        break;
    case 1738:
        mx0 = 685667;
        mx2 = 1427379;
        break;
    case 1739:
        mx0 = 683270;
        mx2 = 1422194;
        break;
    case 1740:
        mx0 = 680875;
        mx2 = 1417014;
        break;
    case 1741:
        mx0 = 678482;
        mx2 = 1411841;
        break;
    case 1742:
        mx0 = 676090;
        mx2 = 1406670;
        break;
    case 1743:
        mx0 = 673699;
        mx2 = 1401504;
        break;
    case 1744:
        mx0 = 671310;
        mx2 = 1396343;
        break;
    case 1745:
        mx0 = 668922;
        mx2 = 1391185;
        break;
    case 1746:
        mx0 = 666535;
        mx2 = 1386031;
        break;
    case 1747:
        mx0 = 664149;
        mx2 = 1380880;
        break;
    case 1748:
        mx0 = 661765;
        mx2 = 1375736;
        break;
    case 1749:
        mx0 = 659381;
        mx2 = 1370592;
        break;
    case 1750:
        mx0 = 656999;
        mx2 = 1365454;
        break;
    case 1751:
        mx0 = 654618;
        mx2 = 1360320;
        break;
    case 1752:
        mx0 = 652239;
        mx2 = 1355192;
        break;
    case 1753:
        mx0 = 649861;
        mx2 = 1350066;
        break;
    case 1754:
        mx0 = 647483;
        mx2 = 1344943;
        break;
    case 1755:
        mx0 = 645107;
        mx2 = 1339825;
        break;
    case 1756:
        mx0 = 642734;
        mx2 = 1334714;
        break;
    case 1757:
        mx0 = 640361;
        mx2 = 1329605;
        break;
    case 1758:
        mx0 = 637989;
        mx2 = 1324500;
        break;
    case 1759:
        mx0 = 635617;
        mx2 = 1319396;
        break;
    case 1760:
        mx0 = 633248;
        mx2 = 1314299;
        break;
    case 1761:
        mx0 = 630880;
        mx2 = 1309206;
        break;
    case 1762:
        mx0 = 628512;
        mx2 = 1304115;
        break;
    case 1763:
        mx0 = 626147;
        mx2 = 1299031;
        break;
    case 1764:
        mx0 = 623783;
        mx2 = 1293951;
        break;
    case 1765:
        mx0 = 621419;
        mx2 = 1288872;
        break;
    case 1766:
        mx0 = 619057;
        mx2 = 1283799;
        break;
    case 1767:
        mx0 = 616697;
        mx2 = 1278731;
        break;
    case 1768:
        mx0 = 614337;
        mx2 = 1273665;
        break;
    case 1769:
        mx0 = 611978;
        mx2 = 1268602;
        break;
    case 1770:
        mx0 = 609622;
        mx2 = 1263547;
        break;
    case 1771:
        mx0 = 607265;
        mx2 = 1258491;
        break;
    case 1772:
        mx0 = 604910;
        mx2 = 1253441;
        break;
    case 1773:
        mx0 = 602557;
        mx2 = 1248396;
        break;
    case 1774:
        mx0 = 600205;
        mx2 = 1243355;
        break;
    case 1775:
        mx0 = 597854;
        mx2 = 1238317;
        break;
    case 1776:
        mx0 = 595505;
        mx2 = 1233285;
        break;
    case 1777:
        mx0 = 593156;
        mx2 = 1228254;
        break;
    case 1778:
        mx0 = 590809;
        mx2 = 1223229;
        break;
    case 1779:
        mx0 = 588463;
        mx2 = 1218207;
        break;
    case 1780:
        mx0 = 586118;
        mx2 = 1213188;
        break;
    case 1781:
        mx0 = 583774;
        mx2 = 1208174;
        break;
    case 1782:
        mx0 = 581432;
        mx2 = 1203164;
        break;
    case 1783:
        mx0 = 579091;
        mx2 = 1198158;
        break;
    case 1784:
        mx0 = 576751;
        mx2 = 1193156;
        break;
    case 1785:
        mx0 = 574413;
        mx2 = 1188159;
        break;
    case 1786:
        mx0 = 572075;
        mx2 = 1183164;
        break;
    case 1787:
        mx0 = 569739;
        mx2 = 1178174;
        break;
    case 1788:
        mx0 = 567403;
        mx2 = 1173185;
        break;
    case 1789:
        mx0 = 565070;
        mx2 = 1168204;
        break;
    case 1790:
        mx0 = 562737;
        mx2 = 1163224;
        break;
    case 1791:
        mx0 = 560405;
        mx2 = 1158248;
        break;
    case 1792:
        mx0 = 558075;
        mx2 = 1153277;
        break;
    case 1793:
        mx0 = 555746;
        mx2 = 1148310;
        break;
    case 1794:
        mx0 = 553418;
        mx2 = 1143346;
        break;
    case 1795:
        mx0 = 551093;
        mx2 = 1138390;
        break;
    case 1796:
        mx0 = 548767;
        mx2 = 1133433;
        break;
    case 1797:
        mx0 = 546443;
        mx2 = 1128482;
        break;
    case 1798:
        mx0 = 544121;
        mx2 = 1123536;
        break;
    case 1799:
        mx0 = 541799;
        mx2 = 1118591;
        break;
    case 1800:
        mx0 = 539478;
        mx2 = 1113650;
        break;
    case 1801:
        mx0 = 537158;
        mx2 = 1108712;
        break;
    case 1802:
        mx0 = 534841;
        mx2 = 1103782;
        break;
    case 1803:
        mx0 = 532523;
        mx2 = 1098851;
        break;
    case 1804:
        mx0 = 530208;
        mx2 = 1093928;
        break;
    case 1805:
        mx0 = 527894;
        mx2 = 1089008;
        break;
    case 1806:
        mx0 = 525581;
        mx2 = 1084092;
        break;
    case 1807:
        mx0 = 523267;
        mx2 = 1079174;
        break;
    case 1808:
        mx0 = 520958;
        mx2 = 1074269;
        break;
    case 1809:
        mx0 = 518648;
        mx2 = 1069363;
        break;
    case 1810:
        mx0 = 516339;
        mx2 = 1064460;
        break;
    case 1811:
        mx0 = 514032;
        mx2 = 1059563;
        break;
    case 1812:
        mx0 = 511726;
        mx2 = 1054669;
        break;
    case 1813:
        mx0 = 509421;
        mx2 = 1049778;
        break;
    case 1814:
        mx0 = 507117;
        mx2 = 1044891;
        break;
    case 1815:
        mx0 = 504815;
        mx2 = 1040009;
        break;
    case 1816:
        mx0 = 502513;
        mx2 = 1035129;
        break;
    case 1817:
        mx0 = 500214;
        mx2 = 1030256;
        break;
    case 1818:
        mx0 = 497914;
        mx2 = 1025382;
        break;
    case 1819:
        mx0 = 495617;
        mx2 = 1020516;
        break;
    case 1820:
        mx0 = 493321;
        mx2 = 1015653;
        break;
    case 1821:
        mx0 = 491025;
        mx2 = 1010792;
        break;
    case 1822:
        mx0 = 488730;
        mx2 = 1005934;
        break;
    case 1823:
        mx0 = 486438;
        mx2 = 1001084;
        break;
    case 1824:
        mx0 = 484146;
        mx2 = 996234;
        break;
    case 1825:
        mx0 = 481855;
        mx2 = 991389;
        break;
    case 1826:
        mx0 = 479566;
        mx2 = 986548;
        break;
    case 1827:
        mx0 = 477277;
        mx2 = 981709;
        break;
    case 1828:
        mx0 = 474990;
        mx2 = 976875;
        break;
    case 1829:
        mx0 = 472704;
        mx2 = 972045;
        break;
    case 1830:
        mx0 = 470420;
        mx2 = 967220;
        break;
    case 1831:
        mx0 = 468136;
        mx2 = 962397;
        break;
    case 1832:
        mx0 = 465854;
        mx2 = 957579;
        break;
    case 1833:
        mx0 = 463572;
        mx2 = 952762;
        break;
    case 1834:
        mx0 = 461293;
        mx2 = 947953;
        break;
    case 1835:
        mx0 = 459014;
        mx2 = 943145;
        break;
    case 1836:
        mx0 = 456736;
        mx2 = 938340;
        break;
    case 1837:
        mx0 = 454459;
        mx2 = 933539;
        break;
    case 1838:
        mx0 = 452184;
        mx2 = 928743;
        break;
    case 1839:
        mx0 = 449910;
        mx2 = 923950;
        break;
    case 1840:
        mx0 = 447637;
        mx2 = 919161;
        break;
    case 1841:
        mx0 = 445365;
        mx2 = 914375;
        break;
    case 1842:
        mx0 = 443095;
        mx2 = 909595;
        break;
    case 1843:
        mx0 = 440825;
        mx2 = 904816;
        break;
    case 1844:
        mx0 = 438557;
        mx2 = 900042;
        break;
    case 1845:
        mx0 = 436290;
        mx2 = 895271;
        break;
    case 1846:
        mx0 = 434024;
        mx2 = 890504;
        break;
    case 1847:
        mx0 = 431759;
        mx2 = 885740;
        break;
    case 1848:
        mx0 = 429495;
        mx2 = 880980;
        break;
    case 1849:
        mx0 = 427233;
        mx2 = 876225;
        break;
    case 1850:
        mx0 = 424971;
        mx2 = 871471;
        break;
    case 1851:
        mx0 = 422711;
        mx2 = 866723;
        break;
    case 1852:
        mx0 = 420452;
        mx2 = 861978;
        break;
    case 1853:
        mx0 = 418195;
        mx2 = 857238;
        break;
    case 1854:
        mx0 = 415937;
        mx2 = 852498;
        break;
    case 1855:
        mx0 = 413682;
        mx2 = 847765;
        break;
    case 1856:
        mx0 = 411427;
        mx2 = 843033;
        break;
    case 1857:
        mx0 = 409174;
        mx2 = 838306;
        break;
    case 1858:
        mx0 = 406922;
        mx2 = 833583;
        break;
    case 1859:
        mx0 = 404671;
        mx2 = 828864;
        break;
    case 1860:
        mx0 = 402422;
        mx2 = 824149;
        break;
    case 1861:
        mx0 = 400174;
        mx2 = 819438;
        break;
    case 1862:
        mx0 = 397926;
        mx2 = 814728;
        break;
    case 1863:
        mx0 = 395679;
        mx2 = 810022;
        break;
    case 1864:
        mx0 = 393434;
        mx2 = 805320;
        break;
    case 1865:
        mx0 = 391189;
        mx2 = 800620;
        break;
    case 1866:
        mx0 = 388947;
        mx2 = 795928;
        break;
    case 1867:
        mx0 = 386705;
        mx2 = 791237;
        break;
    case 1868:
        mx0 = 384464;
        mx2 = 786549;
        break;
    case 1869:
        mx0 = 382225;
        mx2 = 781866;
        break;
    case 1870:
        mx0 = 379987;
        mx2 = 777187;
        break;
    case 1871:
        mx0 = 377750;
        mx2 = 772511;
        break;
    case 1872:
        mx0 = 375513;
        mx2 = 767836;
        break;
    case 1873:
        mx0 = 373279;
        mx2 = 763168;
        break;
    case 1874:
        mx0 = 371045;
        mx2 = 758502;
        break;
    case 1875:
        mx0 = 368813;
        mx2 = 753841;
        break;
    case 1876:
        mx0 = 366581;
        mx2 = 749182;
        break;
    case 1877:
        mx0 = 364350;
        mx2 = 744525;
        break;
    case 1878:
        mx0 = 362121;
        mx2 = 739874;
        break;
    case 1879:
        mx0 = 359894;
        mx2 = 735228;
        break;
    case 1880:
        mx0 = 357666;
        mx2 = 730582;
        break;
    case 1881:
        mx0 = 355440;
        mx2 = 725941;
        break;
    case 1882:
        mx0 = 353216;
        mx2 = 721305;
        break;
    case 1883:
        mx0 = 350993;
        mx2 = 716672;
        break;
    case 1884:
        mx0 = 348769;
        mx2 = 712039;
        break;
    case 1885:
        mx0 = 346549;
        mx2 = 707415;
        break;
    case 1886:
        mx0 = 344328;
        mx2 = 702790;
        break;
    case 1887:
        mx0 = 342110;
        mx2 = 698172;
        break;
    case 1888:
        mx0 = 339891;
        mx2 = 693554;
        break;
    case 1889:
        mx0 = 337675;
        mx2 = 688943;
        break;
    case 1890:
        mx0 = 335459;
        mx2 = 684333;
        break;
    case 1891:
        mx0 = 333245;
        mx2 = 679728;
        break;
    case 1892:
        mx0 = 331031;
        mx2 = 675125;
        break;
    case 1893:
        mx0 = 328819;
        mx2 = 670527;
        break;
    case 1894:
        mx0 = 326608;
        mx2 = 665932;
        break;
    case 1895:
        mx0 = 324397;
        mx2 = 661339;
        break;
    case 1896:
        mx0 = 322189;
        mx2 = 656753;
        break;
    case 1897:
        mx0 = 319981;
        mx2 = 652168;
        break;
    case 1898:
        mx0 = 317775;
        mx2 = 647588;
        break;
    case 1899:
        mx0 = 315569;
        mx2 = 643009;
        break;
    case 1900:
        mx0 = 313365;
        mx2 = 638436;
        break;
    case 1901:
        mx0 = 311162;
        mx2 = 633866;
        break;
    case 1902:
        mx0 = 308959;
        mx2 = 629297;
        break;
    case 1903:
        mx0 = 306758;
        mx2 = 624734;
        break;
    case 1904:
        mx0 = 304558;
        mx2 = 620173;
        break;
    case 1905:
        mx0 = 302359;
        mx2 = 615616;
        break;
    case 1906:
        mx0 = 300161;
        mx2 = 611062;
        break;
    case 1907:
        mx0 = 297964;
        mx2 = 606512;
        break;
    case 1908:
        mx0 = 295769;
        mx2 = 601966;
        break;
    case 1909:
        mx0 = 293575;
        mx2 = 597424;
        break;
    case 1910:
        mx0 = 291382;
        mx2 = 592885;
        break;
    case 1911:
        mx0 = 289189;
        mx2 = 588348;
        break;
    case 1912:
        mx0 = 286998;
        mx2 = 583815;
        break;
    case 1913:
        mx0 = 284808;
        mx2 = 579286;
        break;
    case 1914:
        mx0 = 282619;
        mx2 = 574760;
        break;
    case 1915:
        mx0 = 280432;
        mx2 = 570239;
        break;
    case 1916:
        mx0 = 278245;
        mx2 = 565719;
        break;
    case 1917:
        mx0 = 276059;
        mx2 = 561203;
        break;
    case 1918:
        mx0 = 273875;
        mx2 = 556692;
        break;
    case 1919:
        mx0 = 271691;
        mx2 = 552182;
        break;
    case 1920:
        mx0 = 269509;
        mx2 = 547677;
        break;
    case 1921:
        mx0 = 267328;
        mx2 = 543175;
        break;
    case 1922:
        mx0 = 265148;
        mx2 = 538677;
        break;
    case 1923:
        mx0 = 262969;
        mx2 = 534182;
        break;
    case 1924:
        mx0 = 260792;
        mx2 = 529692;
        break;
    case 1925:
        mx0 = 258615;
        mx2 = 525203;
        break;
    case 1926:
        mx0 = 256439;
        mx2 = 520717;
        break;
    case 1927:
        mx0 = 254264;
        mx2 = 516235;
        break;
    case 1928:
        mx0 = 252091;
        mx2 = 511758;
        break;
    case 1929:
        mx0 = 249919;
        mx2 = 507284;
        break;
    case 1930:
        mx0 = 247747;
        mx2 = 502811;
        break;
    case 1931:
        mx0 = 245577;
        mx2 = 498343;
        break;
    case 1932:
        mx0 = 243409;
        mx2 = 493881;
        break;
    case 1933:
        mx0 = 241241;
        mx2 = 489420;
        break;
    case 1934:
        mx0 = 239073;
        mx2 = 484960;
        break;
    case 1935:
        mx0 = 236907;
        mx2 = 480505;
        break;
    case 1936:
        mx0 = 234742;
        mx2 = 476053;
        break;
    case 1937:
        mx0 = 232578;
        mx2 = 471604;
        break;
    case 1938:
        mx0 = 230416;
        mx2 = 467161;
        break;
    case 1939:
        mx0 = 228254;
        mx2 = 462719;
        break;
    case 1940:
        mx0 = 226094;
        mx2 = 458282;
        break;
    case 1941:
        mx0 = 223934;
        mx2 = 453846;
        break;
    case 1942:
        mx0 = 221776;
        mx2 = 449415;
        break;
    case 1943:
        mx0 = 219619;
        mx2 = 444988;
        break;
    case 1944:
        mx0 = 217463;
        mx2 = 440563;
        break;
    case 1945:
        mx0 = 215308;
        mx2 = 436142;
        break;
    case 1946:
        mx0 = 213154;
        mx2 = 431724;
        break;
    case 1947:
        mx0 = 211001;
        mx2 = 427309;
        break;
    case 1948:
        mx0 = 208850;
        mx2 = 422900;
        break;
    case 1949:
        mx0 = 206699;
        mx2 = 418491;
        break;
    case 1950:
        mx0 = 204549;
        mx2 = 414086;
        break;
    case 1951:
        mx0 = 202401;
        mx2 = 409686;
        break;
    case 1952:
        mx0 = 200253;
        mx2 = 405286;
        break;
    case 1953:
        mx0 = 198106;
        mx2 = 400890;
        break;
    case 1954:
        mx0 = 195961;
        mx2 = 396500;
        break;
    case 1955:
        mx0 = 193817;
        mx2 = 392112;
        break;
    case 1956:
        mx0 = 191674;
        mx2 = 387728;
        break;
    case 1957:
        mx0 = 189531;
        mx2 = 383344;
        break;
    case 1958:
        mx0 = 187391;
        mx2 = 378968;
        break;
    case 1959:
        mx0 = 185251;
        mx2 = 374593;
        break;
    case 1960:
        mx0 = 183112;
        mx2 = 370221;
        break;
    case 1961:
        mx0 = 180974;
        mx2 = 365852;
        break;
    case 1962:
        mx0 = 178837;
        mx2 = 361487;
        break;
    case 1963:
        mx0 = 176701;
        mx2 = 357124;
        break;
    case 1964:
        mx0 = 174567;
        mx2 = 352767;
        break;
    case 1965:
        mx0 = 172433;
        mx2 = 348410;
        break;
    case 1966:
        mx0 = 170300;
        mx2 = 344057;
        break;
    case 1967:
        mx0 = 168169;
        mx2 = 339709;
        break;
    case 1968:
        mx0 = 166039;
        mx2 = 335364;
        break;
    case 1969:
        mx0 = 163909;
        mx2 = 331021;
        break;
    case 1970:
        mx0 = 161781;
        mx2 = 326682;
        break;
    case 1971:
        mx0 = 159654;
        mx2 = 322347;
        break;
    case 1972:
        mx0 = 157528;
        mx2 = 318014;
        break;
    case 1973:
        mx0 = 155402;
        mx2 = 313683;
        break;
    case 1974:
        mx0 = 153278;
        mx2 = 309357;
        break;
    case 1975:
        mx0 = 151155;
        mx2 = 305034;
        break;
    case 1976:
        mx0 = 149034;
        mx2 = 300716;
        break;
    case 1977:
        mx0 = 146913;
        mx2 = 296399;
        break;
    case 1978:
        mx0 = 144793;
        mx2 = 292085;
        break;
    case 1979:
        mx0 = 142674;
        mx2 = 287775;
        break;
    case 1980:
        mx0 = 140557;
        mx2 = 283469;
        break;
    case 1981:
        mx0 = 138440;
        mx2 = 279165;
        break;
    case 1982:
        mx0 = 136324;
        mx2 = 274863;
        break;
    case 1983:
        mx0 = 134209;
        mx2 = 270565;
        break;
    case 1984:
        mx0 = 132096;
        mx2 = 266272;
        break;
    case 1985:
        mx0 = 129983;
        mx2 = 261980;
        break;
    case 1986:
        mx0 = 127872;
        mx2 = 257693;
        break;
    case 1987:
        mx0 = 125761;
        mx2 = 253407;
        break;
    case 1988:
        mx0 = 123652;
        mx2 = 249127;
        break;
    case 1989:
        mx0 = 121544;
        mx2 = 244849;
        break;
    case 1990:
        mx0 = 119437;
        mx2 = 240575;
        break;
    case 1991:
        mx0 = 117330;
        mx2 = 236301;
        break;
    case 1992:
        mx0 = 115225;
        mx2 = 232033;
        break;
    case 1993:
        mx0 = 113121;
        mx2 = 227767;
        break;
    case 1994:
        mx0 = 111018;
        mx2 = 223505;
        break;
    case 1995:
        mx0 = 108916;
        mx2 = 219246;
        break;
    case 1996:
        mx0 = 106815;
        mx2 = 214990;
        break;
    case 1997:
        mx0 = 104715;
        mx2 = 210737;
        break;
    case 1998:
        mx0 = 102616;
        mx2 = 206487;
        break;
    case 1999:
        mx0 = 100518;
        mx2 = 202240;
        break;
    case 2000:
        mx0 = 98421;
        mx2 = 197997;
        break;
    case 2001:
        mx0 = 96325;
        mx2 = 193756;
        break;
    case 2002:
        mx0 = 94231;
        mx2 = 189521;
        break;
    case 2003:
        mx0 = 92137;
        mx2 = 185286;
        break;
    case 2004:
        mx0 = 90044;
        mx2 = 181055;
        break;
    case 2005:
        mx0 = 87953;
        mx2 = 176828;
        break;
    case 2006:
        mx0 = 85862;
        mx2 = 172603;
        break;
    case 2007:
        mx0 = 83772;
        mx2 = 168381;
        break;
    case 2008:
        mx0 = 81684;
        mx2 = 164163;
        break;
    case 2009:
        mx0 = 79597;
        mx2 = 159949;
        break;
    case 2010:
        mx0 = 77510;
        mx2 = 155736;
        break;
    case 2011:
        mx0 = 75424;
        mx2 = 151526;
        break;
    case 2012:
        mx0 = 73339;
        mx2 = 147319;
        break;
    case 2013:
        mx0 = 71257;
        mx2 = 143119;
        break;
    case 2014:
        mx0 = 69173;
        mx2 = 138916;
        break;
    case 2015:
        mx0 = 67092;
        mx2 = 134721;
        break;
    case 2016:
        mx0 = 65012;
        mx2 = 130528;
        break;
    case 2017:
        mx0 = 62932;
        mx2 = 126336;
        break;
    case 2018:
        mx0 = 60855;
        mx2 = 122151;
        break;
    case 2019:
        mx0 = 58777;
        mx2 = 117966;
        break;
    case 2020:
        mx0 = 56701;
        mx2 = 113785;
        break;
    case 2021:
        mx0 = 54626;
        mx2 = 109608;
        break;
    case 2022:
        mx0 = 52551;
        mx2 = 105431;
        break;
    case 2023:
        mx0 = 50478;
        mx2 = 101260;
        break;
    case 2024:
        mx0 = 48406;
        mx2 = 97091;
        break;
    case 2025:
        mx0 = 46335;
        mx2 = 92926;
        break;
    case 2026:
        mx0 = 44265;
        mx2 = 88764;
        break;
    case 2027:
        mx0 = 42195;
        mx2 = 84602;
        break;
    case 2028:
        mx0 = 40127;
        mx2 = 80446;
        break;
    case 2029:
        mx0 = 38060;
        mx2 = 76293;
        break;
    case 2030:
        mx0 = 35994;
        mx2 = 72142;
        break;
    case 2031:
        mx0 = 33929;
        mx2 = 67995;
        break;
    case 2032:
        mx0 = 31865;
        mx2 = 63851;
        break;
    case 2033:
        mx0 = 29802;
        mx2 = 59710;
        break;
    case 2034:
        mx0 = 27739;
        mx2 = 55570;
        break;
    case 2035:
        mx0 = 25678;
        mx2 = 51435;
        break;
    case 2036:
        mx0 = 23618;
        mx2 = 47302;
        break;
    case 2037:
        mx0 = 21559;
        mx2 = 43173;
        break;
    case 2038:
        mx0 = 19502;
        mx2 = 39049;
        break;
    case 2039:
        mx0 = 17443;
        mx2 = 34922;
        break;
    case 2040:
        mx0 = 15387;
        mx2 = 30802;
        break;
    case 2041:
        mx0 = 13334;
        mx2 = 26689;
        break;
    case 2042:
        mx0 = 11279;
        mx2 = 22573;
        break;
    case 2043:
        mx0 = 9226;
        mx2 = 18462;
        break;
    case 2044:
        mx0 = 7175;
        mx2 = 14356;
        break;
    case 2045:
        mx0 = 5123;
        mx2 = 10249;
        break;
    case 2046:
        mx0 = 3073;
        mx2 = 6147;
        break;
    case 2047:
        mx0 = 1024;
        mx2 = 2048;
        break;
    }

    long max02a,mya;
    unsigned int max02,flag,mix2a,mix2b,mix2;
    unsigned int sx,sy,ex,mx;
    unsigned int mya2,flaga,my,e2ab,eya,eyb,ey,y;
    float r;

    max02a = (long)((1 << 23) | ma) * (long)((1 << 23) | mx2);
    max02a = max02a >> 20;
    max02 = (unsigned int)max02a;
    flag = (max02 >> 27) & 1;
    if(flag == 1) max02 = (max02 & 0x7ffffff) >> 4;
    else max02 = (max02 & 0x3ffffff) >> 3;
    mix2a = (1 << 24) | (mx0 << 1);
    mix2b = (1 << 23) | max02;
    mix2 = mix2a - mix2b;
    mix2 = mix2 & 0x7fffff;
    sx = x1 >> 31;
    ex = (x1 & 0x7fffffff) >> 23;
    mx = x1 & 0x7fffff;
    sy = sx ^ sa;
    mya = (long)((1 << 23) | mx) * (long)((1 << 23) | mix2);
    mya = mya >> 20;
    mya2 = (unsigned int)mya;
    flaga = (mya2 >> 27) & 1;
    if(flaga == 1) my = (mya2 & 0x7ffffff) >> 4;
    else my = (mya2 & 0x3ffffff) >> 3;
    if(ex == 0) e2ab = 0;
    else e2ab = 253;
    eya = ex + e2ab + flaga;
    eyb = 127 + ea;
    if(eya > eyb) ey = eya - eyb;
    else ey = 0;
    y = (sy << 31) | (ey << 23) | my;
    r = *((float *)&y);

    return r;

}

float fsqrt(float f){

    unsigned int odd_flag,x,ex,mx,index,thalf_x0,half_x03;
    x = *((unsigned int *)&f);
    ex = (x & 0x7fffffff) >> 23;
    mx = x & 0x7fffff;
    index = (x & 0xffffff) >> 12;
    odd_flag = ex & 1; 
    switch(index){
    case 0:
        thalf_x0 = 17792753;
        half_x03 = 23717878;
        break;
    case 1:
        thalf_x0 = 17788412;
        half_x03 = 23700523;
        break;
    case 2:
        thalf_x0 = 17784074;
        half_x03 = 23683188;
        break;
    case 3:
        thalf_x0 = 17779739;
        half_x03 = 23665873;
        break;
    case 4:
        thalf_x0 = 17775408;
        half_x03 = 23648585;
        break;
    case 5:
        thalf_x0 = 17771078;
        half_x03 = 23631305;
        break;
    case 6:
        thalf_x0 = 17766753;
        half_x03 = 23614057;
        break;
    case 7:
        thalf_x0 = 17762433;
        half_x03 = 23596836;
        break;
    case 8:
        thalf_x0 = 17758112;
        half_x03 = 23579617;
        break;
    case 9:
        thalf_x0 = 17753796;
        half_x03 = 23562431;
        break;
    case 10:
        thalf_x0 = 17749484;
        half_x03 = 23545265;
        break;
    case 11:
        thalf_x0 = 17745173;
        half_x03 = 23528113;
        break;
    case 12:
        thalf_x0 = 17740865;
        half_x03 = 23510981;
        break;
    case 13:
        thalf_x0 = 17736563;
        half_x03 = 23493882;
        break;
    case 14:
        thalf_x0 = 17732264;
        half_x03 = 23476803;
        break;
    case 15:
        thalf_x0 = 17727965;
        half_x03 = 23459732;
        break;
    case 16:
        thalf_x0 = 17723672;
        half_x03 = 23442693;
        break;
    case 17:
        thalf_x0 = 17719380;
        half_x03 = 23425668;
        break;
    case 18:
        thalf_x0 = 17715093;
        half_x03 = 23408669;
        break;
    case 19:
        thalf_x0 = 17710809;
        half_x03 = 23391691;
        break;
    case 20:
        thalf_x0 = 17706527;
        half_x03 = 23374727;
        break;
    case 21:
        thalf_x0 = 17702249;
        half_x03 = 23357788;
        break;
    case 22:
        thalf_x0 = 17697974;
        half_x03 = 23340870;
        break;
    case 23:
        thalf_x0 = 17693702;
        half_x03 = 23323972;
        break;
    case 24:
        thalf_x0 = 17689431;
        half_x03 = 23307088;
        break;
    case 25:
        thalf_x0 = 17685164;
        half_x03 = 23290224;
        break;
    case 26:
        thalf_x0 = 17680901;
        half_x03 = 23273385;
        break;
    case 27:
        thalf_x0 = 17676641;
        half_x03 = 23256567;
        break;
    case 28:
        thalf_x0 = 17672387;
        half_x03 = 23239781;
        break;
    case 29:
        thalf_x0 = 17668131;
        half_x03 = 23222996;
        break;
    case 30:
        thalf_x0 = 17663882;
        half_x03 = 23206244;
        break;
    case 31:
        thalf_x0 = 17659632;
        half_x03 = 23189499;
        break;
    case 32:
        thalf_x0 = 17655389;
        half_x03 = 23172786;
        break;
    case 33:
        thalf_x0 = 17651147;
        half_x03 = 23156087;
        break;
    case 34:
        thalf_x0 = 17646908;
        half_x03 = 23139408;
        break;
    case 35:
        thalf_x0 = 17642673;
        half_x03 = 23122755;
        break;
    case 36:
        thalf_x0 = 17638440;
        half_x03 = 23106115;
        break;
    case 37:
        thalf_x0 = 17634212;
        half_x03 = 23089502;
        break;
    case 38:
        thalf_x0 = 17629985;
        half_x03 = 23072901;
        break;
    case 39:
        thalf_x0 = 17625764;
        half_x03 = 23056333;
        break;
    case 40:
        thalf_x0 = 17621543;
        half_x03 = 23039773;
        break;
    case 41:
        thalf_x0 = 17617325;
        half_x03 = 23023232;
        break;
    case 42:
        thalf_x0 = 17613111;
        half_x03 = 23006716;
        break;
    case 43:
        thalf_x0 = 17608899;
        half_x03 = 22990215;
        break;
    case 44:
        thalf_x0 = 17604689;
        half_x03 = 22973727;
        break;
    case 45:
        thalf_x0 = 17600486;
        half_x03 = 22957276;
        break;
    case 46:
        thalf_x0 = 17596284;
        half_x03 = 22940840;
        break;
    case 47:
        thalf_x0 = 17592086;
        half_x03 = 22924422;
        break;
    case 48:
        thalf_x0 = 17587887;
        half_x03 = 22908013;
        break;
    case 49:
        thalf_x0 = 17583696;
        half_x03 = 22891641;
        break;
    case 50:
        thalf_x0 = 17579507;
        half_x03 = 22875282;
        break;
    case 51:
        thalf_x0 = 17575319;
        half_x03 = 22858937;
        break;
    case 52:
        thalf_x0 = 17571134;
        half_x03 = 22842612;
        break;
    case 53:
        thalf_x0 = 17566953;
        half_x03 = 22826312;
        break;
    case 54:
        thalf_x0 = 17562776;
        half_x03 = 22810031;
        break;
    case 55:
        thalf_x0 = 17558600;
        half_x03 = 22793764;
        break;
    case 56:
        thalf_x0 = 17554428;
        half_x03 = 22777522;
        break;
    case 57:
        thalf_x0 = 17550257;
        half_x03 = 22761288;
        break;
    case 58:
        thalf_x0 = 17546091;
        half_x03 = 22745084;
        break;
    case 59:
        thalf_x0 = 17541927;
        half_x03 = 22728895;
        break;
    case 60:
        thalf_x0 = 17537769;
        half_x03 = 22712736;
        break;
    case 61:
        thalf_x0 = 17533611;
        half_x03 = 22696585;
        break;
    case 62:
        thalf_x0 = 17529458;
        half_x03 = 22680459;
        break;
    case 63:
        thalf_x0 = 17525304;
        half_x03 = 22664341;
        break;
    case 64:
        thalf_x0 = 17521157;
        half_x03 = 22648254;
        break;
    case 65:
        thalf_x0 = 17517012;
        half_x03 = 22632186;
        break;
    case 66:
        thalf_x0 = 17512868;
        half_x03 = 22616126;
        break;
    case 67:
        thalf_x0 = 17508729;
        half_x03 = 22600096;
        break;
    case 68:
        thalf_x0 = 17504592;
        half_x03 = 22584080;
        break;
    case 69:
        thalf_x0 = 17500457;
        half_x03 = 22568077;
        break;
    case 70:
        thalf_x0 = 17496327;
        half_x03 = 22552105;
        break;
    case 71:
        thalf_x0 = 17492199;
        half_x03 = 22536146;
        break;
    case 72:
        thalf_x0 = 17488076;
        half_x03 = 22520212;
        break;
    case 73:
        thalf_x0 = 17483952;
        half_x03 = 22504286;
        break;
    case 74:
        thalf_x0 = 17479833;
        half_x03 = 22488385;
        break;
    case 75:
        thalf_x0 = 17475717;
        half_x03 = 22472502;
        break;
    case 76:
        thalf_x0 = 17471603;
        half_x03 = 22456633;
        break;
    case 77:
        thalf_x0 = 17467493;
        half_x03 = 22440789;
        break;
    case 78:
        thalf_x0 = 17463386;
        half_x03 = 22424963;
        break;
    case 79:
        thalf_x0 = 17459282;
        half_x03 = 22409157;
        break;
    case 80:
        thalf_x0 = 17455178;
        half_x03 = 22393358;
        break;
    case 81:
        thalf_x0 = 17451081;
        half_x03 = 22377596;
        break;
    case 82:
        thalf_x0 = 17446983;
        half_x03 = 22361835;
        break;
    case 83:
        thalf_x0 = 17442890;
        half_x03 = 22346098;
        break;
    case 84:
        thalf_x0 = 17438801;
        half_x03 = 22330387;
        break;
    case 85:
        thalf_x0 = 17434715;
        half_x03 = 22314694;
        break;
    case 86:
        thalf_x0 = 17430629;
        half_x03 = 22299009;
        break;
    case 87:
        thalf_x0 = 17426549;
        half_x03 = 22283354;
        break;
    case 88:
        thalf_x0 = 17422469;
        half_x03 = 22267706;
        break;
    case 89:
        thalf_x0 = 17418392;
        half_x03 = 22252078;
        break;
    case 90:
        thalf_x0 = 17414319;
        half_x03 = 22236473;
        break;
    case 91:
        thalf_x0 = 17410248;
        half_x03 = 22220882;
        break;
    case 92:
        thalf_x0 = 17406182;
        half_x03 = 22205315;
        break;
    case 93:
        thalf_x0 = 17402117;
        half_x03 = 22189762;
        break;
    case 94:
        thalf_x0 = 17398056;
        half_x03 = 22174232;
        break;
    case 95:
        thalf_x0 = 17393997;
        half_x03 = 22158716;
        break;
    case 96:
        thalf_x0 = 17389941;
        half_x03 = 22143219;
        break;
    case 97:
        thalf_x0 = 17385888;
        half_x03 = 22127740;
        break;
    case 98:
        thalf_x0 = 17381840;
        half_x03 = 22112285;
        break;
    case 99:
        thalf_x0 = 17377790;
        half_x03 = 22096832;
        break;
    case 100:
        thalf_x0 = 17373746;
        half_x03 = 22081409;
        break;
    case 101:
        thalf_x0 = 17369703;
        half_x03 = 22065999;
        break;
    case 102:
        thalf_x0 = 17365665;
        half_x03 = 22050613;
        break;
    case 103:
        thalf_x0 = 17361629;
        half_x03 = 22035241;
        break;
    case 104:
        thalf_x0 = 17357595;
        half_x03 = 22019886;
        break;
    case 105:
        thalf_x0 = 17353563;
        half_x03 = 22004545;
        break;
    case 106:
        thalf_x0 = 17349537;
        half_x03 = 21989233;
        break;
    case 107:
        thalf_x0 = 17345513;
        half_x03 = 21973935;
        break;
    case 108:
        thalf_x0 = 17341491;
        half_x03 = 21958654;
        break;
    case 109:
        thalf_x0 = 17337471;
        half_x03 = 21943387;
        break;
    case 110:
        thalf_x0 = 17333453;
        half_x03 = 21928132;
        break;
    case 111:
        thalf_x0 = 17329440;
        half_x03 = 21912908;
        break;
    case 112:
        thalf_x0 = 17325429;
        half_x03 = 21897695;
        break;
    case 113:
        thalf_x0 = 17321421;
        half_x03 = 21882502;
        break;
    case 114:
        thalf_x0 = 17317416;
        half_x03 = 21867327;
        break;
    case 115:
        thalf_x0 = 17313413;
        half_x03 = 21852164;
        break;
    case 116:
        thalf_x0 = 17309412;
        half_x03 = 21837020;
        break;
    case 117:
        thalf_x0 = 17305416;
        half_x03 = 21821900;
        break;
    case 118:
        thalf_x0 = 17301420;
        half_x03 = 21806786;
        break;
    case 119:
        thalf_x0 = 17297432;
        half_x03 = 21791708;
        break;
    case 120:
        thalf_x0 = 17293442;
        half_x03 = 21776632;
        break;
    case 121:
        thalf_x0 = 17289455;
        half_x03 = 21761573;
        break;
    case 122:
        thalf_x0 = 17285472;
        half_x03 = 21746539;
        break;
    case 123:
        thalf_x0 = 17281491;
        half_x03 = 21731517;
        break;
    case 124:
        thalf_x0 = 17277515;
        half_x03 = 21716519;
        break;
    case 125:
        thalf_x0 = 17273537;
        half_x03 = 21701523;
        break;
    case 126:
        thalf_x0 = 17269565;
        half_x03 = 21686556;
        break;
    case 127:
        thalf_x0 = 17265599;
        half_x03 = 21671618;
        break;
    case 128:
        thalf_x0 = 17261630;
        half_x03 = 21656676;
        break;
    case 129:
        thalf_x0 = 17257667;
        half_x03 = 21641763;
        break;
    case 130:
        thalf_x0 = 17253705;
        half_x03 = 21626863;
        break;
    case 131:
        thalf_x0 = 17249747;
        half_x03 = 21611981;
        break;
    case 132:
        thalf_x0 = 17245790;
        half_x03 = 21597111;
        break;
    case 133:
        thalf_x0 = 17241836;
        half_x03 = 21582260;
        break;
    case 134:
        thalf_x0 = 17237888;
        half_x03 = 21567437;
        break;
    case 135:
        thalf_x0 = 17233940;
        half_x03 = 21552622;
        break;
    case 136:
        thalf_x0 = 17229995;
        half_x03 = 21537825;
        break;
    case 137:
        thalf_x0 = 17226050;
        half_x03 = 21523034;
        break;
    case 138:
        thalf_x0 = 17222112;
        half_x03 = 21508278;
        break;
    case 139:
        thalf_x0 = 17218175;
        half_x03 = 21493529;
        break;
    case 140:
        thalf_x0 = 17214240;
        half_x03 = 21478798;
        break;
    case 141:
        thalf_x0 = 17210312;
        half_x03 = 21464097;
        break;
    case 142:
        thalf_x0 = 17206380;
        half_x03 = 21449390;
        break;
    case 143:
        thalf_x0 = 17202455;
        half_x03 = 21434713;
        break;
    case 144:
        thalf_x0 = 17198531;
        half_x03 = 21420048;
        break;
    case 145:
        thalf_x0 = 17194610;
        half_x03 = 21405401;
        break;
    case 146:
        thalf_x0 = 17190692;
        half_x03 = 21390772;
        break;
    case 147:
        thalf_x0 = 17186775;
        half_x03 = 21376155;
        break;
    case 148:
        thalf_x0 = 17182863;
        half_x03 = 21361562;
        break;
    case 149:
        thalf_x0 = 17178951;
        half_x03 = 21346975;
        break;
    case 150:
        thalf_x0 = 17175047;
        half_x03 = 21332423;
        break;
    case 151:
        thalf_x0 = 17171139;
        half_x03 = 21317866;
        break;
    case 152:
        thalf_x0 = 17167238;
        half_x03 = 21303339;
        break;
    case 153:
        thalf_x0 = 17163339;
        half_x03 = 21288828;
        break;
    case 154:
        thalf_x0 = 17159444;
        half_x03 = 21274336;
        break;
    case 155:
        thalf_x0 = 17155548;
        half_x03 = 21259851;
        break;
    case 156:
        thalf_x0 = 17151657;
        half_x03 = 21245388;
        break;
    case 157:
        thalf_x0 = 17147768;
        half_x03 = 21230938;
        break;
    case 158:
        thalf_x0 = 17143883;
        half_x03 = 21216511;
        break;
    case 159:
        thalf_x0 = 17139998;
        half_x03 = 21202090;
        break;
    case 160:
        thalf_x0 = 17136119;
        half_x03 = 21187699;
        break;
    case 161:
        thalf_x0 = 17132237;
        half_x03 = 21173303;
        break;
    case 162:
        thalf_x0 = 17128365;
        half_x03 = 21158952;
        break;
    case 163:
        thalf_x0 = 17124491;
        half_x03 = 21144596;
        break;
    case 164:
        thalf_x0 = 17120619;
        half_x03 = 21130258;
        break;
    case 165:
        thalf_x0 = 17116752;
        half_x03 = 21115944;
        break;
    case 166:
        thalf_x0 = 17112887;
        half_x03 = 21101641;
        break;
    case 167:
        thalf_x0 = 17109024;
        half_x03 = 21087356;
        break;
    case 168:
        thalf_x0 = 17105165;
        half_x03 = 21073088;
        break;
    case 169:
        thalf_x0 = 17101308;
        half_x03 = 21058838;
        break;
    case 170:
        thalf_x0 = 17097452;
        half_x03 = 21044595;
        break;
    case 171:
        thalf_x0 = 17093601;
        half_x03 = 21030379;
        break;
    case 172:
        thalf_x0 = 17089752;
        half_x03 = 21016176;
        break;
    case 173:
        thalf_x0 = 17085905;
        half_x03 = 21001985;
        break;
    case 174:
        thalf_x0 = 17082060;
        half_x03 = 20987811;
        break;
    case 175:
        thalf_x0 = 17078219;
        half_x03 = 20973655;
        break;
    case 176:
        thalf_x0 = 17074380;
        half_x03 = 20959516;
        break;
    case 177:
        thalf_x0 = 17070542;
        half_x03 = 20945383;
        break;
    case 178:
        thalf_x0 = 17066709;
        half_x03 = 20931279;
        break;
    case 179:
        thalf_x0 = 17062880;
        half_x03 = 20917193;
        break;
    case 180:
        thalf_x0 = 17059049;
        half_x03 = 20903107;
        break;
    case 181:
        thalf_x0 = 17055224;
        half_x03 = 20889049;
        break;
    case 182:
        thalf_x0 = 17051399;
        half_x03 = 20874998;
        break;
    case 183:
        thalf_x0 = 17047577;
        half_x03 = 20860964;
        break;
    case 184:
        thalf_x0 = 17043759;
        half_x03 = 20846952;
        break;
    case 185:
        thalf_x0 = 17039943;
        half_x03 = 20832953;
        break;
    case 186:
        thalf_x0 = 17036129;
        half_x03 = 20818965;
        break;
    case 187:
        thalf_x0 = 17032320;
        half_x03 = 20805006;
        break;
    case 188:
        thalf_x0 = 17028513;
        half_x03 = 20791058;
        break;
    case 189:
        thalf_x0 = 17024708;
        half_x03 = 20777122;
        break;
    case 190:
        thalf_x0 = 17020904;
        half_x03 = 20763198;
        break;
    case 191:
        thalf_x0 = 17017103;
        half_x03 = 20749291;
        break;
    case 192:
        thalf_x0 = 17013305;
        half_x03 = 20735401;
        break;
    case 193:
        thalf_x0 = 17009508;
        half_x03 = 20721523;
        break;
    case 194:
        thalf_x0 = 17005715;
        half_x03 = 20707662;
        break;
    case 195:
        thalf_x0 = 17001926;
        half_x03 = 20693824;
        break;
    case 196:
        thalf_x0 = 16998137;
        half_x03 = 20679992;
        break;
    case 197:
        thalf_x0 = 16994352;
        half_x03 = 20666182;
        break;
    case 198:
        thalf_x0 = 16990569;
        half_x03 = 20652384;
        break;
    case 199:
        thalf_x0 = 16986789;
        half_x03 = 20638603;
        break;
    case 200:
        thalf_x0 = 16983011;
        half_x03 = 20624834;
        break;
    case 201:
        thalf_x0 = 16979235;
        half_x03 = 20611081;
        break;
    case 202:
        thalf_x0 = 16975463;
        half_x03 = 20597346;
        break;
    case 203:
        thalf_x0 = 16971693;
        half_x03 = 20583628;
        break;
    case 204:
        thalf_x0 = 16967925;
        half_x03 = 20569921;
        break;
    case 205:
        thalf_x0 = 16964160;
        half_x03 = 20556232;
        break;
    case 206:
        thalf_x0 = 16960397;
        half_x03 = 20542553;
        break;
    case 207:
        thalf_x0 = 16956638;
        half_x03 = 20528898;
        break;
    case 208:
        thalf_x0 = 16952880;
        half_x03 = 20515253;
        break;
    case 209:
        thalf_x0 = 16949124;
        half_x03 = 20501621;
        break;
    case 210:
        thalf_x0 = 16945371;
        half_x03 = 20488005;
        break;
    case 211:
        thalf_x0 = 16941621;
        half_x03 = 20474406;
        break;
    case 212:
        thalf_x0 = 16937873;
        half_x03 = 20460818;
        break;
    case 213:
        thalf_x0 = 16934127;
        half_x03 = 20447248;
        break;
    case 214:
        thalf_x0 = 16930385;
        half_x03 = 20433694;
        break;
    case 215:
        thalf_x0 = 16926645;
        half_x03 = 20420157;
        break;
    case 216:
        thalf_x0 = 16922907;
        half_x03 = 20406632;
        break;
    case 217:
        thalf_x0 = 16919172;
        half_x03 = 20393123;
        break;
    case 218:
        thalf_x0 = 16915439;
        half_x03 = 20379626;
        break;
    case 219:
        thalf_x0 = 16911708;
        half_x03 = 20366145;
        break;
    case 220:
        thalf_x0 = 16907981;
        half_x03 = 20352681;
        break;
    case 221:
        thalf_x0 = 16904256;
        half_x03 = 20339234;
        break;
    case 222:
        thalf_x0 = 16900532;
        half_x03 = 20325794;
        break;
    case 223:
        thalf_x0 = 16896812;
        half_x03 = 20312375;
        break;
    case 224:
        thalf_x0 = 16893095;
        half_x03 = 20298973;
        break;
    case 225:
        thalf_x0 = 16889378;
        half_x03 = 20285576;
        break;
    case 226:
        thalf_x0 = 16885665;
        half_x03 = 20272202;
        break;
    case 227:
        thalf_x0 = 16881956;
        half_x03 = 20258845;
        break;
    case 228:
        thalf_x0 = 16878248;
        half_x03 = 20245499;
        break;
    case 229:
        thalf_x0 = 16874540;
        half_x03 = 20232158;
        break;
    case 230:
        thalf_x0 = 16870836;
        half_x03 = 20218840;
        break;
    case 231:
        thalf_x0 = 16867136;
        half_x03 = 20205538;
        break;
    case 232:
        thalf_x0 = 16863437;
        half_x03 = 20192248;
        break;
    case 233:
        thalf_x0 = 16859741;
        half_x03 = 20178974;
        break;
    case 234:
        thalf_x0 = 16856048;
        half_x03 = 20165717;
        break;
    case 235:
        thalf_x0 = 16852356;
        half_x03 = 20152470;
        break;
    case 236:
        thalf_x0 = 16848668;
        half_x03 = 20139241;
        break;
    case 237:
        thalf_x0 = 16844981;
        half_x03 = 20126023;
        break;
    case 238:
        thalf_x0 = 16841297;
        half_x03 = 20112821;
        break;
    case 239:
        thalf_x0 = 16837617;
        half_x03 = 20099641;
        break;
    case 240:
        thalf_x0 = 16833936;
        half_x03 = 20086462;
        break;
    case 241:
        thalf_x0 = 16830261;
        half_x03 = 20073309;
        break;
    case 242:
        thalf_x0 = 16826585;
        half_x03 = 20060157;
        break;
    case 243:
        thalf_x0 = 16822913;
        half_x03 = 20047027;
        break;
    case 244:
        thalf_x0 = 16819244;
        half_x03 = 20033914;
        break;
    case 245:
        thalf_x0 = 16815576;
        half_x03 = 20020811;
        break;
    case 246:
        thalf_x0 = 16811912;
        half_x03 = 20007725;
        break;
    case 247:
        thalf_x0 = 16808249;
        half_x03 = 19994650;
        break;
    case 248:
        thalf_x0 = 16804589;
        half_x03 = 19981591;
        break;
    case 249:
        thalf_x0 = 16800932;
        half_x03 = 19968549;
        break;
    case 250:
        thalf_x0 = 16797276;
        half_x03 = 19955518;
        break;
    case 251:
        thalf_x0 = 16793625;
        half_x03 = 19942508;
        break;
    case 252:
        thalf_x0 = 16789973;
        half_x03 = 19929499;
        break;
    case 253:
        thalf_x0 = 16786328;
        half_x03 = 19916522;
        break;
    case 254:
        thalf_x0 = 16782681;
        half_x03 = 19903545;
        break;
    case 255:
        thalf_x0 = 16779036;
        half_x03 = 19890580;
        break;
    case 256:
        thalf_x0 = 16775396;
        half_x03 = 19877636;
        break;
    case 257:
        thalf_x0 = 16771757;
        half_x03 = 19864703;
        break;
    case 258:
        thalf_x0 = 16768121;
        half_x03 = 19851786;
        break;
    case 259:
        thalf_x0 = 16764489;
        half_x03 = 19838891;
        break;
    case 260:
        thalf_x0 = 16760856;
        half_x03 = 19825996;
        break;
    case 261:
        thalf_x0 = 16757228;
        half_x03 = 19813122;
        break;
    case 262:
        thalf_x0 = 16753601;
        half_x03 = 19800260;
        break;
    case 263:
        thalf_x0 = 16749975;
        half_x03 = 19787408;
        break;
    case 264:
        thalf_x0 = 16746353;
        half_x03 = 19774573;
        break;
    case 265:
        thalf_x0 = 16742735;
        half_x03 = 19761759;
        break;
    case 266:
        thalf_x0 = 16739115;
        half_x03 = 19748945;
        break;
    case 267:
        thalf_x0 = 16735502;
        half_x03 = 19736158;
        break;
    case 268:
        thalf_x0 = 16731890;
        half_x03 = 19723382;
        break;
    case 269:
        thalf_x0 = 16728278;
        half_x03 = 19710611;
        break;
    case 270:
        thalf_x0 = 16724672;
        half_x03 = 19697867;
        break;
    case 271:
        thalf_x0 = 16721066;
        half_x03 = 19685129;
        break;
    case 272:
        thalf_x0 = 16717463;
        half_x03 = 19672407;
        break;
    case 273:
        thalf_x0 = 16713863;
        half_x03 = 19659700;
        break;
    case 274:
        thalf_x0 = 16710263;
        half_x03 = 19647000;
        break;
    case 275:
        thalf_x0 = 16706666;
        half_x03 = 19634315;
        break;
    case 276:
        thalf_x0 = 16703073;
        half_x03 = 19621651;
        break;
    case 277:
        thalf_x0 = 16699481;
        half_x03 = 19608993;
        break;
    case 278:
        thalf_x0 = 16695891;
        half_x03 = 19596352;
        break;
    case 279:
        thalf_x0 = 16692303;
        half_x03 = 19583720;
        break;
    case 280:
        thalf_x0 = 16688721;
        half_x03 = 19571116;
        break;
    case 281:
        thalf_x0 = 16685138;
        half_x03 = 19558511;
        break;
    case 282:
        thalf_x0 = 16681557;
        half_x03 = 19545923;
        break;
    case 283:
        thalf_x0 = 16677980;
        half_x03 = 19533350;
        break;
    case 284:
        thalf_x0 = 16674404;
        half_x03 = 19520788;
        break;
    case 285:
        thalf_x0 = 16670831;
        half_x03 = 19508242;
        break;
    case 286:
        thalf_x0 = 16667259;
        half_x03 = 19495706;
        break;
    case 287:
        thalf_x0 = 16663691;
        half_x03 = 19483187;
        break;
    case 288:
        thalf_x0 = 16660125;
        half_x03 = 19470683;
        break;
    case 289:
        thalf_x0 = 16656561;
        half_x03 = 19458190;
        break;
    case 290:
        thalf_x0 = 16652999;
        half_x03 = 19445708;
        break;
    case 291:
        thalf_x0 = 16649439;
        half_x03 = 19433241;
        break;
    case 292:
        thalf_x0 = 16645883;
        half_x03 = 19420790;
        break;
    case 293:
        thalf_x0 = 16642328;
        half_x03 = 19408350;
        break;
    case 294:
        thalf_x0 = 16638776;
        half_x03 = 19395926;
        break;
    case 295:
        thalf_x0 = 16635224;
        half_x03 = 19383506;
        break;
    case 296:
        thalf_x0 = 16631676;
        half_x03 = 19371108;
        break;
    case 297:
        thalf_x0 = 16628129;
        half_x03 = 19358715;
        break;
    case 298:
        thalf_x0 = 16624587;
        half_x03 = 19346349;
        break;
    case 299:
        thalf_x0 = 16621044;
        half_x03 = 19333982;
        break;
    case 300:
        thalf_x0 = 16617507;
        half_x03 = 19321642;
        break;
    case 301:
        thalf_x0 = 16613969;
        half_x03 = 19309302;
        break;
    case 302:
        thalf_x0 = 16610436;
        half_x03 = 19296988;
        break;
    case 303:
        thalf_x0 = 16606904;
        half_x03 = 19284679;
        break;
    case 304:
        thalf_x0 = 16603373;
        half_x03 = 19272380;
        break;
    case 305:
        thalf_x0 = 16599845;
        half_x03 = 19260097;
        break;
    case 306:
        thalf_x0 = 16596320;
        half_x03 = 19247830;
        break;
    case 307:
        thalf_x0 = 16592796;
        half_x03 = 19235574;
        break;
    case 308:
        thalf_x0 = 16589277;
        half_x03 = 19223338;
        break;
    case 309:
        thalf_x0 = 16585755;
        half_x03 = 19211097;
        break;
    case 310:
        thalf_x0 = 16582239;
        half_x03 = 19198882;
        break;
    case 311:
        thalf_x0 = 16578728;
        half_x03 = 19186687;
        break;
    case 312:
        thalf_x0 = 16575213;
        half_x03 = 19174488;
        break;
    case 313:
        thalf_x0 = 16571703;
        half_x03 = 19162309;
        break;
    case 314:
        thalf_x0 = 16568196;
        half_x03 = 19150146;
        break;
    case 315:
        thalf_x0 = 16564691;
        half_x03 = 19137993;
        break;
    case 316:
        thalf_x0 = 16561188;
        half_x03 = 19125856;
        break;
    case 317:
        thalf_x0 = 16557687;
        half_x03 = 19113729;
        break;
    case 318:
        thalf_x0 = 16554188;
        half_x03 = 19101612;
        break;
    case 319:
        thalf_x0 = 16550691;
        half_x03 = 19089511;
        break;
    case 320:
        thalf_x0 = 16547196;
        half_x03 = 19077421;
        break;
    case 321:
        thalf_x0 = 16543706;
        half_x03 = 19065350;
        break;
    case 322:
        thalf_x0 = 16540215;
        half_x03 = 19053285;
        break;
    case 323:
        thalf_x0 = 16536729;
        half_x03 = 19041241;
        break;
    case 324:
        thalf_x0 = 16533242;
        half_x03 = 19029196;
        break;
    case 325:
        thalf_x0 = 16529760;
        half_x03 = 19017178;
        break;
    case 326:
        thalf_x0 = 16526279;
        half_x03 = 19005164;
        break;
    case 327:
        thalf_x0 = 16522799;
        half_x03 = 18993161;
        break;
    case 328:
        thalf_x0 = 16519323;
        half_x03 = 18981178;
        break;
    case 329:
        thalf_x0 = 16515849;
        half_x03 = 18969205;
        break;
    case 330:
        thalf_x0 = 16512375;
        half_x03 = 18957237;
        break;
    case 331:
        thalf_x0 = 16508906;
        half_x03 = 18945290;
        break;
    case 332:
        thalf_x0 = 16505438;
        half_x03 = 18933353;
        break;
    case 333:
        thalf_x0 = 16501971;
        half_x03 = 18921427;
        break;
    case 334:
        thalf_x0 = 16498509;
        half_x03 = 18909520;
        break;
    case 335:
        thalf_x0 = 16495046;
        half_x03 = 18897614;
        break;
    case 336:
        thalf_x0 = 16491588;
        half_x03 = 18885733;
        break;
    case 337:
        thalf_x0 = 16488131;
        half_x03 = 18873857;
        break;
    case 338:
        thalf_x0 = 16484676;
        half_x03 = 18861997;
        break;
    case 339:
        thalf_x0 = 16481223;
        half_x03 = 18850146;
        break;
    case 340:
        thalf_x0 = 16477773;
        half_x03 = 18838311;
        break;
    case 341:
        thalf_x0 = 16474325;
        half_x03 = 18826486;
        break;
    case 342:
        thalf_x0 = 16470879;
        half_x03 = 18814676;
        break;
    case 343:
        thalf_x0 = 16467435;
        half_x03 = 18802876;
        break;
    case 344:
        thalf_x0 = 16463991;
        half_x03 = 18791082;
        break;
    case 345:
        thalf_x0 = 16460553;
        half_x03 = 18779312;
        break;
    case 346:
        thalf_x0 = 16457115;
        half_x03 = 18767548;
        break;
    case 347:
        thalf_x0 = 16453680;
        half_x03 = 18755799;
        break;
    case 348:
        thalf_x0 = 16450247;
        half_x03 = 18744059;
        break;
    case 349:
        thalf_x0 = 16446815;
        half_x03 = 18732330;
        break;
    case 350:
        thalf_x0 = 16443387;
        half_x03 = 18720621;
        break;
    case 351:
        thalf_x0 = 16439961;
        half_x03 = 18708922;
        break;
    case 352:
        thalf_x0 = 16436535;
        half_x03 = 18697228;
        break;
    case 353:
        thalf_x0 = 16433114;
        half_x03 = 18685554;
        break;
    case 354:
        thalf_x0 = 16429694;
        half_x03 = 18673890;
        break;
    case 355:
        thalf_x0 = 16426274;
        half_x03 = 18662231;
        break;
    case 356:
        thalf_x0 = 16422860;
        half_x03 = 18650598;
        break;
    case 357:
        thalf_x0 = 16419444;
        half_x03 = 18638964;
        break;
    case 358:
        thalf_x0 = 16416033;
        half_x03 = 18627350;
        break;
    case 359:
        thalf_x0 = 16412624;
        half_x03 = 18615746;
        break;
    case 360:
        thalf_x0 = 16409216;
        half_x03 = 18604152;
        break;
    case 361:
        thalf_x0 = 16405811;
        half_x03 = 18592573;
        break;
    case 362:
        thalf_x0 = 16402407;
        half_x03 = 18581004;
        break;
    case 363:
        thalf_x0 = 16399007;
        half_x03 = 18569450;
        break;
    case 364:
        thalf_x0 = 16395605;
        half_x03 = 18557895;
        break;
    case 365:
        thalf_x0 = 16392209;
        half_x03 = 18546366;
        break;
    case 366:
        thalf_x0 = 16388813;
        half_x03 = 18534842;
        break;
    case 367:
        thalf_x0 = 16385421;
        half_x03 = 18523337;
        break;
    case 368:
        thalf_x0 = 16382030;
        half_x03 = 18511838;
        break;
    case 369:
        thalf_x0 = 16378643;
        half_x03 = 18500358;
        break;
    case 370:
        thalf_x0 = 16375257;
        half_x03 = 18488888;
        break;
    case 371:
        thalf_x0 = 16371872;
        half_x03 = 18477423;
        break;
    case 372:
        thalf_x0 = 16368489;
        half_x03 = 18465973;
        break;
    case 373:
        thalf_x0 = 16365108;
        half_x03 = 18454533;
        break;
    case 374:
        thalf_x0 = 16361732;
        half_x03 = 18443112;
        break;
    case 375:
        thalf_x0 = 16358355;
        half_x03 = 18431696;
        break;
    case 376:
        thalf_x0 = 16354982;
        half_x03 = 18420295;
        break;
    case 377:
        thalf_x0 = 16351610;
        half_x03 = 18408904;
        break;
    case 378:
        thalf_x0 = 16348239;
        half_x03 = 18397523;
        break;
    case 379:
        thalf_x0 = 16344872;
        half_x03 = 18386157;
        break;
    case 380:
        thalf_x0 = 16341506;
        half_x03 = 18374800;
        break;
    case 381:
        thalf_x0 = 16338144;
        half_x03 = 18363463;
        break;
    case 382:
        thalf_x0 = 16334783;
        half_x03 = 18352131;
        break;
    case 383:
        thalf_x0 = 16331423;
        half_x03 = 18340808;
        break;
    case 384:
        thalf_x0 = 16328064;
        half_x03 = 18329495;
        break;
    case 385:
        thalf_x0 = 16324709;
        half_x03 = 18318197;
        break;
    case 386:
        thalf_x0 = 16321356;
        half_x03 = 18306914;
        break;
    case 387:
        thalf_x0 = 16318007;
        half_x03 = 18295645;
        break;
    case 388:
        thalf_x0 = 16314657;
        half_x03 = 18284381;
        break;
    case 389:
        thalf_x0 = 16311309;
        half_x03 = 18273127;
        break;
    case 390:
        thalf_x0 = 16307964;
        half_x03 = 18261887;
        break;
    case 391:
        thalf_x0 = 16304621;
        half_x03 = 18250657;
        break;
    case 392:
        thalf_x0 = 16301282;
        half_x03 = 18239447;
        break;
    case 393:
        thalf_x0 = 16297943;
        half_x03 = 18228241;
        break;
    case 394:
        thalf_x0 = 16294607;
        half_x03 = 18217050;
        break;
    case 395:
        thalf_x0 = 16291271;
        half_x03 = 18205864;
        break;
    case 396:
        thalf_x0 = 16287939;
        half_x03 = 18194697;
        break;
    case 397:
        thalf_x0 = 16284609;
        half_x03 = 18183540;
        break;
    case 398:
        thalf_x0 = 16281279;
        half_x03 = 18172387;
        break;
    case 399:
        thalf_x0 = 16277954;
        half_x03 = 18161254;
        break;
    case 400:
        thalf_x0 = 16274630;
        half_x03 = 18150131;
        break;
    case 401:
        thalf_x0 = 16271306;
        half_x03 = 18139012;
        break;
    case 402:
        thalf_x0 = 16267988;
        half_x03 = 18127917;
        break;
    case 403:
        thalf_x0 = 16264668;
        half_x03 = 18116822;
        break;
    case 404:
        thalf_x0 = 16261352;
        half_x03 = 18105742;
        break;
    case 405:
        thalf_x0 = 16258037;
        half_x03 = 18094671;
        break;
    case 406:
        thalf_x0 = 16254725;
        half_x03 = 18083615;
        break;
    case 407:
        thalf_x0 = 16251416;
        half_x03 = 18072574;
        break;
    case 408:
        thalf_x0 = 16248107;
        half_x03 = 18061536;
        break;
    case 409:
        thalf_x0 = 16244801;
        half_x03 = 18050514;
        break;
    case 410:
        thalf_x0 = 16241496;
        half_x03 = 18039500;
        break;
    case 411:
        thalf_x0 = 16238195;
        half_x03 = 18028502;
        break;
    case 412:
        thalf_x0 = 16234895;
        half_x03 = 18017513;
        break;
    case 413:
        thalf_x0 = 16231596;
        half_x03 = 18006533;
        break;
    case 414:
        thalf_x0 = 16228299;
        half_x03 = 17995562;
        break;
    case 415:
        thalf_x0 = 16225005;
        half_x03 = 17984606;
        break;
    case 416:
        thalf_x0 = 16221713;
        half_x03 = 17973660;
        break;
    case 417:
        thalf_x0 = 16218423;
        half_x03 = 17962728;
        break;
    case 418:
        thalf_x0 = 16215135;
        half_x03 = 17951805;
        break;
    case 419:
        thalf_x0 = 16211849;
        half_x03 = 17940892;
        break;
    case 420:
        thalf_x0 = 16208567;
        half_x03 = 17929998;
        break;
    case 421:
        thalf_x0 = 16205283;
        half_x03 = 17919104;
        break;
    case 422:
        thalf_x0 = 16202003;
        half_x03 = 17908224;
        break;
    case 423:
        thalf_x0 = 16198725;
        half_x03 = 17897358;
        break;
    case 424:
        thalf_x0 = 16195449;
        half_x03 = 17886501;
        break;
    case 425:
        thalf_x0 = 16192175;
        half_x03 = 17875654;
        break;
    case 426:
        thalf_x0 = 16188902;
        half_x03 = 17864817;
        break;
    case 427:
        thalf_x0 = 16185633;
        half_x03 = 17853998;
        break;
    case 428:
        thalf_x0 = 16182365;
        half_x03 = 17843184;
        break;
    case 429:
        thalf_x0 = 16179098;
        half_x03 = 17832379;
        break;
    case 430:
        thalf_x0 = 16175834;
        half_x03 = 17821589;
        break;
    case 431:
        thalf_x0 = 16172571;
        half_x03 = 17810808;
        break;
    case 432:
        thalf_x0 = 16169312;
        half_x03 = 17800041;
        break;
    case 433:
        thalf_x0 = 16166052;
        half_x03 = 17789278;
        break;
    case 434:
        thalf_x0 = 16162797;
        half_x03 = 17778535;
        break;
    case 435:
        thalf_x0 = 16159541;
        half_x03 = 17767791;
        break;
    case 436:
        thalf_x0 = 16156289;
        half_x03 = 17757067;
        break;
    case 437:
        thalf_x0 = 16153041;
        half_x03 = 17746361;
        break;
    case 438:
        thalf_x0 = 16149791;
        half_x03 = 17735650;
        break;
    case 439:
        thalf_x0 = 16146543;
        half_x03 = 17724953;
        break;
    case 440:
        thalf_x0 = 16143300;
        half_x03 = 17714275;
        break;
    case 441:
        thalf_x0 = 16140057;
        half_x03 = 17703601;
        break;
    case 442:
        thalf_x0 = 16136817;
        half_x03 = 17692941;
        break;
    case 443:
        thalf_x0 = 16133579;
        half_x03 = 17682291;
        break;
    case 444:
        thalf_x0 = 16130340;
        half_x03 = 17671645;
        break;
    case 445:
        thalf_x0 = 16127108;
        half_x03 = 17661023;
        break;
    case 446:
        thalf_x0 = 16123874;
        half_x03 = 17650401;
        break;
    case 447:
        thalf_x0 = 16120643;
        half_x03 = 17639792;
        break;
    case 448:
        thalf_x0 = 16117413;
        half_x03 = 17629193;
        break;
    case 449:
        thalf_x0 = 16114187;
        half_x03 = 17618607;
        break;
    case 450:
        thalf_x0 = 16110962;
        half_x03 = 17608031;
        break;
    case 451:
        thalf_x0 = 16107740;
        half_x03 = 17597469;
        break;
    case 452:
        thalf_x0 = 16104518;
        half_x03 = 17586911;
        break;
    case 453:
        thalf_x0 = 16101299;
        half_x03 = 17576367;
        break;
    case 454:
        thalf_x0 = 16098081;
        half_x03 = 17565833;
        break;
    case 455:
        thalf_x0 = 16094867;
        half_x03 = 17555312;
        break;
    case 456:
        thalf_x0 = 16091652;
        half_x03 = 17544796;
        break;
    case 457:
        thalf_x0 = 16088439;
        half_x03 = 17534288;
        break;
    case 458:
        thalf_x0 = 16085231;
        half_x03 = 17523800;
        break;
    case 459:
        thalf_x0 = 16082021;
        half_x03 = 17513311;
        break;
    case 460:
        thalf_x0 = 16078817;
        half_x03 = 17502845;
        break;
    case 461:
        thalf_x0 = 16075611;
        half_x03 = 17492379;
        break;
    case 462:
        thalf_x0 = 16072412;
        half_x03 = 17481937;
        break;
    case 463:
        thalf_x0 = 16069211;
        half_x03 = 17471494;
        break;
    case 464:
        thalf_x0 = 16066013;
        half_x03 = 17461065;
        break;
    case 465:
        thalf_x0 = 16062816;
        half_x03 = 17450645;
        break;
    case 466:
        thalf_x0 = 16059623;
        half_x03 = 17440238;
        break;
    case 467:
        thalf_x0 = 16056431;
        half_x03 = 17429841;
        break;
    case 468:
        thalf_x0 = 16053239;
        half_x03 = 17419448;
        break;
    case 469:
        thalf_x0 = 16050051;
        half_x03 = 17409074;
        break;
    case 470:
        thalf_x0 = 16046865;
        half_x03 = 17398709;
        break;
    case 471:
        thalf_x0 = 16043679;
        half_x03 = 17388348;
        break;
    case 472:
        thalf_x0 = 16040496;
        half_x03 = 17378000;
        break;
    case 473:
        thalf_x0 = 16037316;
        half_x03 = 17367667;
        break;
    case 474:
        thalf_x0 = 16034136;
        half_x03 = 17357338;
        break;
    case 475:
        thalf_x0 = 16030958;
        half_x03 = 17347017;
        break;
    case 476:
        thalf_x0 = 16027784;
        half_x03 = 17336716;
        break;
    case 477:
        thalf_x0 = 16024610;
        half_x03 = 17326418;
        break;
    case 478:
        thalf_x0 = 16021439;
        half_x03 = 17316134;
        break;
    case 479:
        thalf_x0 = 16018269;
        half_x03 = 17305859;
        break;
    case 480:
        thalf_x0 = 16015100;
        half_x03 = 17295589;
        break;
    case 481:
        thalf_x0 = 16011935;
        half_x03 = 17285336;
        break;
    case 482:
        thalf_x0 = 16008770;
        half_x03 = 17275088;
        break;
    case 483:
        thalf_x0 = 16005608;
        half_x03 = 17264854;
        break;
    case 484:
        thalf_x0 = 16002447;
        half_x03 = 17254628;
        break;
    case 485:
        thalf_x0 = 15999288;
        half_x03 = 17244412;
        break;
    case 486:
        thalf_x0 = 15996132;
        half_x03 = 17234209;
        break;
    case 487:
        thalf_x0 = 15992978;
        half_x03 = 17224015;
        break;
    case 488:
        thalf_x0 = 15989823;
        half_x03 = 17213825;
        break;
    case 489:
        thalf_x0 = 15986673;
        half_x03 = 17203654;
        break;
    case 490:
        thalf_x0 = 15983525;
        half_x03 = 17193491;
        break;
    case 491:
        thalf_x0 = 15980378;
        half_x03 = 17183338;
        break;
    case 492:
        thalf_x0 = 15977232;
        half_x03 = 17173193;
        break;
    case 493:
        thalf_x0 = 15974088;
        half_x03 = 17163057;
        break;
    case 494:
        thalf_x0 = 15970947;
        half_x03 = 17152934;
        break;
    case 495:
        thalf_x0 = 15967808;
        half_x03 = 17142821;
        break;
    case 496:
        thalf_x0 = 15964670;
        half_x03 = 17132716;
        break;
    case 497:
        thalf_x0 = 15961533;
        half_x03 = 17122620;
        break;
    case 498:
        thalf_x0 = 15958400;
        half_x03 = 17112538;
        break;
    case 499:
        thalf_x0 = 15955265;
        half_x03 = 17102455;
        break;
    case 500:
        thalf_x0 = 15952136;
        half_x03 = 17092395;
        break;
    case 501:
        thalf_x0 = 15949007;
        half_x03 = 17082339;
        break;
    case 502:
        thalf_x0 = 15945879;
        half_x03 = 17072291;
        break;
    case 503:
        thalf_x0 = 15942756;
        half_x03 = 17062262;
        break;
    case 504:
        thalf_x0 = 15939632;
        half_x03 = 17052233;
        break;
    case 505:
        thalf_x0 = 15936509;
        half_x03 = 17042212;
        break;
    case 506:
        thalf_x0 = 15933392;
        half_x03 = 17032214;
        break;
    case 507:
        thalf_x0 = 15930272;
        half_x03 = 17022210;
        break;
    case 508:
        thalf_x0 = 15927156;
        half_x03 = 17012225;
        break;
    case 509:
        thalf_x0 = 15924041;
        half_x03 = 17002244;
        break;
    case 510:
        thalf_x0 = 15920930;
        half_x03 = 16992281;
        break;
    case 511:
        thalf_x0 = 15917819;
        half_x03 = 16982322;
        break;
    case 512:
        thalf_x0 = 15914711;
        half_x03 = 16972376;
        break;
    case 513:
        thalf_x0 = 15911604;
        half_x03 = 16962439;
        break;
    case 514:
        thalf_x0 = 15908499;
        half_x03 = 16952511;
        break;
    case 515:
        thalf_x0 = 15905397;
        half_x03 = 16942596;
        break;
    case 516:
        thalf_x0 = 15902294;
        half_x03 = 16932681;
        break;
    case 517:
        thalf_x0 = 15899196;
        half_x03 = 16922788;
        break;
    case 518:
        thalf_x0 = 15896097;
        half_x03 = 16912894;
        break;
    case 519:
        thalf_x0 = 15893003;
        half_x03 = 16903019;
        break;
    case 520:
        thalf_x0 = 15889907;
        half_x03 = 16893143;
        break;
    case 521:
        thalf_x0 = 15886815;
        half_x03 = 16883284;
        break;
    case 522:
        thalf_x0 = 15883725;
        half_x03 = 16873435;
        break;
    case 523:
        thalf_x0 = 15880635;
        half_x03 = 16863589;
        break;
    case 524:
        thalf_x0 = 15877548;
        half_x03 = 16853757;
        break;
    case 525:
        thalf_x0 = 15874464;
        half_x03 = 16843938;
        break;
    case 526:
        thalf_x0 = 15871380;
        half_x03 = 16834123;
        break;
    case 527:
        thalf_x0 = 15868298;
        half_x03 = 16824316;
        break;
    case 528:
        thalf_x0 = 15865220;
        half_x03 = 16814528;
        break;
    case 529:
        thalf_x0 = 15862140;
        half_x03 = 16804738;
        break;
    case 530:
        thalf_x0 = 15859065;
        half_x03 = 16794967;
        break;
    case 531:
        thalf_x0 = 15855992;
        half_x03 = 16785204;
        break;
    case 532:
        thalf_x0 = 15852917;
        half_x03 = 16775441;
        break;
    case 533:
        thalf_x0 = 15849848;
        half_x03 = 16765700;
        break;
    case 534:
        thalf_x0 = 15846779;
        half_x03 = 16755963;
        break;
    case 535:
        thalf_x0 = 15843711;
        half_x03 = 16746234;
        break;
    case 536:
        thalf_x0 = 15840647;
        half_x03 = 16736519;
        break;
    case 537:
        thalf_x0 = 15837581;
        half_x03 = 16726802;
        break;
    case 538:
        thalf_x0 = 15834519;
        half_x03 = 16717104;
        break;
    case 539:
        thalf_x0 = 15831459;
        half_x03 = 16707414;
        break;
    case 540:
        thalf_x0 = 15828401;
        half_x03 = 16697733;
        break;
    case 541:
        thalf_x0 = 15825345;
        half_x03 = 16688065;
        break;
    case 542:
        thalf_x0 = 15822290;
        half_x03 = 16678401;
        break;
    case 543:
        thalf_x0 = 15819237;
        half_x03 = 16668749;
        break;
    case 544:
        thalf_x0 = 15816185;
        half_x03 = 16659102;
        break;
    case 545:
        thalf_x0 = 15813137;
        half_x03 = 16649473;
        break;
    case 546:
        thalf_x0 = 15810089;
        half_x03 = 16639847;
        break;
    case 547:
        thalf_x0 = 15807044;
        half_x03 = 16630234;
        break;
    case 548:
        thalf_x0 = 15803999;
        half_x03 = 16620625;
        break;
    case 549:
        thalf_x0 = 15800955;
        half_x03 = 16611025;
        break;
    case 550:
        thalf_x0 = 15797915;
        half_x03 = 16601438;
        break;
    case 551:
        thalf_x0 = 15794877;
        half_x03 = 16591863;
        break;
    case 552:
        thalf_x0 = 15791840;
        half_x03 = 16582293;
        break;
    case 553:
        thalf_x0 = 15788804;
        half_x03 = 16572731;
        break;
    case 554:
        thalf_x0 = 15785771;
        half_x03 = 16563182;
        break;
    case 555:
        thalf_x0 = 15782738;
        half_x03 = 16553637;
        break;
    case 556:
        thalf_x0 = 15779708;
        half_x03 = 16544105;
        break;
    case 557:
        thalf_x0 = 15776679;
        half_x03 = 16534581;
        break;
    case 558:
        thalf_x0 = 15773652;
        half_x03 = 16525065;
        break;
    case 559:
        thalf_x0 = 15770628;
        half_x03 = 16515563;
        break;
    case 560:
        thalf_x0 = 15767604;
        half_x03 = 16506064;
        break;
    case 561:
        thalf_x0 = 15764583;
        half_x03 = 16496579;
        break;
    case 562:
        thalf_x0 = 15761564;
        half_x03 = 16487101;
        break;
    case 563:
        thalf_x0 = 15758544;
        half_x03 = 16477628;
        break;
    case 564:
        thalf_x0 = 15755531;
        half_x03 = 16468176;
        break;
    case 565:
        thalf_x0 = 15752513;
        half_x03 = 16458715;
        break;
    case 566:
        thalf_x0 = 15749501;
        half_x03 = 16449275;
        break;
    case 567:
        thalf_x0 = 15746492;
        half_x03 = 16439849;
        break;
    case 568:
        thalf_x0 = 15743481;
        half_x03 = 16430422;
        break;
    case 569:
        thalf_x0 = 15740474;
        half_x03 = 16421007;
        break;
    case 570:
        thalf_x0 = 15737469;
        half_x03 = 16411606;
        break;
    case 571:
        thalf_x0 = 15734463;
        half_x03 = 16402204;
        break;
    case 572:
        thalf_x0 = 15731462;
        half_x03 = 16392819;
        break;
    case 573:
        thalf_x0 = 15728460;
        half_x03 = 16383438;
        break;
    case 574:
        thalf_x0 = 15725460;
        half_x03 = 16374064;
        break;
    case 575:
        thalf_x0 = 15722463;
        half_x03 = 16364704;
        break;
    case 576:
        thalf_x0 = 15719469;
        half_x03 = 16355357;
        break;
    case 577:
        thalf_x0 = 15716474;
        half_x03 = 16346009;
        break;
    case 578:
        thalf_x0 = 15713483;
        half_x03 = 16336678;
        break;
    case 579:
        thalf_x0 = 15710493;
        half_x03 = 16327356;
        break;
    case 580:
        thalf_x0 = 15707504;
        half_x03 = 16318037;
        break;
    case 581:
        thalf_x0 = 15704516;
        half_x03 = 16308726;
        break;
    case 582:
        thalf_x0 = 15701531;
        half_x03 = 16299429;
        break;
    case 583:
        thalf_x0 = 15698546;
        half_x03 = 16290134;
        break;
    case 584:
        thalf_x0 = 15695565;
        half_x03 = 16280858;
        break;
    case 585:
        thalf_x0 = 15692585;
        half_x03 = 16271585;
        break;
    case 586:
        thalf_x0 = 15689606;
        half_x03 = 16262320;
        break;
    case 587:
        thalf_x0 = 15686630;
        half_x03 = 16253068;
        break;
    case 588:
        thalf_x0 = 15683654;
        half_x03 = 16243819;
        break;
    case 589:
        thalf_x0 = 15680679;
        half_x03 = 16234578;
        break;
    case 590:
        thalf_x0 = 15677709;
        half_x03 = 16225355;
        break;
    case 591:
        thalf_x0 = 15674739;
        half_x03 = 16216136;
        break;
    case 592:
        thalf_x0 = 15671771;
        half_x03 = 16206924;
        break;
    case 593:
        thalf_x0 = 15668804;
        half_x03 = 16197721;
        break;
    case 594:
        thalf_x0 = 15665840;
        half_x03 = 16188531;
        break;
    case 595:
        thalf_x0 = 15662876;
        half_x03 = 16179344;
        break;
    case 596:
        thalf_x0 = 15659913;
        half_x03 = 16170165;
        break;
    case 597:
        thalf_x0 = 15656954;
        half_x03 = 16160999;
        break;
    case 598:
        thalf_x0 = 15653996;
        half_x03 = 16151841;
        break;
    case 599:
        thalf_x0 = 15651038;
        half_x03 = 16142687;
        break;
    case 600:
        thalf_x0 = 15648084;
        half_x03 = 16133550;
        break;
    case 601:
        thalf_x0 = 15645131;
        half_x03 = 16124416;
        break;
    case 602:
        thalf_x0 = 15642179;
        half_x03 = 16115290;
        break;
    case 603:
        thalf_x0 = 15639228;
        half_x03 = 16106173;
        break;
    case 604:
        thalf_x0 = 15636279;
        half_x03 = 16097063;
        break;
    case 605:
        thalf_x0 = 15633335;
        half_x03 = 16087971;
        break;
    case 606:
        thalf_x0 = 15630387;
        half_x03 = 16078873;
        break;
    case 607:
        thalf_x0 = 15627446;
        half_x03 = 16069797;
        break;
    case 608:
        thalf_x0 = 15624504;
        half_x03 = 16060725;
        break;
    case 609:
        thalf_x0 = 15621564;
        half_x03 = 16051660;
        break;
    case 610:
        thalf_x0 = 15618626;
        half_x03 = 16042604;
        break;
    case 611:
        thalf_x0 = 15615689;
        half_x03 = 16033555;
        break;
    case 612:
        thalf_x0 = 15612753;
        half_x03 = 16024515;
        break;
    case 613:
        thalf_x0 = 15609821;
        half_x03 = 16015487;
        break;
    case 614:
        thalf_x0 = 15606888;
        half_x03 = 16006463;
        break;
    case 615:
        thalf_x0 = 15603959;
        half_x03 = 15997451;
        break;
    case 616:
        thalf_x0 = 15601031;
        half_x03 = 15988447;
        break;
    case 617:
        thalf_x0 = 15598104;
        half_x03 = 15979451;
        break;
    case 618:
        thalf_x0 = 15595178;
        half_x03 = 15970459;
        break;
    case 619:
        thalf_x0 = 15592256;
        half_x03 = 15961483;
        break;
    case 620:
        thalf_x0 = 15589332;
        half_x03 = 15952507;
        break;
    case 621:
        thalf_x0 = 15586415;
        half_x03 = 15943552;
        break;
    case 622:
        thalf_x0 = 15583493;
        half_x03 = 15934587;
        break;
    case 623:
        thalf_x0 = 15580577;
        half_x03 = 15925644;
        break;
    case 624:
        thalf_x0 = 15577661;
        half_x03 = 15916703;
        break;
    case 625:
        thalf_x0 = 15574749;
        half_x03 = 15907780;
        break;
    case 626:
        thalf_x0 = 15571836;
        half_x03 = 15898856;
        break;
    case 627:
        thalf_x0 = 15568928;
        half_x03 = 15889949;
        break;
    case 628:
        thalf_x0 = 15566018;
        half_x03 = 15881041;
        break;
    case 629:
        thalf_x0 = 15563111;
        half_x03 = 15872145;
        break;
    case 630:
        thalf_x0 = 15560205;
        half_x03 = 15863257;
        break;
    case 631:
        thalf_x0 = 15557303;
        half_x03 = 15854382;
        break;
    case 632:
        thalf_x0 = 15554399;
        half_x03 = 15845505;
        break;
    case 633:
        thalf_x0 = 15551499;
        half_x03 = 15836645;
        break;
    case 634:
        thalf_x0 = 15548600;
        half_x03 = 15827789;
        break;
    case 635:
        thalf_x0 = 15545702;
        half_x03 = 15818940;
        break;
    case 636:
        thalf_x0 = 15542807;
        half_x03 = 15810105;
        break;
    case 637:
        thalf_x0 = 15539913;
        half_x03 = 15801276;
        break;
    case 638:
        thalf_x0 = 15537020;
        half_x03 = 15792452;
        break;
    case 639:
        thalf_x0 = 15534129;
        half_x03 = 15783639;
        break;
    case 640:
        thalf_x0 = 15531240;
        half_x03 = 15774835;
        break;
    case 641:
        thalf_x0 = 15528351;
        half_x03 = 15766033;
        break;
    case 642:
        thalf_x0 = 15525467;
        half_x03 = 15757249;
        break;
    case 643:
        thalf_x0 = 15522581;
        half_x03 = 15748463;
        break;
    case 644:
        thalf_x0 = 15519698;
        half_x03 = 15739690;
        break;
    case 645:
        thalf_x0 = 15516818;
        half_x03 = 15730929;
        break;
    case 646:
        thalf_x0 = 15513938;
        half_x03 = 15722172;
        break;
    case 647:
        thalf_x0 = 15511059;
        half_x03 = 15713422;
        break;
    case 648:
        thalf_x0 = 15508184;
        half_x03 = 15704684;
        break;
    case 649:
        thalf_x0 = 15505308;
        half_x03 = 15695950;
        break;
    case 650:
        thalf_x0 = 15502436;
        half_x03 = 15687228;
        break;
    case 651:
        thalf_x0 = 15499563;
        half_x03 = 15678510;
        break;
    case 652:
        thalf_x0 = 15496694;
        half_x03 = 15669804;
        break;
    case 653:
        thalf_x0 = 15493824;
        half_x03 = 15661100;
        break;
    case 654:
        thalf_x0 = 15490959;
        half_x03 = 15652414;
        break;
    case 655:
        thalf_x0 = 15488091;
        half_x03 = 15643722;
        break;
    case 656:
        thalf_x0 = 15485229;
        half_x03 = 15635051;
        break;
    case 657:
        thalf_x0 = 15482367;
        half_x03 = 15626384;
        break;
    case 658:
        thalf_x0 = 15479508;
        half_x03 = 15617729;
        break;
    case 659:
        thalf_x0 = 15476649;
        half_x03 = 15609077;
        break;
    case 660:
        thalf_x0 = 15473792;
        half_x03 = 15600433;
        break;
    case 661:
        thalf_x0 = 15470936;
        half_x03 = 15591796;
        break;
    case 662:
        thalf_x0 = 15468081;
        half_x03 = 15583167;
        break;
    case 663:
        thalf_x0 = 15465228;
        half_x03 = 15574546;
        break;
    case 664:
        thalf_x0 = 15462375;
        half_x03 = 15565928;
        break;
    case 665:
        thalf_x0 = 15459528;
        half_x03 = 15557332;
        break;
    case 666:
        thalf_x0 = 15456681;
        half_x03 = 15548738;
        break;
    case 667:
        thalf_x0 = 15453833;
        half_x03 = 15540143;
        break;
    case 668:
        thalf_x0 = 15450989;
        half_x03 = 15531565;
        break;
    case 669:
        thalf_x0 = 15448148;
        half_x03 = 15523000;
        break;
    case 670:
        thalf_x0 = 15445304;
        half_x03 = 15514428;
        break;
    case 671:
        thalf_x0 = 15442464;
        half_x03 = 15505873;
        break;
    case 672:
        thalf_x0 = 15439625;
        half_x03 = 15497321;
        break;
    case 673:
        thalf_x0 = 15436788;
        half_x03 = 15488781;
        break;
    case 674:
        thalf_x0 = 15433955;
        half_x03 = 15480253;
        break;
    case 675:
        thalf_x0 = 15431121;
        half_x03 = 15471729;
        break;
    case 676:
        thalf_x0 = 15428288;
        half_x03 = 15463208;
        break;
    case 677:
        thalf_x0 = 15425459;
        half_x03 = 15454703;
        break;
    case 678:
        thalf_x0 = 15422628;
        half_x03 = 15446197;
        break;
    case 679:
        thalf_x0 = 15419801;
        half_x03 = 15437703;
        break;
    case 680:
        thalf_x0 = 15416975;
        half_x03 = 15429217;
        break;
    case 681:
        thalf_x0 = 15414149;
        half_x03 = 15420734;
        break;
    case 682:
        thalf_x0 = 15411327;
        half_x03 = 15412267;
        break;
    case 683:
        thalf_x0 = 15408507;
        half_x03 = 15403808;
        break;
    case 684:
        thalf_x0 = 15405687;
        half_x03 = 15395352;
        break;
    case 685:
        thalf_x0 = 15402867;
        half_x03 = 15386899;
        break;
    case 686:
        thalf_x0 = 15400053;
        half_x03 = 15378468;
        break;
    case 687:
        thalf_x0 = 15397236;
        half_x03 = 15370030;
        break;
    case 688:
        thalf_x0 = 15394424;
        half_x03 = 15361609;
        break;
    case 689:
        thalf_x0 = 15391610;
        half_x03 = 15353187;
        break;
    case 690:
        thalf_x0 = 15388800;
        half_x03 = 15344781;
        break;
    case 691:
        thalf_x0 = 15385992;
        half_x03 = 15336382;
        break;
    case 692:
        thalf_x0 = 15383184;
        half_x03 = 15327987;
        break;
    case 693:
        thalf_x0 = 15380378;
        half_x03 = 15319599;
        break;
    case 694:
        thalf_x0 = 15377573;
        half_x03 = 15311219;
        break;
    case 695:
        thalf_x0 = 15374771;
        half_x03 = 15302851;
        break;
    case 696:
        thalf_x0 = 15371969;
        half_x03 = 15294486;
        break;
    case 697:
        thalf_x0 = 15369170;
        half_x03 = 15286133;
        break;
    case 698:
        thalf_x0 = 15366372;
        half_x03 = 15277787;
        break;
    case 699:
        thalf_x0 = 15363576;
        half_x03 = 15269449;
        break;
    case 700:
        thalf_x0 = 15360780;
        half_x03 = 15261114;
        break;
    case 701:
        thalf_x0 = 15357986;
        half_x03 = 15252786;
        break;
    case 702:
        thalf_x0 = 15355196;
        half_x03 = 15244475;
        break;
    case 703:
        thalf_x0 = 15352404;
        half_x03 = 15236162;
        break;
    case 704:
        thalf_x0 = 15349616;
        half_x03 = 15227862;
        break;
    case 705:
        thalf_x0 = 15346826;
        half_x03 = 15219560;
        break;
    case 706:
        thalf_x0 = 15344042;
        half_x03 = 15211278;
        break;
    case 707:
        thalf_x0 = 15341256;
        half_x03 = 15202996;
        break;
    case 708:
        thalf_x0 = 15338474;
        half_x03 = 15194725;
        break;
    case 709:
        thalf_x0 = 15335691;
        half_x03 = 15186457;
        break;
    case 710:
        thalf_x0 = 15332912;
        half_x03 = 15178201;
        break;
    case 711:
        thalf_x0 = 15330134;
        half_x03 = 15169953;
        break;
    case 712:
        thalf_x0 = 15327357;
        half_x03 = 15161712;
        break;
    case 713:
        thalf_x0 = 15324581;
        half_x03 = 15153474;
        break;
    case 714:
        thalf_x0 = 15321807;
        half_x03 = 15145248;
        break;
    case 715:
        thalf_x0 = 15319035;
        half_x03 = 15137029;
        break;
    case 716:
        thalf_x0 = 15316263;
        half_x03 = 15128813;
        break;
    case 717:
        thalf_x0 = 15313496;
        half_x03 = 15120614;
        break;
    case 718:
        thalf_x0 = 15310727;
        half_x03 = 15112413;
        break;
    case 719:
        thalf_x0 = 15307959;
        half_x03 = 15104220;
        break;
    case 720:
        thalf_x0 = 15305196;
        half_x03 = 15096042;
        break;
    case 721:
        thalf_x0 = 15302433;
        half_x03 = 15087868;
        break;
    case 722:
        thalf_x0 = 15299669;
        half_x03 = 15079692;
        break;
    case 723:
        thalf_x0 = 15296909;
        half_x03 = 15071533;
        break;
    case 724:
        thalf_x0 = 15294152;
        half_x03 = 15063385;
        break;
    case 725:
        thalf_x0 = 15291393;
        half_x03 = 15055236;
        break;
    case 726:
        thalf_x0 = 15288636;
        half_x03 = 15047094;
        break;
    case 727:
        thalf_x0 = 15285884;
        half_x03 = 15038969;
        break;
    case 728:
        thalf_x0 = 15283130;
        half_x03 = 15030842;
        break;
    case 729:
        thalf_x0 = 15280379;
        half_x03 = 15022726;
        break;
    case 730:
        thalf_x0 = 15277629;
        half_x03 = 15014618;
        break;
    case 731:
        thalf_x0 = 15274881;
        half_x03 = 15006518;
        break;
    case 732:
        thalf_x0 = 15272133;
        half_x03 = 14998420;
        break;
    case 733:
        thalf_x0 = 15269387;
        half_x03 = 14990330;
        break;
    case 734:
        thalf_x0 = 15266643;
        half_x03 = 14982251;
        break;
    case 735:
        thalf_x0 = 15263901;
        half_x03 = 14974180;
        break;
    case 736:
        thalf_x0 = 15261159;
        half_x03 = 14966111;
        break;
    case 737:
        thalf_x0 = 15258420;
        half_x03 = 14958055;
        break;
    case 738:
        thalf_x0 = 15255683;
        half_x03 = 14950005;
        break;
    case 739:
        thalf_x0 = 15252945;
        half_x03 = 14941959;
        break;
    case 740:
        thalf_x0 = 15250211;
        half_x03 = 14933924;
        break;
    case 741:
        thalf_x0 = 15247476;
        half_x03 = 14925892;
        break;
    case 742:
        thalf_x0 = 15244743;
        half_x03 = 14917867;
        break;
    case 743:
        thalf_x0 = 15242013;
        half_x03 = 14909854;
        break;
    case 744:
        thalf_x0 = 15239283;
        half_x03 = 14901844;
        break;
    case 745:
        thalf_x0 = 15236555;
        half_x03 = 14893841;
        break;
    case 746:
        thalf_x0 = 15233831;
        half_x03 = 14885855;
        break;
    case 747:
        thalf_x0 = 15231105;
        half_x03 = 14877866;
        break;
    case 748:
        thalf_x0 = 15228381;
        half_x03 = 14869885;
        break;
    case 749:
        thalf_x0 = 15225659;
        half_x03 = 14861912;
        break;
    case 750:
        thalf_x0 = 15222938;
        half_x03 = 14853945;
        break;
    case 751:
        thalf_x0 = 15220221;
        half_x03 = 14845995;
        break;
    case 752:
        thalf_x0 = 15217502;
        half_x03 = 14838038;
        break;
    case 753:
        thalf_x0 = 15214785;
        half_x03 = 14830093;
        break;
    case 754:
        thalf_x0 = 15212072;
        half_x03 = 14822160;
        break;
    case 755:
        thalf_x0 = 15209357;
        half_x03 = 14814225;
        break;
    case 756:
        thalf_x0 = 15206645;
        half_x03 = 14806302;
        break;
    case 757:
        thalf_x0 = 15203936;
        half_x03 = 14798390;
        break;
    case 758:
        thalf_x0 = 15201227;
        half_x03 = 14790481;
        break;
    case 759:
        thalf_x0 = 15198519;
        half_x03 = 14782580;
        break;
    case 760:
        thalf_x0 = 15195813;
        half_x03 = 14774685;
        break;
    case 761:
        thalf_x0 = 15193107;
        half_x03 = 14766794;
        break;
    case 762:
        thalf_x0 = 15190404;
        half_x03 = 14758914;
        break;
    case 763:
        thalf_x0 = 15187704;
        half_x03 = 14751045;
        break;
    case 764:
        thalf_x0 = 15185003;
        half_x03 = 14743175;
        break;
    case 765:
        thalf_x0 = 15182304;
        half_x03 = 14735317;
        break;
    case 766:
        thalf_x0 = 15179606;
        half_x03 = 14727461;
        break;
    case 767:
        thalf_x0 = 15176912;
        half_x03 = 14719621;
        break;
    case 768:
        thalf_x0 = 15174216;
        half_x03 = 14711779;
        break;
    case 769:
        thalf_x0 = 15171524;
        half_x03 = 14703949;
        break;
    case 770:
        thalf_x0 = 15168831;
        half_x03 = 14696122;
        break;
    case 771:
        thalf_x0 = 15166142;
        half_x03 = 14688307;
        break;
    case 772:
        thalf_x0 = 15163452;
        half_x03 = 14680494;
        break;
    case 773:
        thalf_x0 = 15160764;
        half_x03 = 14672688;
        break;
    case 774:
        thalf_x0 = 15158079;
        half_x03 = 14664894;
        break;
    case 775:
        thalf_x0 = 15155396;
        half_x03 = 14657106;
        break;
    case 776:
        thalf_x0 = 15152711;
        half_x03 = 14649318;
        break;
    case 777:
        thalf_x0 = 15150029;
        half_x03 = 14641540;
        break;
    case 778:
        thalf_x0 = 15147350;
        half_x03 = 14633775;
        break;
    case 779:
        thalf_x0 = 15144671;
        half_x03 = 14626011;
        break;
    case 780:
        thalf_x0 = 15141995;
        half_x03 = 14618260;
        break;
    case 781:
        thalf_x0 = 15139317;
        half_x03 = 14610506;
        break;
    case 782:
        thalf_x0 = 15136643;
        half_x03 = 14602764;
        break;
    case 783:
        thalf_x0 = 15133970;
        half_x03 = 14595030;
        break;
    case 784:
        thalf_x0 = 15131297;
        half_x03 = 14587298;
        break;
    case 785:
        thalf_x0 = 15128628;
        half_x03 = 14579581;
        break;
    case 786:
        thalf_x0 = 15125960;
        half_x03 = 14571868;
        break;
    case 787:
        thalf_x0 = 15123290;
        half_x03 = 14564152;
        break;
    case 788:
        thalf_x0 = 15120626;
        half_x03 = 14556457;
        break;
    case 789:
        thalf_x0 = 15117960;
        half_x03 = 14548761;
        break;
    case 790:
        thalf_x0 = 15115296;
        half_x03 = 14541071;
        break;
    case 791:
        thalf_x0 = 15112635;
        half_x03 = 14533392;
        break;
    case 792:
        thalf_x0 = 15109976;
        half_x03 = 14525721;
        break;
    case 793:
        thalf_x0 = 15107316;
        half_x03 = 14518052;
        break;
    case 794:
        thalf_x0 = 15104657;
        half_x03 = 14510387;
        break;
    case 795:
        thalf_x0 = 15102002;
        half_x03 = 14502736;
        break;
    case 796:
        thalf_x0 = 15099347;
        half_x03 = 14495089;
        break;
    case 797:
        thalf_x0 = 15096693;
        half_x03 = 14487448;
        break;
    case 798:
        thalf_x0 = 15094041;
        half_x03 = 14479814;
        break;
    case 799:
        thalf_x0 = 15091391;
        half_x03 = 14472188;
        break;
    case 800:
        thalf_x0 = 15088742;
        half_x03 = 14464568;
        break;
    case 801:
        thalf_x0 = 15086096;
        half_x03 = 14456960;
        break;
    case 802:
        thalf_x0 = 15083448;
        half_x03 = 14449350;
        break;
    case 803:
        thalf_x0 = 15080804;
        half_x03 = 14441751;
        break;
    case 804:
        thalf_x0 = 15078158;
        half_x03 = 14434151;
        break;
    case 805:
        thalf_x0 = 15075516;
        half_x03 = 14426566;
        break;
    case 806:
        thalf_x0 = 15072876;
        half_x03 = 14418989;
        break;
    case 807:
        thalf_x0 = 15070236;
        half_x03 = 14411414;
        break;
    case 808:
        thalf_x0 = 15067598;
        half_x03 = 14403845;
        break;
    case 809:
        thalf_x0 = 15064961;
        half_x03 = 14396284;
        break;
    case 810:
        thalf_x0 = 15062327;
        half_x03 = 14388734;
        break;
    case 811:
        thalf_x0 = 15059693;
        half_x03 = 14381187;
        break;
    case 812:
        thalf_x0 = 15057059;
        half_x03 = 14373642;
        break;
    case 813:
        thalf_x0 = 15054429;
        half_x03 = 14366113;
        break;
    case 814:
        thalf_x0 = 15051797;
        half_x03 = 14358578;
        break;
    case 815:
        thalf_x0 = 15049169;
        half_x03 = 14351059;
        break;
    case 816:
        thalf_x0 = 15046544;
        half_x03 = 14343550;
        break;
    case 817:
        thalf_x0 = 15043917;
        half_x03 = 14336040;
        break;
    case 818:
        thalf_x0 = 15041294;
        half_x03 = 14328541;
        break;
    case 819:
        thalf_x0 = 15038669;
        half_x03 = 14321041;
        break;
    case 820:
        thalf_x0 = 15036048;
        half_x03 = 14313556;
        break;
    case 821:
        thalf_x0 = 15033429;
        half_x03 = 14306078;
        break;
    case 822:
        thalf_x0 = 15030809;
        half_x03 = 14298598;
        break;
    case 823:
        thalf_x0 = 15028193;
        half_x03 = 14291133;
        break;
    case 824:
        thalf_x0 = 15025575;
        half_x03 = 14283667;
        break;
    case 825:
        thalf_x0 = 15022961;
        half_x03 = 14276212;
        break;
    case 826:
        thalf_x0 = 15020348;
        half_x03 = 14268764;
        break;
    case 827:
        thalf_x0 = 15017735;
        half_x03 = 14261319;
        break;
    case 828:
        thalf_x0 = 15015123;
        half_x03 = 14253880;
        break;
    case 829:
        thalf_x0 = 15012516;
        half_x03 = 14246457;
        break;
    case 830:
        thalf_x0 = 15009909;
        half_x03 = 14239036;
        break;
    case 831:
        thalf_x0 = 15007301;
        half_x03 = 14231614;
        break;
    case 832:
        thalf_x0 = 15004695;
        half_x03 = 14224203;
        break;
    case 833:
        thalf_x0 = 15002091;
        half_x03 = 14216798;
        break;
    case 834:
        thalf_x0 = 14999489;
        half_x03 = 14209401;
        break;
    case 835:
        thalf_x0 = 14996888;
        half_x03 = 14202010;
        break;
    case 836:
        thalf_x0 = 14994288;
        half_x03 = 14194626;
        break;
    case 837:
        thalf_x0 = 14991692;
        half_x03 = 14187253;
        break;
    case 838:
        thalf_x0 = 14989094;
        half_x03 = 14179879;
        break;
    case 839:
        thalf_x0 = 14986497;
        half_x03 = 14172511;
        break;
    case 840:
        thalf_x0 = 14983904;
        half_x03 = 14165155;
        break;
    case 841:
        thalf_x0 = 14981309;
        half_x03 = 14157796;
        break;
    case 842:
        thalf_x0 = 14978720;
        half_x03 = 14150458;
        break;
    case 843:
        thalf_x0 = 14976128;
        half_x03 = 14143113;
        break;
    case 844:
        thalf_x0 = 14973539;
        half_x03 = 14135779;
        break;
    case 845:
        thalf_x0 = 14970951;
        half_x03 = 14128452;
        break;
    case 846:
        thalf_x0 = 14968365;
        half_x03 = 14121132;
        break;
    case 847:
        thalf_x0 = 14965781;
        half_x03 = 14113819;
        break;
    case 848:
        thalf_x0 = 14963196;
        half_x03 = 14106508;
        break;
    case 849:
        thalf_x0 = 14960615;
        half_x03 = 14099208;
        break;
    case 850:
        thalf_x0 = 14958033;
        half_x03 = 14091911;
        break;
    case 851:
        thalf_x0 = 14955455;
        half_x03 = 14084624;
        break;
    case 852:
        thalf_x0 = 14952875;
        half_x03 = 14077336;
        break;
    case 853:
        thalf_x0 = 14950298;
        half_x03 = 14070059;
        break;
    case 854:
        thalf_x0 = 14947724;
        half_x03 = 14062793;
        break;
    case 855:
        thalf_x0 = 14945148;
        half_x03 = 14055525;
        break;
    case 856:
        thalf_x0 = 14942577;
        half_x03 = 14048273;
        break;
    case 857:
        thalf_x0 = 14940003;
        half_x03 = 14041014;
        break;
    case 858:
        thalf_x0 = 14937434;
        half_x03 = 14033771;
        break;
    case 859:
        thalf_x0 = 14934864;
        half_x03 = 14026530;
        break;
    case 860:
        thalf_x0 = 14932296;
        half_x03 = 14019296;
        break;
    case 861:
        thalf_x0 = 14929730;
        half_x03 = 14012068;
        break;
    case 862:
        thalf_x0 = 14927163;
        half_x03 = 14004843;
        break;
    case 863:
        thalf_x0 = 14924603;
        half_x03 = 13997637;
        break;
    case 864:
        thalf_x0 = 14922039;
        half_x03 = 13990426;
        break;
    case 865:
        thalf_x0 = 14919479;
        half_x03 = 13983225;
        break;
    case 866:
        thalf_x0 = 14916920;
        half_x03 = 13976031;
        break;
    case 867:
        thalf_x0 = 14914359;
        half_x03 = 13968835;
        break;
    case 868:
        thalf_x0 = 14911802;
        half_x03 = 13961650;
        break;
    case 869:
        thalf_x0 = 14909246;
        half_x03 = 13954472;
        break;
    case 870:
        thalf_x0 = 14906691;
        half_x03 = 13947301;
        break;
    case 871:
        thalf_x0 = 14904140;
        half_x03 = 13940140;
        break;
    case 872:
        thalf_x0 = 14901588;
        half_x03 = 13932982;
        break;
    case 873:
        thalf_x0 = 14899037;
        half_x03 = 13925826;
        break;
    case 874:
        thalf_x0 = 14896488;
        half_x03 = 13918681;
        break;
    case 875:
        thalf_x0 = 14893941;
        half_x03 = 13911543;
        break;
    case 876:
        thalf_x0 = 14891393;
        half_x03 = 13904403;
        break;
    case 877:
        thalf_x0 = 14888849;
        half_x03 = 13897278;
        break;
    case 878:
        thalf_x0 = 14886303;
        half_x03 = 13890151;
        break;
    case 879:
        thalf_x0 = 14883761;
        half_x03 = 13883036;
        break;
    case 880:
        thalf_x0 = 14881220;
        half_x03 = 13875926;
        break;
    case 881:
        thalf_x0 = 14878680;
        half_x03 = 13868824;
        break;
    case 882:
        thalf_x0 = 14876141;
        half_x03 = 13861724;
        break;
    case 883:
        thalf_x0 = 14873603;
        half_x03 = 13854630;
        break;
    case 884:
        thalf_x0 = 14871068;
        half_x03 = 13847547;
        break;
    case 885:
        thalf_x0 = 14868531;
        half_x03 = 13840463;
        break;
    case 886:
        thalf_x0 = 14865999;
        half_x03 = 13833393;
        break;
    case 887:
        thalf_x0 = 14863467;
        half_x03 = 13826326;
        break;
    case 888:
        thalf_x0 = 14860935;
        half_x03 = 13819261;
        break;
    case 889:
        thalf_x0 = 14858403;
        half_x03 = 13812199;
        break;
    case 890:
        thalf_x0 = 14855877;
        half_x03 = 13805156;
        break;
    case 891:
        thalf_x0 = 14853350;
        half_x03 = 13798111;
        break;
    case 892:
        thalf_x0 = 14850825;
        half_x03 = 13791076;
        break;
    case 893:
        thalf_x0 = 14848299;
        half_x03 = 13784040;
        break;
    case 894:
        thalf_x0 = 14845776;
        half_x03 = 13777015;
        break;
    case 895:
        thalf_x0 = 14843255;
        half_x03 = 13769996;
        break;
    case 896:
        thalf_x0 = 14840735;
        half_x03 = 13762984;
        break;
    case 897:
        thalf_x0 = 14838215;
        half_x03 = 13755974;
        break;
    case 898:
        thalf_x0 = 14835695;
        half_x03 = 13748967;
        break;
    case 899:
        thalf_x0 = 14833179;
        half_x03 = 13741974;
        break;
    case 900:
        thalf_x0 = 14830664;
        half_x03 = 13734984;
        break;
    case 901:
        thalf_x0 = 14828150;
        half_x03 = 13728001;
        break;
    case 902:
        thalf_x0 = 14825637;
        half_x03 = 13721023;
        break;
    case 903:
        thalf_x0 = 14823123;
        half_x03 = 13714045;
        break;
    case 904:
        thalf_x0 = 14820614;
        half_x03 = 13707081;
        break;
    case 905:
        thalf_x0 = 14818106;
        half_x03 = 13700123;
        break;
    case 906:
        thalf_x0 = 14815598;
        half_x03 = 13693168;
        break;
    case 907:
        thalf_x0 = 14813090;
        half_x03 = 13686215;
        break;
    case 908:
        thalf_x0 = 14810585;
        half_x03 = 13679273;
        break;
    case 909:
        thalf_x0 = 14808080;
        half_x03 = 13672333;
        break;
    case 910:
        thalf_x0 = 14805578;
        half_x03 = 13665404;
        break;
    case 911:
        thalf_x0 = 14803076;
        half_x03 = 13658477;
        break;
    case 912:
        thalf_x0 = 14800575;
        half_x03 = 13651557;
        break;
    case 913:
        thalf_x0 = 14798076;
        half_x03 = 13644643;
        break;
    case 914:
        thalf_x0 = 14795579;
        half_x03 = 13637736;
        break;
    case 915:
        thalf_x0 = 14793083;
        half_x03 = 13630835;
        break;
    case 916:
        thalf_x0 = 14790587;
        half_x03 = 13623936;
        break;
    case 917:
        thalf_x0 = 14788092;
        half_x03 = 13617044;
        break;
    case 918:
        thalf_x0 = 14785599;
        half_x03 = 13610159;
        break;
    case 919:
        thalf_x0 = 14783109;
        half_x03 = 13603284;
        break;
    case 920:
        thalf_x0 = 14780619;
        half_x03 = 13596411;
        break;
    case 921:
        thalf_x0 = 14778131;
        half_x03 = 13589545;
        break;
    case 922:
        thalf_x0 = 14775641;
        half_x03 = 13582677;
        break;
    case 923:
        thalf_x0 = 14773155;
        half_x03 = 13575824;
        break;
    case 924:
        thalf_x0 = 14770671;
        half_x03 = 13568977;
        break;
    case 925:
        thalf_x0 = 14768187;
        half_x03 = 13562132;
        break;
    case 926:
        thalf_x0 = 14765703;
        half_x03 = 13555290;
        break;
    case 927:
        thalf_x0 = 14763221;
        half_x03 = 13548454;
        break;
    case 928:
        thalf_x0 = 14760743;
        half_x03 = 13541633;
        break;
    case 929:
        thalf_x0 = 14758263;
        half_x03 = 13534810;
        break;
    case 930:
        thalf_x0 = 14755785;
        half_x03 = 13527993;
        break;
    case 931:
        thalf_x0 = 14753309;
        half_x03 = 13521183;
        break;
    case 932:
        thalf_x0 = 14750834;
        half_x03 = 13514379;
        break;
    case 933:
        thalf_x0 = 14748360;
        half_x03 = 13507582;
        break;
    case 934:
        thalf_x0 = 14745888;
        half_x03 = 13500791;
        break;
    case 935:
        thalf_x0 = 14743416;
        half_x03 = 13494002;
        break;
    case 936:
        thalf_x0 = 14740944;
        half_x03 = 13487216;
        break;
    case 937:
        thalf_x0 = 14738475;
        half_x03 = 13480440;
        break;
    case 938:
        thalf_x0 = 14736009;
        half_x03 = 13473675;
        break;
    case 939:
        thalf_x0 = 14733543;
        half_x03 = 13466912;
        break;
    case 940:
        thalf_x0 = 14731077;
        half_x03 = 13460151;
        break;
    case 941:
        thalf_x0 = 14728613;
        half_x03 = 13453396;
        break;
    case 942:
        thalf_x0 = 14726150;
        half_x03 = 13446648;
        break;
    case 943:
        thalf_x0 = 14723690;
        half_x03 = 13439910;
        break;
    case 944:
        thalf_x0 = 14721230;
        half_x03 = 13433175;
        break;
    case 945:
        thalf_x0 = 14718770;
        half_x03 = 13426442;
        break;
    case 946:
        thalf_x0 = 14716311;
        half_x03 = 13419715;
        break;
    case 947:
        thalf_x0 = 14713856;
        half_x03 = 13412999;
        break;
    case 948:
        thalf_x0 = 14711400;
        half_x03 = 13406284;
        break;
    case 949:
        thalf_x0 = 14708945;
        half_x03 = 13399573;
        break;
    case 950:
        thalf_x0 = 14706492;
        half_x03 = 13392871;
        break;
    case 951:
        thalf_x0 = 14704041;
        half_x03 = 13386176;
        break;
    case 952:
        thalf_x0 = 14701592;
        half_x03 = 13379487;
        break;
    case 953:
        thalf_x0 = 14699141;
        half_x03 = 13372797;
        break;
    case 954:
        thalf_x0 = 14696693;
        half_x03 = 13366117;
        break;
    case 955:
        thalf_x0 = 14694248;
        half_x03 = 13359447;
        break;
    case 956:
        thalf_x0 = 14691801;
        half_x03 = 13352775;
        break;
    case 957:
        thalf_x0 = 14689356;
        half_x03 = 13346110;
        break;
    case 958:
        thalf_x0 = 14686913;
        half_x03 = 13339451;
        break;
    case 959:
        thalf_x0 = 14684471;
        half_x03 = 13332798;
        break;
    case 960:
        thalf_x0 = 14682032;
        half_x03 = 13326155;
        break;
    case 961:
        thalf_x0 = 14679591;
        half_x03 = 13319511;
        break;
    case 962:
        thalf_x0 = 14677152;
        half_x03 = 13312873;
        break;
    case 963:
        thalf_x0 = 14674715;
        half_x03 = 13306242;
        break;
    case 964:
        thalf_x0 = 14672280;
        half_x03 = 13299620;
        break;
    case 965:
        thalf_x0 = 14669846;
        half_x03 = 13293001;
        break;
    case 966:
        thalf_x0 = 14667411;
        half_x03 = 13286384;
        break;
    case 967:
        thalf_x0 = 14664981;
        half_x03 = 13279782;
        break;
    case 968:
        thalf_x0 = 14662550;
        half_x03 = 13273177;
        break;
    case 969:
        thalf_x0 = 14660121;
        half_x03 = 13266583;
        break;
    case 970:
        thalf_x0 = 14657690;
        half_x03 = 13259983;
        break;
    case 971:
        thalf_x0 = 14655264;
        half_x03 = 13253402;
        break;
    case 972:
        thalf_x0 = 14652837;
        half_x03 = 13246818;
        break;
    case 973:
        thalf_x0 = 14650412;
        half_x03 = 13240241;
        break;
    case 974:
        thalf_x0 = 14647988;
        half_x03 = 13233670;
        break;
    case 975:
        thalf_x0 = 14645567;
        half_x03 = 13227109;
        break;
    case 976:
        thalf_x0 = 14643144;
        half_x03 = 13220547;
        break;
    case 977:
        thalf_x0 = 14640723;
        half_x03 = 13213991;
        break;
    case 978:
        thalf_x0 = 14638307;
        half_x03 = 13207449;
        break;
    case 979:
        thalf_x0 = 14635887;
        half_x03 = 13200901;
        break;
    case 980:
        thalf_x0 = 14633471;
        half_x03 = 13194363;
        break;
    case 981:
        thalf_x0 = 14631057;
        half_x03 = 13187836;
        break;
    case 982:
        thalf_x0 = 14628641;
        half_x03 = 13181302;
        break;
    case 983:
        thalf_x0 = 14626227;
        half_x03 = 13174779;
        break;
    case 984:
        thalf_x0 = 14623817;
        half_x03 = 13168266;
        break;
    case 985:
        thalf_x0 = 14621408;
        half_x03 = 13161760;
        break;
    case 986:
        thalf_x0 = 14618997;
        half_x03 = 13155251;
        break;
    case 987:
        thalf_x0 = 14616588;
        half_x03 = 13148749;
        break;
    case 988:
        thalf_x0 = 14614181;
        half_x03 = 13142253;
        break;
    case 989:
        thalf_x0 = 14611776;
        half_x03 = 13135767;
        break;
    case 990:
        thalf_x0 = 14609372;
        half_x03 = 13129283;
        break;
    case 991:
        thalf_x0 = 14606967;
        half_x03 = 13122802;
        break;
    case 992:
        thalf_x0 = 14604566;
        half_x03 = 13116330;
        break;
    case 993:
        thalf_x0 = 14602164;
        half_x03 = 13109861;
        break;
    case 994:
        thalf_x0 = 14599764;
        half_x03 = 13103398;
        break;
    case 995:
        thalf_x0 = 14597366;
        half_x03 = 13096941;
        break;
    case 996:
        thalf_x0 = 14594967;
        half_x03 = 13090486;
        break;
    case 997:
        thalf_x0 = 14592572;
        half_x03 = 13084041;
        break;
    case 998:
        thalf_x0 = 14590176;
        half_x03 = 13077599;
        break;
    case 999:
        thalf_x0 = 14587784;
        half_x03 = 13071167;
        break;
    case 1000:
        thalf_x0 = 14585390;
        half_x03 = 13064732;
        break;
    case 1001:
        thalf_x0 = 14582999;
        half_x03 = 13058308;
        break;
    case 1002:
        thalf_x0 = 14580608;
        half_x03 = 13051886;
        break;
    case 1003:
        thalf_x0 = 14578220;
        half_x03 = 13045474;
        break;
    case 1004:
        thalf_x0 = 14575832;
        half_x03 = 13039065;
        break;
    case 1005:
        thalf_x0 = 14573444;
        half_x03 = 13032657;
        break;
    case 1006:
        thalf_x0 = 14571059;
        half_x03 = 13026259;
        break;
    case 1007:
        thalf_x0 = 14568674;
        half_x03 = 13019864;
        break;
    case 1008:
        thalf_x0 = 14566289;
        half_x03 = 13013471;
        break;
    case 1009:
        thalf_x0 = 14563908;
        half_x03 = 13007092;
        break;
    case 1010:
        thalf_x0 = 14561528;
        half_x03 = 13000715;
        break;
    case 1011:
        thalf_x0 = 14559146;
        half_x03 = 12994336;
        break;
    case 1012:
        thalf_x0 = 14556768;
        half_x03 = 12987971;
        break;
    case 1013:
        thalf_x0 = 14554391;
        half_x03 = 12981608;
        break;
    case 1014:
        thalf_x0 = 14552015;
        half_x03 = 12975251;
        break;
    case 1015:
        thalf_x0 = 14549639;
        half_x03 = 12968897;
        break;
    case 1016:
        thalf_x0 = 14547264;
        half_x03 = 12962548;
        break;
    case 1017:
        thalf_x0 = 14544891;
        half_x03 = 12956206;
        break;
    case 1018:
        thalf_x0 = 14542520;
        half_x03 = 12949869;
        break;
    case 1019:
        thalf_x0 = 14540150;
        half_x03 = 12943539;
        break;
    case 1020:
        thalf_x0 = 14537781;
        half_x03 = 12937215;
        break;
    case 1021:
        thalf_x0 = 14535411;
        half_x03 = 12930889;
        break;
    case 1022:
        thalf_x0 = 14533044;
        half_x03 = 12924572;
        break;
    case 1023:
        thalf_x0 = 14530677;
        half_x03 = 12918258;
        break;
    case 1024:
        thalf_x0 = 14528313;
        half_x03 = 12911954;
        break;
    case 1025:
        thalf_x0 = 14525949;
        half_x03 = 12905653;
        break;
    case 1026:
        thalf_x0 = 14523587;
        half_x03 = 12899357;
        break;
    case 1027:
        thalf_x0 = 14521226;
        half_x03 = 12893067;
        break;
    case 1028:
        thalf_x0 = 14518865;
        half_x03 = 12886779;
        break;
    case 1029:
        thalf_x0 = 14516507;
        half_x03 = 12880501;
        break;
    case 1030:
        thalf_x0 = 14514149;
        half_x03 = 12874225;
        break;
    case 1031:
        thalf_x0 = 14511792;
        half_x03 = 12867956;
        break;
    case 1032:
        thalf_x0 = 14509437;
        half_x03 = 12861692;
        break;
    case 1033:
        thalf_x0 = 14507081;
        half_x03 = 12855426;
        break;
    case 1034:
        thalf_x0 = 14504729;
        half_x03 = 12849175;
        break;
    case 1035:
        thalf_x0 = 14502377;
        half_x03 = 12842925;
        break;
    case 1036:
        thalf_x0 = 14500025;
        half_x03 = 12836677;
        break;
    case 1037:
        thalf_x0 = 14497676;
        half_x03 = 12830440;
        break;
    case 1038:
        thalf_x0 = 14495327;
        half_x03 = 12824204;
        break;
    case 1039:
        thalf_x0 = 14492979;
        half_x03 = 12817975;
        break;
    case 1040:
        thalf_x0 = 14490632;
        half_x03 = 12811747;
        break;
    case 1041:
        thalf_x0 = 14488287;
        half_x03 = 12805529;
        break;
    case 1042:
        thalf_x0 = 14485943;
        half_x03 = 12799314;
        break;
    case 1043:
        thalf_x0 = 14483600;
        half_x03 = 12793104;
        break;
    case 1044:
        thalf_x0 = 14481257;
        half_x03 = 12786897;
        break;
    case 1045:
        thalf_x0 = 14478917;
        half_x03 = 12780699;
        break;
    case 1046:
        thalf_x0 = 14476577;
        half_x03 = 12774504;
        break;
    case 1047:
        thalf_x0 = 14474240;
        half_x03 = 12768318;
        break;
    case 1048:
        thalf_x0 = 14471901;
        half_x03 = 12762130;
        break;
    case 1049:
        thalf_x0 = 14469566;
        half_x03 = 12755952;
        break;
    case 1050:
        thalf_x0 = 14467232;
        half_x03 = 12749781;
        break;
    case 1051:
        thalf_x0 = 14464896;
        half_x03 = 12743607;
        break;
    case 1052:
        thalf_x0 = 14462565;
        half_x03 = 12737447;
        break;
    case 1053:
        thalf_x0 = 14460231;
        half_x03 = 12731281;
        break;
    case 1054:
        thalf_x0 = 14457902;
        half_x03 = 12725129;
        break;
    case 1055:
        thalf_x0 = 14455572;
        half_x03 = 12718979;
        break;
    case 1056:
        thalf_x0 = 14453243;
        half_x03 = 12712831;
        break;
    case 1057:
        thalf_x0 = 14450915;
        half_x03 = 12706689;
        break;
    case 1058:
        thalf_x0 = 14448588;
        half_x03 = 12700553;
        break;
    case 1059:
        thalf_x0 = 14446263;
        half_x03 = 12694423;
        break;
    case 1060:
        thalf_x0 = 14443941;
        half_x03 = 12688303;
        break;
    case 1061:
        thalf_x0 = 14441618;
        half_x03 = 12682181;
        break;
    case 1062:
        thalf_x0 = 14439297;
        half_x03 = 12676068;
        break;
    case 1063:
        thalf_x0 = 14436975;
        half_x03 = 12669954;
        break;
    case 1064:
        thalf_x0 = 14434656;
        half_x03 = 12663849;
        break;
    case 1065:
        thalf_x0 = 14432339;
        half_x03 = 12657751;
        break;
    case 1066:
        thalf_x0 = 14430021;
        half_x03 = 12651654;
        break;
    case 1067:
        thalf_x0 = 14427705;
        half_x03 = 12645563;
        break;
    case 1068:
        thalf_x0 = 14425391;
        half_x03 = 12639478;
        break;
    case 1069:
        thalf_x0 = 14423078;
        half_x03 = 12633400;
        break;
    case 1070:
        thalf_x0 = 14420763;
        half_x03 = 12627319;
        break;
    case 1071:
        thalf_x0 = 14418452;
        half_x03 = 12621248;
        break;
    case 1072:
        thalf_x0 = 14416142;
        half_x03 = 12615182;
        break;
    case 1073:
        thalf_x0 = 14413833;
        half_x03 = 12609123;
        break;
    case 1074:
        thalf_x0 = 14411525;
        half_x03 = 12603066;
        break;
    case 1075:
        thalf_x0 = 14409216;
        half_x03 = 12597010;
        break;
    case 1076:
        thalf_x0 = 14406912;
        half_x03 = 12590968;
        break;
    case 1077:
        thalf_x0 = 14404607;
        half_x03 = 12584925;
        break;
    case 1078:
        thalf_x0 = 14402303;
        half_x03 = 12578887;
        break;
    case 1079:
        thalf_x0 = 14400000;
        half_x03 = 12572855;
        break;
    case 1080:
        thalf_x0 = 14397698;
        half_x03 = 12566825;
        break;
    case 1081:
        thalf_x0 = 14395397;
        half_x03 = 12560800;
        break;
    case 1082:
        thalf_x0 = 14393099;
        half_x03 = 12554786;
        break;
    case 1083:
        thalf_x0 = 14390801;
        half_x03 = 12548773;
        break;
    case 1084:
        thalf_x0 = 14388503;
        half_x03 = 12542763;
        break;
    case 1085:
        thalf_x0 = 14386205;
        half_x03 = 12536754;
        break;
    case 1086:
        thalf_x0 = 14383911;
        half_x03 = 12530759;
        break;
    case 1087:
        thalf_x0 = 14381618;
        half_x03 = 12524766;
        break;
    case 1088:
        thalf_x0 = 14379326;
        half_x03 = 12518779;
        break;
    case 1089:
        thalf_x0 = 14377034;
        half_x03 = 12512793;
        break;
    case 1090:
        thalf_x0 = 14374743;
        half_x03 = 12506814;
        break;
    case 1091:
        thalf_x0 = 14372453;
        half_x03 = 12500836;
        break;
    case 1092:
        thalf_x0 = 14370164;
        half_x03 = 12494864;
        break;
    case 1093:
        thalf_x0 = 14367878;
        half_x03 = 12488902;
        break;
    case 1094:
        thalf_x0 = 14365592;
        half_x03 = 12482942;
        break;
    case 1095:
        thalf_x0 = 14363306;
        half_x03 = 12476984;
        break;
    case 1096:
        thalf_x0 = 14361021;
        half_x03 = 12471031;
        break;
    case 1097:
        thalf_x0 = 14358740;
        half_x03 = 12465089;
        break;
    case 1098:
        thalf_x0 = 14356457;
        half_x03 = 12459144;
        break;
    case 1099:
        thalf_x0 = 14354177;
        half_x03 = 12453209;
        break;
    case 1100:
        thalf_x0 = 14351897;
        half_x03 = 12447275;
        break;
    case 1101:
        thalf_x0 = 14349617;
        half_x03 = 12441344;
        break;
    case 1102:
        thalf_x0 = 14347340;
        half_x03 = 12435423;
        break;
    case 1103:
        thalf_x0 = 14345064;
        half_x03 = 12429507;
        break;
    case 1104:
        thalf_x0 = 14342789;
        half_x03 = 12423593;
        break;
    case 1105:
        thalf_x0 = 14340515;
        half_x03 = 12417684;
        break;
    case 1106:
        thalf_x0 = 14338241;
        half_x03 = 12411778;
        break;
    case 1107:
        thalf_x0 = 14335970;
        half_x03 = 12405881;
        break;
    case 1108:
        thalf_x0 = 14333697;
        half_x03 = 12399983;
        break;
    case 1109:
        thalf_x0 = 14331428;
        half_x03 = 12394094;
        break;
    case 1110:
        thalf_x0 = 14329160;
        half_x03 = 12388210;
        break;
    case 1111:
        thalf_x0 = 14326892;
        half_x03 = 12382329;
        break;
    case 1112:
        thalf_x0 = 14324625;
        half_x03 = 12376453;
        break;
    case 1113:
        thalf_x0 = 14322359;
        half_x03 = 12370579;
        break;
    case 1114:
        thalf_x0 = 14320094;
        half_x03 = 12364711;
        break;
    case 1115:
        thalf_x0 = 14317832;
        half_x03 = 12358853;
        break;
    case 1116:
        thalf_x0 = 14315568;
        half_x03 = 12352992;
        break;
    case 1117:
        thalf_x0 = 14313308;
        half_x03 = 12347141;
        break;
    case 1118:
        thalf_x0 = 14311046;
        half_x03 = 12341289;
        break;
    case 1119:
        thalf_x0 = 14308788;
        half_x03 = 12335449;
        break;
    case 1120:
        thalf_x0 = 14306528;
        half_x03 = 12329604;
        break;
    case 1121:
        thalf_x0 = 14304272;
        half_x03 = 12323772;
        break;
    case 1122:
        thalf_x0 = 14302016;
        half_x03 = 12317942;
        break;
    case 1123:
        thalf_x0 = 14299763;
        half_x03 = 12312122;
        break;
    case 1124:
        thalf_x0 = 14297507;
        half_x03 = 12306295;
        break;
    case 1125:
        thalf_x0 = 14295255;
        half_x03 = 12300482;
        break;
    case 1126:
        thalf_x0 = 14293002;
        half_x03 = 12294667;
        break;
    case 1127:
        thalf_x0 = 14290751;
        half_x03 = 12288858;
        break;
    case 1128:
        thalf_x0 = 14288501;
        half_x03 = 12283055;
        break;
    case 1129:
        thalf_x0 = 14286254;
        half_x03 = 12277261;
        break;
    case 1130:
        thalf_x0 = 14284007;
        half_x03 = 12271469;
        break;
    case 1131:
        thalf_x0 = 14281760;
        half_x03 = 12265678;
        break;
    case 1132:
        thalf_x0 = 14279516;
        half_x03 = 12259897;
        break;
    case 1133:
        thalf_x0 = 14277269;
        half_x03 = 12254111;
        break;
    case 1134:
        thalf_x0 = 14275028;
        half_x03 = 12248341;
        break;
    case 1135:
        thalf_x0 = 14272785;
        half_x03 = 12242570;
        break;
    case 1136:
        thalf_x0 = 14270543;
        half_x03 = 12236800;
        break;
    case 1137:
        thalf_x0 = 14268303;
        half_x03 = 12231040;
        break;
    case 1138:
        thalf_x0 = 14266064;
        half_x03 = 12225282;
        break;
    case 1139:
        thalf_x0 = 14263827;
        half_x03 = 12219533;
        break;
    case 1140:
        thalf_x0 = 14261589;
        half_x03 = 12213782;
        break;
    case 1141:
        thalf_x0 = 14259353;
        half_x03 = 12208037;
        break;
    case 1142:
        thalf_x0 = 14257119;
        half_x03 = 12202301;
        break;
    case 1143:
        thalf_x0 = 14254886;
        half_x03 = 12196567;
        break;
    case 1144:
        thalf_x0 = 14252651;
        half_x03 = 12190831;
        break;
    case 1145:
        thalf_x0 = 14250422;
        half_x03 = 12185113;
        break;
    case 1146:
        thalf_x0 = 14248190;
        half_x03 = 12179388;
        break;
    case 1147:
        thalf_x0 = 14245959;
        half_x03 = 12173669;
        break;
    case 1148:
        thalf_x0 = 14243732;
        half_x03 = 12167960;
        break;
    case 1149:
        thalf_x0 = 14241506;
        half_x03 = 12162256;
        break;
    case 1150:
        thalf_x0 = 14239278;
        half_x03 = 12156550;
        break;
    case 1151:
        thalf_x0 = 14237052;
        half_x03 = 12150849;
        break;
    case 1152:
        thalf_x0 = 14234828;
        half_x03 = 12145155;
        break;
    case 1153:
        thalf_x0 = 14232605;
        half_x03 = 12139465;
        break;
    case 1154:
        thalf_x0 = 14230383;
        half_x03 = 12133782;
        break;
    case 1155:
        thalf_x0 = 14228162;
        half_x03 = 12128100;
        break;
    case 1156:
        thalf_x0 = 14225942;
        half_x03 = 12122424;
        break;
    case 1157:
        thalf_x0 = 14223722;
        half_x03 = 12116750;
        break;
    case 1158:
        thalf_x0 = 14221503;
        half_x03 = 12111081;
        break;
    case 1159:
        thalf_x0 = 14219288;
        half_x03 = 12105422;
        break;
    case 1160:
        thalf_x0 = 14217071;
        half_x03 = 12099760;
        break;
    case 1161:
        thalf_x0 = 14214855;
        half_x03 = 12094105;
        break;
    case 1162:
        thalf_x0 = 14212641;
        half_x03 = 12088454;
        break;
    case 1163:
        thalf_x0 = 14210429;
        half_x03 = 12082810;
        break;
    case 1164:
        thalf_x0 = 14208218;
        half_x03 = 12077171;
        break;
    case 1165:
        thalf_x0 = 14206007;
        half_x03 = 12071534;
        break;
    case 1166:
        thalf_x0 = 14203796;
        half_x03 = 12065898;
        break;
    case 1167:
        thalf_x0 = 14201588;
        half_x03 = 12060272;
        break;
    case 1168:
        thalf_x0 = 14199380;
        half_x03 = 12054648;
        break;
    case 1169:
        thalf_x0 = 14197172;
        half_x03 = 12049025;
        break;
    case 1170:
        thalf_x0 = 14194967;
        half_x03 = 12043412;
        break;
    case 1171:
        thalf_x0 = 14192762;
        half_x03 = 12037800;
        break;
    case 1172:
        thalf_x0 = 14190558;
        half_x03 = 12032194;
        break;
    case 1173:
        thalf_x0 = 14188355;
        half_x03 = 12026590;
        break;
    case 1174:
        thalf_x0 = 14186153;
        half_x03 = 12020992;
        break;
    case 1175:
        thalf_x0 = 14183954;
        half_x03 = 12015402;
        break;
    case 1176:
        thalf_x0 = 14181755;
        half_x03 = 12009815;
        break;
    case 1177:
        thalf_x0 = 14179556;
        half_x03 = 12004229;
        break;
    case 1178:
        thalf_x0 = 14177357;
        half_x03 = 11998645;
        break;
    case 1179:
        thalf_x0 = 14175161;
        half_x03 = 11993070;
        break;
    case 1180:
        thalf_x0 = 14172966;
        half_x03 = 11987501;
        break;
    case 1181:
        thalf_x0 = 14170772;
        half_x03 = 11981934;
        break;
    case 1182:
        thalf_x0 = 14168579;
        half_x03 = 11976372;
        break;
    case 1183:
        thalf_x0 = 14166386;
        half_x03 = 11970811;
        break;
    case 1184:
        thalf_x0 = 14164194;
        half_x03 = 11965257;
        break;
    case 1185:
        thalf_x0 = 14162003;
        half_x03 = 11959704;
        break;
    case 1186:
        thalf_x0 = 14159814;
        half_x03 = 11954160;
        break;
    case 1187:
        thalf_x0 = 14157627;
        half_x03 = 11948622;
        break;
    case 1188:
        thalf_x0 = 14155439;
        half_x03 = 11943082;
        break;
    case 1189:
        thalf_x0 = 14153253;
        half_x03 = 11937551;
        break;
    case 1190:
        thalf_x0 = 14151068;
        half_x03 = 11932022;
        break;
    case 1191:
        thalf_x0 = 14148884;
        half_x03 = 11926498;
        break;
    case 1192:
        thalf_x0 = 14146700;
        half_x03 = 11920976;
        break;
    case 1193:
        thalf_x0 = 14144517;
        half_x03 = 11915459;
        break;
    case 1194:
        thalf_x0 = 14142336;
        half_x03 = 11909948;
        break;
    case 1195:
        thalf_x0 = 14140155;
        half_x03 = 11904439;
        break;
    case 1196:
        thalf_x0 = 14137976;
        half_x03 = 11898935;
        break;
    case 1197:
        thalf_x0 = 14135798;
        half_x03 = 11893437;
        break;
    case 1198:
        thalf_x0 = 14133621;
        half_x03 = 11887944;
        break;
    case 1199:
        thalf_x0 = 14131445;
        half_x03 = 11882453;
        break;
    case 1200:
        thalf_x0 = 14129270;
        half_x03 = 11876967;
        break;
    case 1201:
        thalf_x0 = 14127095;
        half_x03 = 11871483;
        break;
    case 1202:
        thalf_x0 = 14124921;
        half_x03 = 11866004;
        break;
    case 1203:
        thalf_x0 = 14122749;
        half_x03 = 11860531;
        break;
    case 1204:
        thalf_x0 = 14120577;
        half_x03 = 11855060;
        break;
    case 1205:
        thalf_x0 = 14118408;
        half_x03 = 11849598;
        break;
    case 1206:
        thalf_x0 = 14116239;
        half_x03 = 11844137;
        break;
    case 1207:
        thalf_x0 = 14114072;
        half_x03 = 11838682;
        break;
    case 1208:
        thalf_x0 = 14111903;
        half_x03 = 11833225;
        break;
    case 1209:
        thalf_x0 = 14109737;
        half_x03 = 11827777;
        break;
    case 1210:
        thalf_x0 = 14107572;
        half_x03 = 11822335;
        break;
    case 1211:
        thalf_x0 = 14105408;
        half_x03 = 11816894;
        break;
    case 1212:
        thalf_x0 = 14103246;
        half_x03 = 11811462;
        break;
    case 1213:
        thalf_x0 = 14101082;
        half_x03 = 11806025;
        break;
    case 1214:
        thalf_x0 = 14098922;
        half_x03 = 11800600;
        break;
    case 1215:
        thalf_x0 = 14096760;
        half_x03 = 11795174;
        break;
    case 1216:
        thalf_x0 = 14094602;
        half_x03 = 11789756;
        break;
    case 1217:
        thalf_x0 = 14092445;
        half_x03 = 11784344;
        break;
    case 1218:
        thalf_x0 = 14090285;
        half_x03 = 11778926;
        break;
    case 1219:
        thalf_x0 = 14088131;
        half_x03 = 11773525;
        break;
    case 1220:
        thalf_x0 = 14085975;
        half_x03 = 11768122;
        break;
    case 1221:
        thalf_x0 = 14083820;
        half_x03 = 11762720;
        break;
    case 1222:
        thalf_x0 = 14081667;
        half_x03 = 11757328;
        break;
    case 1223:
        thalf_x0 = 14079515;
        half_x03 = 11751937;
        break;
    case 1224:
        thalf_x0 = 14077364;
        half_x03 = 11746552;
        break;
    case 1225:
        thalf_x0 = 14075213;
        half_x03 = 11741168;
        break;
    case 1226:
        thalf_x0 = 14073063;
        half_x03 = 11735790;
        break;
    case 1227:
        thalf_x0 = 14070915;
        half_x03 = 11730417;
        break;
    case 1228:
        thalf_x0 = 14068767;
        half_x03 = 11725045;
        break;
    case 1229:
        thalf_x0 = 14066621;
        half_x03 = 11719679;
        break;
    case 1230:
        thalf_x0 = 14064476;
        half_x03 = 11714319;
        break;
    case 1231:
        thalf_x0 = 14062331;
        half_x03 = 11708960;
        break;
    case 1232:
        thalf_x0 = 14060187;
        half_x03 = 11703606;
        break;
    case 1233:
        thalf_x0 = 14058045;
        half_x03 = 11698258;
        break;
    case 1234:
        thalf_x0 = 14055903;
        half_x03 = 11692912;
        break;
    case 1235:
        thalf_x0 = 14053763;
        half_x03 = 11687571;
        break;
    case 1236:
        thalf_x0 = 14051625;
        half_x03 = 11682239;
        break;
    case 1237:
        thalf_x0 = 14049485;
        half_x03 = 11676901;
        break;
    case 1238:
        thalf_x0 = 14047347;
        half_x03 = 11671572;
        break;
    case 1239:
        thalf_x0 = 14045211;
        half_x03 = 11666249;
        break;
    case 1240:
        thalf_x0 = 14043075;
        half_x03 = 11660927;
        break;
    case 1241:
        thalf_x0 = 14040939;
        half_x03 = 11655606;
        break;
    case 1242:
        thalf_x0 = 14038808;
        half_x03 = 11650299;
        break;
    case 1243:
        thalf_x0 = 14036673;
        half_x03 = 11644986;
        break;
    case 1244:
        thalf_x0 = 14034542;
        half_x03 = 11639682;
        break;
    case 1245:
        thalf_x0 = 14032412;
        half_x03 = 11634383;
        break;
    case 1246:
        thalf_x0 = 14030282;
        half_x03 = 11629086;
        break;
    case 1247:
        thalf_x0 = 14028152;
        half_x03 = 11623790;
        break;
    case 1248:
        thalf_x0 = 14026025;
        half_x03 = 11618504;
        break;
    case 1249:
        thalf_x0 = 14023898;
        half_x03 = 11613219;
        break;
    case 1250:
        thalf_x0 = 14021771;
        half_x03 = 11607935;
        break;
    case 1251:
        thalf_x0 = 14019647;
        half_x03 = 11602661;
        break;
    case 1252:
        thalf_x0 = 14017523;
        half_x03 = 11597388;
        break;
    case 1253:
        thalf_x0 = 14015399;
        half_x03 = 11592117;
        break;
    case 1254:
        thalf_x0 = 14013278;
        half_x03 = 11586855;
        break;
    case 1255:
        thalf_x0 = 14011157;
        half_x03 = 11581595;
        break;
    case 1256:
        thalf_x0 = 14009036;
        half_x03 = 11576336;
        break;
    case 1257:
        thalf_x0 = 14006918;
        half_x03 = 11571086;
        break;
    case 1258:
        thalf_x0 = 14004800;
        half_x03 = 11565838;
        break;
    case 1259:
        thalf_x0 = 14002682;
        half_x03 = 11560591;
        break;
    case 1260:
        thalf_x0 = 14000565;
        half_x03 = 11555350;
        break;
    case 1261:
        thalf_x0 = 13998450;
        half_x03 = 11550114;
        break;
    case 1262:
        thalf_x0 = 13996335;
        half_x03 = 11544880;
        break;
    case 1263:
        thalf_x0 = 13994222;
        half_x03 = 11539650;
        break;
    case 1264:
        thalf_x0 = 13992110;
        half_x03 = 11534426;
        break;
    case 1265:
        thalf_x0 = 13989998;
        half_x03 = 11529204;
        break;
    case 1266:
        thalf_x0 = 13987889;
        half_x03 = 11523991;
        break;
    case 1267:
        thalf_x0 = 13985777;
        half_x03 = 11518772;
        break;
    case 1268:
        thalf_x0 = 13983669;
        half_x03 = 11513565;
        break;
    case 1269:
        thalf_x0 = 13981562;
        half_x03 = 11508360;
        break;
    case 1270:
        thalf_x0 = 13979454;
        half_x03 = 11503157;
        break;
    case 1271:
        thalf_x0 = 13977350;
        half_x03 = 11497963;
        break;
    case 1272:
        thalf_x0 = 13975244;
        half_x03 = 11492766;
        break;
    case 1273:
        thalf_x0 = 13973141;
        half_x03 = 11487579;
        break;
    case 1274:
        thalf_x0 = 13971038;
        half_x03 = 11482393;
        break;
    case 1275:
        thalf_x0 = 13968935;
        half_x03 = 11477208;
        break;
    case 1276:
        thalf_x0 = 13966833;
        half_x03 = 11472029;
        break;
    case 1277:
        thalf_x0 = 13964733;
        half_x03 = 11466855;
        break;
    case 1278:
        thalf_x0 = 13962635;
        half_x03 = 11461687;
        break;
    case 1279:
        thalf_x0 = 13960536;
        half_x03 = 11456519;
        break;
    case 1280:
        thalf_x0 = 13958439;
        half_x03 = 11451358;
        break;
    case 1281:
        thalf_x0 = 13956344;
        half_x03 = 11446201;
        break;
    case 1282:
        thalf_x0 = 13954247;
        half_x03 = 11441042;
        break;
    case 1283:
        thalf_x0 = 13952153;
        half_x03 = 11435893;
        break;
    case 1284:
        thalf_x0 = 13950059;
        half_x03 = 11430744;
        break;
    case 1285:
        thalf_x0 = 13947968;
        half_x03 = 11425605;
        break;
    case 1286:
        thalf_x0 = 13945875;
        half_x03 = 11420463;
        break;
    case 1287:
        thalf_x0 = 13943786;
        half_x03 = 11415331;
        break;
    case 1288:
        thalf_x0 = 13941695;
        half_x03 = 11410196;
        break;
    case 1289:
        thalf_x0 = 13939607;
        half_x03 = 11405070;
        break;
    case 1290:
        thalf_x0 = 13937519;
        half_x03 = 11399946;
        break;
    case 1291:
        thalf_x0 = 13935431;
        half_x03 = 11394823;
        break;
    case 1292:
        thalf_x0 = 13933346;
        half_x03 = 11389709;
        break;
    case 1293:
        thalf_x0 = 13931259;
        half_x03 = 11384593;
        break;
    case 1294:
        thalf_x0 = 13929176;
        half_x03 = 11379486;
        break;
    case 1295:
        thalf_x0 = 13927094;
        half_x03 = 11374384;
        break;
    case 1296:
        thalf_x0 = 13925012;
        half_x03 = 11369284;
        break;
    case 1297:
        thalf_x0 = 13922930;
        half_x03 = 11364185;
        break;
    case 1298:
        thalf_x0 = 13920849;
        half_x03 = 11359091;
        break;
    case 1299:
        thalf_x0 = 13918769;
        half_x03 = 11353999;
        break;
    case 1300:
        thalf_x0 = 13916691;
        half_x03 = 11348916;
        break;
    case 1301:
        thalf_x0 = 13914614;
        half_x03 = 11343834;
        break;
    case 1302:
        thalf_x0 = 13912538;
        half_x03 = 11338757;
        break;
    case 1303:
        thalf_x0 = 13910462;
        half_x03 = 11333682;
        break;
    case 1304:
        thalf_x0 = 13908387;
        half_x03 = 11328612;
        break;
    case 1305:
        thalf_x0 = 13906313;
        half_x03 = 11323544;
        break;
    case 1306:
        thalf_x0 = 13904240;
        half_x03 = 11318481;
        break;
    case 1307:
        thalf_x0 = 13902167;
        half_x03 = 11313419;
        break;
    case 1308:
        thalf_x0 = 13900097;
        half_x03 = 11308366;
        break;
    case 1309:
        thalf_x0 = 13898027;
        half_x03 = 11303315;
        break;
    case 1310:
        thalf_x0 = 13895958;
        half_x03 = 11298269;
        break;
    case 1311:
        thalf_x0 = 13893890;
        half_x03 = 11293224;
        break;
    case 1312:
        thalf_x0 = 13891821;
        half_x03 = 11288181;
        break;
    case 1313:
        thalf_x0 = 13889756;
        half_x03 = 11283146;
        break;
    case 1314:
        thalf_x0 = 13887690;
        half_x03 = 11278113;
        break;
    case 1315:
        thalf_x0 = 13885625;
        half_x03 = 11273082;
        break;
    case 1316:
        thalf_x0 = 13883561;
        half_x03 = 11268056;
        break;
    case 1317:
        thalf_x0 = 13881498;
        half_x03 = 11263035;
        break;
    case 1318:
        thalf_x0 = 13879436;
        half_x03 = 11258015;
        break;
    case 1319:
        thalf_x0 = 13877375;
        half_x03 = 11253001;
        break;
    case 1320:
        thalf_x0 = 13875317;
        half_x03 = 11247995;
        break;
    case 1321:
        thalf_x0 = 13873256;
        half_x03 = 11242984;
        break;
    case 1322:
        thalf_x0 = 13871198;
        half_x03 = 11237981;
        break;
    case 1323:
        thalf_x0 = 13869141;
        half_x03 = 11232983;
        break;
    case 1324:
        thalf_x0 = 13867085;
        half_x03 = 11227987;
        break;
    case 1325:
        thalf_x0 = 13865030;
        half_x03 = 11222996;
        break;
    case 1326:
        thalf_x0 = 13862975;
        half_x03 = 11218007;
        break;
    case 1327:
        thalf_x0 = 13860921;
        half_x03 = 11213022;
        break;
    case 1328:
        thalf_x0 = 13858869;
        half_x03 = 11208043;
        break;
    case 1329:
        thalf_x0 = 13856817;
        half_x03 = 11203065;
        break;
    case 1330:
        thalf_x0 = 13854765;
        half_x03 = 11198089;
        break;
    case 1331:
        thalf_x0 = 13852715;
        half_x03 = 11193118;
        break;
    case 1332:
        thalf_x0 = 13850666;
        half_x03 = 11188152;
        break;
    case 1333:
        thalf_x0 = 13848618;
        half_x03 = 11183191;
        break;
    case 1334:
        thalf_x0 = 13846571;
        half_x03 = 11178231;
        break;
    case 1335:
        thalf_x0 = 13844525;
        half_x03 = 11173277;
        break;
    case 1336:
        thalf_x0 = 13842479;
        half_x03 = 11168324;
        break;
    case 1337:
        thalf_x0 = 13840434;
        half_x03 = 11163376;
        break;
    case 1338:
        thalf_x0 = 13838391;
        half_x03 = 11158433;
        break;
    case 1339:
        thalf_x0 = 13836348;
        half_x03 = 11153492;
        break;
    case 1340:
        thalf_x0 = 13834307;
        half_x03 = 11148556;
        break;
    case 1341:
        thalf_x0 = 13832265;
        half_x03 = 11143621;
        break;
    case 1342:
        thalf_x0 = 13830225;
        half_x03 = 11138691;
        break;
    case 1343:
        thalf_x0 = 13828187;
        half_x03 = 11133766;
        break;
    case 1344:
        thalf_x0 = 13826150;
        half_x03 = 11128847;
        break;
    case 1345:
        thalf_x0 = 13824111;
        half_x03 = 11123925;
        break;
    case 1346:
        thalf_x0 = 13822076;
        half_x03 = 11119012;
        break;
    case 1347:
        thalf_x0 = 13820039;
        half_x03 = 11114097;
        break;
    case 1348:
        thalf_x0 = 13818005;
        half_x03 = 11109190;
        break;
    case 1349:
        thalf_x0 = 13815971;
        half_x03 = 11104285;
        break;
    case 1350:
        thalf_x0 = 13813938;
        half_x03 = 11099385;
        break;
    case 1351:
        thalf_x0 = 13811906;
        half_x03 = 11094487;
        break;
    case 1352:
        thalf_x0 = 13809875;
        half_x03 = 11089593;
        break;
    case 1353:
        thalf_x0 = 13807845;
        half_x03 = 11084705;
        break;
    case 1354:
        thalf_x0 = 13805816;
        half_x03 = 11079818;
        break;
    case 1355:
        thalf_x0 = 13803788;
        half_x03 = 11074936;
        break;
    case 1356:
        thalf_x0 = 13801761;
        half_x03 = 11070059;
        break;
    case 1357:
        thalf_x0 = 13799733;
        half_x03 = 11065180;
        break;
    case 1358:
        thalf_x0 = 13797708;
        half_x03 = 11060309;
        break;
    case 1359:
        thalf_x0 = 13795683;
        half_x03 = 11055440;
        break;
    case 1360:
        thalf_x0 = 13793660;
        half_x03 = 11050576;
        break;
    case 1361:
        thalf_x0 = 13791638;
        half_x03 = 11045717;
        break;
    case 1362:
        thalf_x0 = 13789614;
        half_x03 = 11040856;
        break;
    case 1363:
        thalf_x0 = 13787594;
        half_x03 = 11036004;
        break;
    case 1364:
        thalf_x0 = 13785572;
        half_x03 = 11031149;
        break;
    case 1365:
        thalf_x0 = 13783554;
        half_x03 = 11026306;
        break;
    case 1366:
        thalf_x0 = 13781534;
        half_x03 = 11021458;
        break;
    case 1367:
        thalf_x0 = 13779518;
        half_x03 = 11016622;
        break;
    case 1368:
        thalf_x0 = 13777500;
        half_x03 = 11011784;
        break;
    case 1369:
        thalf_x0 = 13775484;
        half_x03 = 11006951;
        break;
    case 1370:
        thalf_x0 = 13773468;
        half_x03 = 11002119;
        break;
    case 1371:
        thalf_x0 = 13771457;
        half_x03 = 10997299;
        break;
    case 1372:
        thalf_x0 = 13769441;
        half_x03 = 10992470;
        break;
    case 1373:
        thalf_x0 = 13767431;
        half_x03 = 10987657;
        break;
    case 1374:
        thalf_x0 = 13765418;
        half_x03 = 10982838;
        break;
    case 1375:
        thalf_x0 = 13763408;
        half_x03 = 10978028;
        break;
    case 1376:
        thalf_x0 = 13761398;
        half_x03 = 10973219;
        break;
    case 1377:
        thalf_x0 = 13759389;
        half_x03 = 10968415;
        break;
    case 1378:
        thalf_x0 = 13757381;
        half_x03 = 10963612;
        break;
    case 1379:
        thalf_x0 = 13755375;
        half_x03 = 10958818;
        break;
    case 1380:
        thalf_x0 = 13753367;
        half_x03 = 10954018;
        break;
    case 1381:
        thalf_x0 = 13751363;
        half_x03 = 10949231;
        break;
    case 1382:
        thalf_x0 = 13749357;
        half_x03 = 10944441;
        break;
    case 1383:
        thalf_x0 = 13747355;
        half_x03 = 10939660;
        break;
    case 1384:
        thalf_x0 = 13745352;
        half_x03 = 10934880;
        break;
    case 1385:
        thalf_x0 = 13743350;
        half_x03 = 10930101;
        break;
    case 1386:
        thalf_x0 = 13741349;
        half_x03 = 10925328;
        break;
    case 1387:
        thalf_x0 = 13739349;
        half_x03 = 10920559;
        break;
    case 1388:
        thalf_x0 = 13737350;
        half_x03 = 10915792;
        break;
    case 1389:
        thalf_x0 = 13735352;
        half_x03 = 10911030;
        break;
    case 1390:
        thalf_x0 = 13733355;
        half_x03 = 10906273;
        break;
    case 1391:
        thalf_x0 = 13731357;
        half_x03 = 10901513;
        break;
    case 1392:
        thalf_x0 = 13729361;
        half_x03 = 10896759;
        break;
    case 1393:
        thalf_x0 = 13727367;
        half_x03 = 10892013;
        break;
    case 1394:
        thalf_x0 = 13725374;
        half_x03 = 10887268;
        break;
    case 1395:
        thalf_x0 = 13723379;
        half_x03 = 10882522;
        break;
    case 1396:
        thalf_x0 = 13721387;
        half_x03 = 10877784;
        break;
    case 1397:
        thalf_x0 = 13719398;
        half_x03 = 10873054;
        break;
    case 1398:
        thalf_x0 = 13717406;
        half_x03 = 10868318;
        break;
    case 1399:
        thalf_x0 = 13715415;
        half_x03 = 10863588;
        break;
    case 1400:
        thalf_x0 = 13713428;
        half_x03 = 10858866;
        break;
    case 1401:
        thalf_x0 = 13711440;
        half_x03 = 10854145;
        break;
    case 1402:
        thalf_x0 = 13709453;
        half_x03 = 10849426;
        break;
    case 1403:
        thalf_x0 = 13707467;
        half_x03 = 10844711;
        break;
    case 1404:
        thalf_x0 = 13705481;
        half_x03 = 10839998;
        break;
    case 1405:
        thalf_x0 = 13703498;
        half_x03 = 10835294;
        break;
    case 1406:
        thalf_x0 = 13701513;
        half_x03 = 10830587;
        break;
    case 1407:
        thalf_x0 = 13699530;
        half_x03 = 10825885;
        break;
    case 1408:
        thalf_x0 = 13697549;
        half_x03 = 10821188;
        break;
    case 1409:
        thalf_x0 = 13695567;
        half_x03 = 10816493;
        break;
    case 1410:
        thalf_x0 = 13693587;
        half_x03 = 10811802;
        break;
    case 1411:
        thalf_x0 = 13691607;
        half_x03 = 10807113;
        break;
    case 1412:
        thalf_x0 = 13689630;
        half_x03 = 10802432;
        break;
    case 1413:
        thalf_x0 = 13687653;
        half_x03 = 10797753;
        break;
    case 1414:
        thalf_x0 = 13685676;
        half_x03 = 10793075;
        break;
    case 1415:
        thalf_x0 = 13683699;
        half_x03 = 10788398;
        break;
    case 1416:
        thalf_x0 = 13681724;
        half_x03 = 10783726;
        break;
    case 1417:
        thalf_x0 = 13679750;
        half_x03 = 10779059;
        break;
    case 1418:
        thalf_x0 = 13677777;
        half_x03 = 10774397;
        break;
    case 1419:
        thalf_x0 = 13675806;
        half_x03 = 10769740;
        break;
    case 1420:
        thalf_x0 = 13673834;
        half_x03 = 10765081;
        break;
    case 1421:
        thalf_x0 = 13671864;
        half_x03 = 10760430;
        break;
    case 1422:
        thalf_x0 = 13669892;
        half_x03 = 10755773;
        break;
    case 1423:
        thalf_x0 = 13667924;
        half_x03 = 10751128;
        break;
    case 1424:
        thalf_x0 = 13665956;
        half_x03 = 10746485;
        break;
    case 1425:
        thalf_x0 = 13663988;
        half_x03 = 10741843;
        break;
    case 1426:
        thalf_x0 = 13662023;
        half_x03 = 10737209;
        break;
    case 1427:
        thalf_x0 = 13660056;
        half_x03 = 10732573;
        break;
    case 1428:
        thalf_x0 = 13658093;
        half_x03 = 10727946;
        break;
    case 1429:
        thalf_x0 = 13656128;
        half_x03 = 10723316;
        break;
    case 1430:
        thalf_x0 = 13654164;
        half_x03 = 10718691;
        break;
    case 1431:
        thalf_x0 = 13652202;
        half_x03 = 10714071;
        break;
    case 1432:
        thalf_x0 = 13650242;
        half_x03 = 10709456;
        break;
    case 1433:
        thalf_x0 = 13648281;
        half_x03 = 10704843;
        break;
    case 1434:
        thalf_x0 = 13646321;
        half_x03 = 10700230;
        break;
    case 1435:
        thalf_x0 = 13644362;
        half_x03 = 10695623;
        break;
    case 1436:
        thalf_x0 = 13642403;
        half_x03 = 10691016;
        break;
    case 1437:
        thalf_x0 = 13640447;
        half_x03 = 10686418;
        break;
    case 1438:
        thalf_x0 = 13638489;
        half_x03 = 10681818;
        break;
    case 1439:
        thalf_x0 = 13636535;
        half_x03 = 10677227;
        break;
    case 1440:
        thalf_x0 = 13634580;
        half_x03 = 10672636;
        break;
    case 1441:
        thalf_x0 = 13632627;
        half_x03 = 10668051;
        break;
    case 1442:
        thalf_x0 = 13630674;
        half_x03 = 10663467;
        break;
    case 1443:
        thalf_x0 = 13628721;
        half_x03 = 10658884;
        break;
    case 1444:
        thalf_x0 = 13626770;
        half_x03 = 10654306;
        break;
    case 1445:
        thalf_x0 = 13624820;
        half_x03 = 10649732;
        break;
    case 1446:
        thalf_x0 = 13622871;
        half_x03 = 10645164;
        break;
    case 1447:
        thalf_x0 = 13620921;
        half_x03 = 10640593;
        break;
    case 1448:
        thalf_x0 = 13618973;
        half_x03 = 10636027;
        break;
    case 1449:
        thalf_x0 = 13617027;
        half_x03 = 10631470;
        break;
    case 1450:
        thalf_x0 = 13615079;
        half_x03 = 10626907;
        break;
    case 1451:
        thalf_x0 = 13613135;
        half_x03 = 10622355;
        break;
    case 1452:
        thalf_x0 = 13611191;
        half_x03 = 10617805;
        break;
    case 1453:
        thalf_x0 = 13609247;
        half_x03 = 10613257;
        break;
    case 1454:
        thalf_x0 = 13607303;
        half_x03 = 10608709;
        break;
    case 1455:
        thalf_x0 = 13605362;
        half_x03 = 10604170;
        break;
    case 1456:
        thalf_x0 = 13603419;
        half_x03 = 10599629;
        break;
    case 1457:
        thalf_x0 = 13601480;
        half_x03 = 10595095;
        break;
    case 1458:
        thalf_x0 = 13599540;
        half_x03 = 10590564;
        break;
    case 1459:
        thalf_x0 = 13597601;
        half_x03 = 10586033;
        break;
    case 1460:
        thalf_x0 = 13595663;
        half_x03 = 10581507;
        break;
    case 1461:
        thalf_x0 = 13593726;
        half_x03 = 10576987;
        break;
    case 1462:
        thalf_x0 = 13591790;
        half_x03 = 10572467;
        break;
    case 1463:
        thalf_x0 = 13589855;
        half_x03 = 10567952;
        break;
    case 1464:
        thalf_x0 = 13587920;
        half_x03 = 10563439;
        break;
    case 1465:
        thalf_x0 = 13585985;
        half_x03 = 10558926;
        break;
    case 1466:
        thalf_x0 = 13584053;
        half_x03 = 10554422;
        break;
    case 1467:
        thalf_x0 = 13582121;
        half_x03 = 10549920;
        break;
    case 1468:
        thalf_x0 = 13580189;
        half_x03 = 10545418;
        break;
    case 1469:
        thalf_x0 = 13578260;
        half_x03 = 10540925;
        break;
    case 1470:
        thalf_x0 = 13576329;
        half_x03 = 10536430;
        break;
    case 1471:
        thalf_x0 = 13574402;
        half_x03 = 10531943;
        break;
    case 1472:
        thalf_x0 = 13572473;
        half_x03 = 10527453;
        break;
    case 1473:
        thalf_x0 = 13570545;
        half_x03 = 10522969;
        break;
    case 1474:
        thalf_x0 = 13568618;
        half_x03 = 10518486;
        break;
    case 1475:
        thalf_x0 = 13566692;
        half_x03 = 10514007;
        break;
    case 1476:
        thalf_x0 = 13564769;
        half_x03 = 10509537;
        break;
    case 1477:
        thalf_x0 = 13562846;
        half_x03 = 10505068;
        break;
    case 1478:
        thalf_x0 = 13560921;
        half_x03 = 10500597;
        break;
    case 1479:
        thalf_x0 = 13559000;
        half_x03 = 10496134;
        break;
    case 1480:
        thalf_x0 = 13557078;
        half_x03 = 10491672;
        break;
    case 1481:
        thalf_x0 = 13555157;
        half_x03 = 10487212;
        break;
    case 1482:
        thalf_x0 = 13553237;
        half_x03 = 10482756;
        break;
    case 1483:
        thalf_x0 = 13551318;
        half_x03 = 10478305;
        break;
    case 1484:
        thalf_x0 = 13549398;
        half_x03 = 10473852;
        break;
    case 1485:
        thalf_x0 = 13547483;
        half_x03 = 10469410;
        break;
    case 1486:
        thalf_x0 = 13545564;
        half_x03 = 10464963;
        break;
    case 1487:
        thalf_x0 = 13543649;
        half_x03 = 10460524;
        break;
    case 1488:
        thalf_x0 = 13541735;
        half_x03 = 10456090;
        break;
    case 1489:
        thalf_x0 = 13539821;
        half_x03 = 10451657;
        break;
    case 1490:
        thalf_x0 = 13537907;
        half_x03 = 10447225;
        break;
    case 1491:
        thalf_x0 = 13535996;
        half_x03 = 10442801;
        break;
    case 1492:
        thalf_x0 = 13534083;
        half_x03 = 10438376;
        break;
    case 1493:
        thalf_x0 = 13532172;
        half_x03 = 10433955;
        break;
    case 1494:
        thalf_x0 = 13530261;
        half_x03 = 10429535;
        break;
    case 1495:
        thalf_x0 = 13528353;
        half_x03 = 10425123;
        break;
    case 1496:
        thalf_x0 = 13526445;
        half_x03 = 10420713;
        break;
    case 1497:
        thalf_x0 = 13524537;
        half_x03 = 10416304;
        break;
    case 1498:
        thalf_x0 = 13522629;
        half_x03 = 10411896;
        break;
    case 1499:
        thalf_x0 = 13520724;
        half_x03 = 10407496;
        break;
    case 1500:
        thalf_x0 = 13518818;
        half_x03 = 10403094;
        break;
    case 1501:
        thalf_x0 = 13516914;
        half_x03 = 10398701;
        break;
    case 1502:
        thalf_x0 = 13515011;
        half_x03 = 10394308;
        break;
    case 1503:
        thalf_x0 = 13513107;
        half_x03 = 10389917;
        break;
    case 1504:
        thalf_x0 = 13511205;
        half_x03 = 10385530;
        break;
    case 1505:
        thalf_x0 = 13509305;
        half_x03 = 10381148;
        break;
    case 1506:
        thalf_x0 = 13507403;
        half_x03 = 10376764;
        break;
    case 1507:
        thalf_x0 = 13505505;
        half_x03 = 10372392;
        break;
    case 1508:
        thalf_x0 = 13503605;
        half_x03 = 10368013;
        break;
    case 1509:
        thalf_x0 = 13501707;
        half_x03 = 10363643;
        break;
    case 1510:
        thalf_x0 = 13499810;
        half_x03 = 10359274;
        break;
    case 1511:
        thalf_x0 = 13497914;
        half_x03 = 10354910;
        break;
    case 1512:
        thalf_x0 = 13496018;
        half_x03 = 10350547;
        break;
    case 1513:
        thalf_x0 = 13494123;
        half_x03 = 10346189;
        break;
    case 1514:
        thalf_x0 = 13492229;
        half_x03 = 10341832;
        break;
    case 1515:
        thalf_x0 = 13490336;
        half_x03 = 10337480;
        break;
    case 1516:
        thalf_x0 = 13488443;
        half_x03 = 10333129;
        break;
    case 1517:
        thalf_x0 = 13486551;
        half_x03 = 10328782;
        break;
    case 1518:
        thalf_x0 = 13484661;
        half_x03 = 10324440;
        break;
    case 1519:
        thalf_x0 = 13482771;
        half_x03 = 10320100;
        break;
    case 1520:
        thalf_x0 = 13480881;
        half_x03 = 10315760;
        break;
    case 1521:
        thalf_x0 = 13478993;
        half_x03 = 10311426;
        break;
    case 1522:
        thalf_x0 = 13477106;
        half_x03 = 10307096;
        break;
    case 1523:
        thalf_x0 = 13475219;
        half_x03 = 10302767;
        break;
    case 1524:
        thalf_x0 = 13473333;
        half_x03 = 10298443;
        break;
    case 1525:
        thalf_x0 = 13471448;
        half_x03 = 10294120;
        break;
    case 1526:
        thalf_x0 = 13469564;
        half_x03 = 10289801;
        break;
    case 1527:
        thalf_x0 = 13467680;
        half_x03 = 10285484;
        break;
    case 1528:
        thalf_x0 = 13465796;
        half_x03 = 10281168;
        break;
    case 1529:
        thalf_x0 = 13463913;
        half_x03 = 10276857;
        break;
    case 1530:
        thalf_x0 = 13462032;
        half_x03 = 10272550;
        break;
    case 1531:
        thalf_x0 = 13460151;
        half_x03 = 10268245;
        break;
    case 1532:
        thalf_x0 = 13458272;
        half_x03 = 10263944;
        break;
    case 1533:
        thalf_x0 = 13456394;
        half_x03 = 10259648;
        break;
    case 1534:
        thalf_x0 = 13454516;
        half_x03 = 10255353;
        break;
    case 1535:
        thalf_x0 = 13452638;
        half_x03 = 10251059;
        break;
    case 1536:
        thalf_x0 = 13450760;
        half_x03 = 10246767;
        break;
    case 1537:
        thalf_x0 = 13448886;
        half_x03 = 10242485;
        break;
    case 1538:
        thalf_x0 = 13447010;
        half_x03 = 10238199;
        break;
    case 1539:
        thalf_x0 = 13445136;
        half_x03 = 10233920;
        break;
    case 1540:
        thalf_x0 = 13443263;
        half_x03 = 10229642;
        break;
    case 1541:
        thalf_x0 = 13441391;
        half_x03 = 10225370;
        break;
    case 1542:
        thalf_x0 = 13439519;
        half_x03 = 10221098;
        break;
    case 1543:
        thalf_x0 = 13437647;
        half_x03 = 10216827;
        break;
    case 1544:
        thalf_x0 = 13435775;
        half_x03 = 10212558;
        break;
    case 1545:
        thalf_x0 = 13433906;
        half_x03 = 10208297;
        break;
    case 1546:
        thalf_x0 = 13432037;
        half_x03 = 10204037;
        break;
    case 1547:
        thalf_x0 = 13430171;
        half_x03 = 10199785;
        break;
    case 1548:
        thalf_x0 = 13428302;
        half_x03 = 10195527;
        break;
    case 1549:
        thalf_x0 = 13426436;
        half_x03 = 10191277;
        break;
    case 1550:
        thalf_x0 = 13424570;
        half_x03 = 10187028;
        break;
    case 1551:
        thalf_x0 = 13422705;
        half_x03 = 10182785;
        break;
    case 1552:
        thalf_x0 = 13420841;
        half_x03 = 10178542;
        break;
    case 1553:
        thalf_x0 = 13418978;
        half_x03 = 10174304;
        break;
    case 1554:
        thalf_x0 = 13417115;
        half_x03 = 10170067;
        break;
    case 1555:
        thalf_x0 = 13415253;
        half_x03 = 10165834;
        break;
    case 1556:
        thalf_x0 = 13413393;
        half_x03 = 10161606;
        break;
    case 1557:
        thalf_x0 = 13411533;
        half_x03 = 10157380;
        break;
    case 1558:
        thalf_x0 = 13409673;
        half_x03 = 10153154;
        break;
    case 1559:
        thalf_x0 = 13407813;
        half_x03 = 10148930;
        break;
    case 1560:
        thalf_x0 = 13405956;
        half_x03 = 10144714;
        break;
    case 1561:
        thalf_x0 = 13404099;
        half_x03 = 10140498;
        break;
    case 1562:
        thalf_x0 = 13402242;
        half_x03 = 10136284;
        break;
    case 1563:
        thalf_x0 = 13400387;
        half_x03 = 10132075;
        break;
    case 1564:
        thalf_x0 = 13398531;
        half_x03 = 10127867;
        break;
    case 1565:
        thalf_x0 = 13396677;
        half_x03 = 10123663;
        break;
    case 1566:
        thalf_x0 = 13394825;
        half_x03 = 10119464;
        break;
    case 1567:
        thalf_x0 = 13392971;
        half_x03 = 10115262;
        break;
    case 1568:
        thalf_x0 = 13391121;
        half_x03 = 10111073;
        break;
    case 1569:
        thalf_x0 = 13389269;
        half_x03 = 10106877;
        break;
    case 1570:
        thalf_x0 = 13387419;
        half_x03 = 10102689;
        break;
    case 1571:
        thalf_x0 = 13385570;
        half_x03 = 10098503;
        break;
    case 1572:
        thalf_x0 = 13383722;
        half_x03 = 10094321;
        break;
    case 1573:
        thalf_x0 = 13381874;
        half_x03 = 10090140;
        break;
    case 1574:
        thalf_x0 = 13380026;
        half_x03 = 10085960;
        break;
    case 1575:
        thalf_x0 = 13378179;
        half_x03 = 10081785;
        break;
    case 1576:
        thalf_x0 = 13376333;
        half_x03 = 10077611;
        break;
    case 1577:
        thalf_x0 = 13374489;
        half_x03 = 10073445;
        break;
    case 1578:
        thalf_x0 = 13372646;
        half_x03 = 10069280;
        break;
    case 1579:
        thalf_x0 = 13370801;
        half_x03 = 10065113;
        break;
    case 1580:
        thalf_x0 = 13368959;
        half_x03 = 10060954;
        break;
    case 1581:
        thalf_x0 = 13367117;
        half_x03 = 10056796;
        break;
    case 1582:
        thalf_x0 = 13365276;
        half_x03 = 10052642;
        break;
    case 1583:
        thalf_x0 = 13363436;
        half_x03 = 10048490;
        break;
    case 1584:
        thalf_x0 = 13361595;
        half_x03 = 10044338;
        break;
    case 1585:
        thalf_x0 = 13359758;
        half_x03 = 10040195;
        break;
    case 1586:
        thalf_x0 = 13357919;
        half_x03 = 10036049;
        break;
    case 1587:
        thalf_x0 = 13356081;
        half_x03 = 10031908;
        break;
    case 1588:
        thalf_x0 = 13354245;
        half_x03 = 10027772;
        break;
    case 1589:
        thalf_x0 = 13352409;
        half_x03 = 10023636;
        break;
    case 1590:
        thalf_x0 = 13350573;
        half_x03 = 10019502;
        break;
    case 1591:
        thalf_x0 = 13348740;
        half_x03 = 10015376;
        break;
    case 1592:
        thalf_x0 = 13346907;
        half_x03 = 10011250;
        break;
    case 1593:
        thalf_x0 = 13345074;
        half_x03 = 10007126;
        break;
    case 1594:
        thalf_x0 = 13343241;
        half_x03 = 10003003;
        break;
    case 1595:
        thalf_x0 = 13341410;
        half_x03 = 9998885;
        break;
    case 1596:
        thalf_x0 = 13339580;
        half_x03 = 9994771;
        break;
    case 1597:
        thalf_x0 = 13337750;
        half_x03 = 9990658;
        break;
    case 1598:
        thalf_x0 = 13335921;
        half_x03 = 9986550;
        break;
    case 1599:
        thalf_x0 = 13334094;
        half_x03 = 9982446;
        break;
    case 1600:
        thalf_x0 = 13332266;
        half_x03 = 9978340;
        break;
    case 1601:
        thalf_x0 = 13330440;
        half_x03 = 9974241;
        break;
    case 1602:
        thalf_x0 = 13328612;
        half_x03 = 9970138;
        break;
    case 1603:
        thalf_x0 = 13326788;
        half_x03 = 9966045;
        break;
    case 1604:
        thalf_x0 = 13324964;
        half_x03 = 9961953;
        break;
    case 1605:
        thalf_x0 = 13323140;
        half_x03 = 9957863;
        break;
    case 1606:
        thalf_x0 = 13321316;
        half_x03 = 9953774;
        break;
    case 1607:
        thalf_x0 = 13319495;
        half_x03 = 9949692;
        break;
    case 1608:
        thalf_x0 = 13317672;
        half_x03 = 9945609;
        break;
    case 1609:
        thalf_x0 = 13315853;
        half_x03 = 9941533;
        break;
    case 1610:
        thalf_x0 = 13314033;
        half_x03 = 9937458;
        break;
    case 1611:
        thalf_x0 = 13312212;
        half_x03 = 9933381;
        break;
    case 1612:
        thalf_x0 = 13310394;
        half_x03 = 9929312;
        break;
    case 1613:
        thalf_x0 = 13308578;
        half_x03 = 9925247;
        break;
    case 1614:
        thalf_x0 = 13306760;
        half_x03 = 9921180;
        break;
    case 1615:
        thalf_x0 = 13304945;
        half_x03 = 9917121;
        break;
    case 1616:
        thalf_x0 = 13303128;
        half_x03 = 9913060;
        break;
    case 1617:
        thalf_x0 = 13301313;
        half_x03 = 9909003;
        break;
    case 1618:
        thalf_x0 = 13299500;
        half_x03 = 9904951;
        break;
    case 1619:
        thalf_x0 = 13297686;
        half_x03 = 9900899;
        break;
    case 1620:
        thalf_x0 = 13295873;
        half_x03 = 9896849;
        break;
    case 1621:
        thalf_x0 = 13294061;
        half_x03 = 9892803;
        break;
    case 1622:
        thalf_x0 = 13292252;
        half_x03 = 9888765;
        break;
    case 1623:
        thalf_x0 = 13290441;
        half_x03 = 9884725;
        break;
    case 1624:
        thalf_x0 = 13288631;
        half_x03 = 9880686;
        break;
    case 1625:
        thalf_x0 = 13286822;
        half_x03 = 9876651;
        break;
    case 1626:
        thalf_x0 = 13285014;
        half_x03 = 9872621;
        break;
    case 1627:
        thalf_x0 = 13283207;
        half_x03 = 9868592;
        break;
    case 1628:
        thalf_x0 = 13281401;
        half_x03 = 9864567;
        break;
    case 1629:
        thalf_x0 = 13279595;
        half_x03 = 9860544;
        break;
    case 1630:
        thalf_x0 = 13277789;
        half_x03 = 9856521;
        break;
    case 1631:
        thalf_x0 = 13275984;
        half_x03 = 9852503;
        break;
    case 1632:
        thalf_x0 = 13274181;
        half_x03 = 9848489;
        break;
    case 1633:
        thalf_x0 = 13272377;
        half_x03 = 9844474;
        break;
    case 1634:
        thalf_x0 = 13270577;
        half_x03 = 9840469;
        break;
    case 1635:
        thalf_x0 = 13268775;
        half_x03 = 9836462;
        break;
    case 1636:
        thalf_x0 = 13266974;
        half_x03 = 9832456;
        break;
    case 1637:
        thalf_x0 = 13265174;
        half_x03 = 9828454;
        break;
    case 1638:
        thalf_x0 = 13263374;
        half_x03 = 9824454;
        break;
    case 1639:
        thalf_x0 = 13261575;
        half_x03 = 9820458;
        break;
    case 1640:
        thalf_x0 = 13259777;
        half_x03 = 9816463;
        break;
    case 1641:
        thalf_x0 = 13257981;
        half_x03 = 9812476;
        break;
    case 1642:
        thalf_x0 = 13256186;
        half_x03 = 9808490;
        break;
    case 1643:
        thalf_x0 = 13254389;
        half_x03 = 9804501;
        break;
    case 1644:
        thalf_x0 = 13252593;
        half_x03 = 9800517;
        break;
    case 1645:
        thalf_x0 = 13250799;
        half_x03 = 9796538;
        break;
    case 1646:
        thalf_x0 = 13249007;
        half_x03 = 9792563;
        break;
    case 1647:
        thalf_x0 = 13247213;
        half_x03 = 9788585;
        break;
    case 1648:
        thalf_x0 = 13245422;
        half_x03 = 9784616;
        break;
    case 1649:
        thalf_x0 = 13243631;
        half_x03 = 9780647;
        break;
    case 1650:
        thalf_x0 = 13241840;
        half_x03 = 9776679;
        break;
    case 1651:
        thalf_x0 = 13240049;
        half_x03 = 9772713;
        break;
    case 1652:
        thalf_x0 = 13238261;
        half_x03 = 9768754;
        break;
    case 1653:
        thalf_x0 = 13236471;
        half_x03 = 9764793;
        break;
    case 1654:
        thalf_x0 = 13234685;
        half_x03 = 9760840;
        break;
    case 1655:
        thalf_x0 = 13232898;
        half_x03 = 9756888;
        break;
    case 1656:
        thalf_x0 = 13231112;
        half_x03 = 9752937;
        break;
    case 1657:
        thalf_x0 = 13229327;
        half_x03 = 9748990;
        break;
    case 1658:
        thalf_x0 = 13227542;
        half_x03 = 9745044;
        break;
    case 1659:
        thalf_x0 = 13225757;
        half_x03 = 9741100;
        break;
    case 1660:
        thalf_x0 = 13223975;
        half_x03 = 9737163;
        break;
    case 1661:
        thalf_x0 = 13222191;
        half_x03 = 9733224;
        break;
    case 1662:
        thalf_x0 = 13220409;
        half_x03 = 9729289;
        break;
    case 1663:
        thalf_x0 = 13218629;
        half_x03 = 9725358;
        break;
    case 1664:
        thalf_x0 = 13216850;
        half_x03 = 9721432;
        break;
    case 1665:
        thalf_x0 = 13215068;
        half_x03 = 9717501;
        break;
    case 1666:
        thalf_x0 = 13213290;
        half_x03 = 9713580;
        break;
    case 1667:
        thalf_x0 = 13211511;
        half_x03 = 9709657;
        break;
    case 1668:
        thalf_x0 = 13209734;
        half_x03 = 9705738;
        break;
    case 1669:
        thalf_x0 = 13207958;
        half_x03 = 9701824;
        break;
    case 1670:
        thalf_x0 = 13206182;
        half_x03 = 9697911;
        break;
    case 1671:
        thalf_x0 = 13204406;
        half_x03 = 9693999;
        break;
    case 1672:
        thalf_x0 = 13202631;
        half_x03 = 9690091;
        break;
    case 1673:
        thalf_x0 = 13200857;
        half_x03 = 9686185;
        break;
    case 1674:
        thalf_x0 = 13199082;
        half_x03 = 9682279;
        break;
    case 1675:
        thalf_x0 = 13197311;
        half_x03 = 9678381;
        break;
    case 1676:
        thalf_x0 = 13195541;
        half_x03 = 9674488;
        break;
    case 1677:
        thalf_x0 = 13193769;
        half_x03 = 9670592;
        break;
    case 1678:
        thalf_x0 = 13191998;
        half_x03 = 9666697;
        break;
    case 1679:
        thalf_x0 = 13190228;
        half_x03 = 9662806;
        break;
    case 1680:
        thalf_x0 = 13188459;
        half_x03 = 9658920;
        break;
    case 1681:
        thalf_x0 = 13186691;
        half_x03 = 9655035;
        break;
    case 1682:
        thalf_x0 = 13184924;
        half_x03 = 9651154;
        break;
    case 1683:
        thalf_x0 = 13183157;
        half_x03 = 9647275;
        break;
    case 1684:
        thalf_x0 = 13181391;
        half_x03 = 9643399;
        break;
    case 1685:
        thalf_x0 = 13179626;
        half_x03 = 9639525;
        break;
    case 1686:
        thalf_x0 = 13177862;
        half_x03 = 9635655;
        break;
    case 1687:
        thalf_x0 = 13176098;
        half_x03 = 9631786;
        break;
    case 1688:
        thalf_x0 = 13174334;
        half_x03 = 9627918;
        break;
    case 1689:
        thalf_x0 = 13172571;
        half_x03 = 9624054;
        break;
    case 1690:
        thalf_x0 = 13170809;
        half_x03 = 9620192;
        break;
    case 1691:
        thalf_x0 = 13169048;
        half_x03 = 9616333;
        break;
    case 1692:
        thalf_x0 = 13167287;
        half_x03 = 9612476;
        break;
    case 1693:
        thalf_x0 = 13165527;
        half_x03 = 9608623;
        break;
    case 1694:
        thalf_x0 = 13163768;
        half_x03 = 9604771;
        break;
    case 1695:
        thalf_x0 = 13162010;
        half_x03 = 9600924;
        break;
    case 1696:
        thalf_x0 = 13160253;
        half_x03 = 9597080;
        break;
    case 1697:
        thalf_x0 = 13158495;
        half_x03 = 9593235;
        break;
    case 1698:
        thalf_x0 = 13156739;
        half_x03 = 9589394;
        break;
    case 1699:
        thalf_x0 = 13154985;
        half_x03 = 9585560;
        break;
    case 1700:
        thalf_x0 = 13153229;
        half_x03 = 9581721;
        break;
    case 1701:
        thalf_x0 = 13151475;
        half_x03 = 9577889;
        break;
    case 1702:
        thalf_x0 = 13149722;
        half_x03 = 9574059;
        break;
    case 1703:
        thalf_x0 = 13147970;
        half_x03 = 9570232;
        break;
    case 1704:
        thalf_x0 = 13146218;
        half_x03 = 9566407;
        break;
    case 1705:
        thalf_x0 = 13144466;
        half_x03 = 9562583;
        break;
    case 1706:
        thalf_x0 = 13142715;
        half_x03 = 9558763;
        break;
    case 1707:
        thalf_x0 = 13140965;
        half_x03 = 9554944;
        break;
    case 1708:
        thalf_x0 = 13139216;
        half_x03 = 9551129;
        break;
    case 1709:
        thalf_x0 = 13137467;
        half_x03 = 9547316;
        break;
    case 1710:
        thalf_x0 = 13135719;
        half_x03 = 9543506;
        break;
    case 1711:
        thalf_x0 = 13133972;
        half_x03 = 9539698;
        break;
    case 1712:
        thalf_x0 = 13132226;
        half_x03 = 9535894;
        break;
    case 1713:
        thalf_x0 = 13130480;
        half_x03 = 9532091;
        break;
    case 1714:
        thalf_x0 = 13128735;
        half_x03 = 9528292;
        break;
    case 1715:
        thalf_x0 = 13126991;
        half_x03 = 9524494;
        break;
    case 1716:
        thalf_x0 = 13125248;
        half_x03 = 9520701;
        break;
    case 1717:
        thalf_x0 = 13123505;
        half_x03 = 9516908;
        break;
    case 1718:
        thalf_x0 = 13121762;
        half_x03 = 9513117;
        break;
    case 1719:
        thalf_x0 = 13120020;
        half_x03 = 9509330;
        break;
    case 1720:
        thalf_x0 = 13118279;
        half_x03 = 9505544;
        break;
    case 1721:
        thalf_x0 = 13116539;
        half_x03 = 9501762;
        break;
    case 1722:
        thalf_x0 = 13114799;
        half_x03 = 9497981;
        break;
    case 1723:
        thalf_x0 = 13113062;
        half_x03 = 9494207;
        break;
    case 1724:
        thalf_x0 = 13111323;
        half_x03 = 9490432;
        break;
    case 1725:
        thalf_x0 = 13109586;
        half_x03 = 9486660;
        break;
    case 1726:
        thalf_x0 = 13107849;
        half_x03 = 9482890;
        break;
    case 1727:
        thalf_x0 = 13106114;
        half_x03 = 9479124;
        break;
    case 1728:
        thalf_x0 = 13104377;
        half_x03 = 9475355;
        break;
    case 1729:
        thalf_x0 = 13102643;
        half_x03 = 9471594;
        break;
    case 1730:
        thalf_x0 = 13100909;
        half_x03 = 9467834;
        break;
    case 1731:
        thalf_x0 = 13099176;
        half_x03 = 9464079;
        break;
    case 1732:
        thalf_x0 = 13097444;
        half_x03 = 9460324;
        break;
    case 1733:
        thalf_x0 = 13095710;
        half_x03 = 9456567;
        break;
    case 1734:
        thalf_x0 = 13093980;
        half_x03 = 9452821;
        break;
    case 1735:
        thalf_x0 = 13092249;
        half_x03 = 9449073;
        break;
    case 1736:
        thalf_x0 = 13090520;
        half_x03 = 9445328;
        break;
    case 1737:
        thalf_x0 = 13088790;
        half_x03 = 9441585;
        break;
    case 1738:
        thalf_x0 = 13087062;
        half_x03 = 9437846;
        break;
    case 1739:
        thalf_x0 = 13085334;
        half_x03 = 9434108;
        break;
    case 1740:
        thalf_x0 = 13083606;
        half_x03 = 9430371;
        break;
    case 1741:
        thalf_x0 = 13081881;
        half_x03 = 9426642;
        break;
    case 1742:
        thalf_x0 = 13080155;
        half_x03 = 9422910;
        break;
    case 1743:
        thalf_x0 = 13078430;
        half_x03 = 9419182;
        break;
    case 1744:
        thalf_x0 = 13076705;
        half_x03 = 9415456;
        break;
    case 1745:
        thalf_x0 = 13074983;
        half_x03 = 9411737;
        break;
    case 1746:
        thalf_x0 = 13073259;
        half_x03 = 9408015;
        break;
    case 1747:
        thalf_x0 = 13071537;
        half_x03 = 9404298;
        break;
    case 1748:
        thalf_x0 = 13069815;
        half_x03 = 9400582;
        break;
    case 1749:
        thalf_x0 = 13068095;
        half_x03 = 9396870;
        break;
    case 1750:
        thalf_x0 = 13066373;
        half_x03 = 9393156;
        break;
    case 1751:
        thalf_x0 = 13064654;
        half_x03 = 9389449;
        break;
    case 1752:
        thalf_x0 = 13062935;
        half_x03 = 9385743;
        break;
    case 1753:
        thalf_x0 = 13061217;
        half_x03 = 9382042;
        break;
    case 1754:
        thalf_x0 = 13059500;
        half_x03 = 9378341;
        break;
    case 1755:
        thalf_x0 = 13057784;
        half_x03 = 9374645;
        break;
    case 1756:
        thalf_x0 = 13056068;
        half_x03 = 9370949;
        break;
    case 1757:
        thalf_x0 = 13054352;
        half_x03 = 9367255;
        break;
    case 1758:
        thalf_x0 = 13052636;
        half_x03 = 9363561;
        break;
    case 1759:
        thalf_x0 = 13050921;
        half_x03 = 9359872;
        break;
    case 1760:
        thalf_x0 = 13049208;
        half_x03 = 9356187;
        break;
    case 1761:
        thalf_x0 = 13047495;
        half_x03 = 9352503;
        break;
    case 1762:
        thalf_x0 = 13045784;
        half_x03 = 9348823;
        break;
    case 1763:
        thalf_x0 = 13044071;
        half_x03 = 9345140;
        break;
    case 1764:
        thalf_x0 = 13042361;
        half_x03 = 9341466;
        break;
    case 1765:
        thalf_x0 = 13040651;
        half_x03 = 9337792;
        break;
    case 1766:
        thalf_x0 = 13038941;
        half_x03 = 9334119;
        break;
    case 1767:
        thalf_x0 = 13037232;
        half_x03 = 9330450;
        break;
    case 1768:
        thalf_x0 = 13035525;
        half_x03 = 9326786;
        break;
    case 1769:
        thalf_x0 = 13033817;
        half_x03 = 9323119;
        break;
    case 1770:
        thalf_x0 = 13032111;
        half_x03 = 9319460;
        break;
    case 1771:
        thalf_x0 = 13030403;
        half_x03 = 9315795;
        break;
    case 1772:
        thalf_x0 = 13028699;
        half_x03 = 9312140;
        break;
    case 1773:
        thalf_x0 = 13026995;
        half_x03 = 9308487;
        break;
    case 1774:
        thalf_x0 = 13025289;
        half_x03 = 9304832;
        break;
    case 1775:
        thalf_x0 = 13023587;
        half_x03 = 9301184;
        break;
    case 1776:
        thalf_x0 = 13021883;
        half_x03 = 9297533;
        break;
    case 1777:
        thalf_x0 = 13020182;
        half_x03 = 9293890;
        break;
    case 1778:
        thalf_x0 = 13018479;
        half_x03 = 9290245;
        break;
    case 1779:
        thalf_x0 = 13016780;
        half_x03 = 9286607;
        break;
    case 1780:
        thalf_x0 = 13015079;
        half_x03 = 9282967;
        break;
    case 1781:
        thalf_x0 = 13013379;
        half_x03 = 9279331;
        break;
    case 1782:
        thalf_x0 = 13011681;
        half_x03 = 9275699;
        break;
    case 1783:
        thalf_x0 = 13009983;
        half_x03 = 9272068;
        break;
    case 1784:
        thalf_x0 = 13008285;
        half_x03 = 9268438;
        break;
    case 1785:
        thalf_x0 = 13006589;
        half_x03 = 9264812;
        break;
    case 1786:
        thalf_x0 = 13004892;
        half_x03 = 9261187;
        break;
    case 1787:
        thalf_x0 = 13003197;
        half_x03 = 9257567;
        break;
    case 1788:
        thalf_x0 = 13001502;
        half_x03 = 9253947;
        break;
    case 1789:
        thalf_x0 = 12999807;
        half_x03 = 9250328;
        break;
    case 1790:
        thalf_x0 = 12998115;
        half_x03 = 9246716;
        break;
    case 1791:
        thalf_x0 = 12996423;
        half_x03 = 9243106;
        break;
    case 1792:
        thalf_x0 = 12994731;
        half_x03 = 9239496;
        break;
    case 1793:
        thalf_x0 = 12993039;
        half_x03 = 9235888;
        break;
    case 1794:
        thalf_x0 = 12991347;
        half_x03 = 9232280;
        break;
    case 1795:
        thalf_x0 = 12989657;
        half_x03 = 9228676;
        break;
    case 1796:
        thalf_x0 = 12987968;
        half_x03 = 9225077;
        break;
    case 1797:
        thalf_x0 = 12986279;
        half_x03 = 9221479;
        break;
    case 1798:
        thalf_x0 = 12984591;
        half_x03 = 9217884;
        break;
    case 1799:
        thalf_x0 = 12982904;
        half_x03 = 9214291;
        break;
    case 1800:
        thalf_x0 = 12981218;
        half_x03 = 9210701;
        break;
    case 1801:
        thalf_x0 = 12979532;
        half_x03 = 9207113;
        break;
    case 1802:
        thalf_x0 = 12977846;
        half_x03 = 9203525;
        break;
    case 1803:
        thalf_x0 = 12976160;
        half_x03 = 9199939;
        break;
    case 1804:
        thalf_x0 = 12974475;
        half_x03 = 9196357;
        break;
    case 1805:
        thalf_x0 = 12972792;
        half_x03 = 9192778;
        break;
    case 1806:
        thalf_x0 = 12971108;
        half_x03 = 9189198;
        break;
    case 1807:
        thalf_x0 = 12969428;
        half_x03 = 9185628;
        break;
    case 1808:
        thalf_x0 = 12967746;
        half_x03 = 9182055;
        break;
    case 1809:
        thalf_x0 = 12966065;
        half_x03 = 9178484;
        break;
    case 1810:
        thalf_x0 = 12964385;
        half_x03 = 9174917;
        break;
    case 1811:
        thalf_x0 = 12962705;
        half_x03 = 9171350;
        break;
    case 1812:
        thalf_x0 = 12961025;
        half_x03 = 9167785;
        break;
    case 1813:
        thalf_x0 = 12959346;
        half_x03 = 9164224;
        break;
    case 1814:
        thalf_x0 = 12957671;
        half_x03 = 9160669;
        break;
    case 1815:
        thalf_x0 = 12955992;
        half_x03 = 9157110;
        break;
    case 1816:
        thalf_x0 = 12954317;
        half_x03 = 9153558;
        break;
    case 1817:
        thalf_x0 = 12952640;
        half_x03 = 9150003;
        break;
    case 1818:
        thalf_x0 = 12950964;
        half_x03 = 9146453;
        break;
    case 1819:
        thalf_x0 = 12949290;
        half_x03 = 9142907;
        break;
    case 1820:
        thalf_x0 = 12947618;
        half_x03 = 9139365;
        break;
    case 1821:
        thalf_x0 = 12945944;
        half_x03 = 9135820;
        break;
    case 1822:
        thalf_x0 = 12944271;
        half_x03 = 9132280;
        break;
    case 1823:
        thalf_x0 = 12942599;
        half_x03 = 9128740;
        break;
    case 1824:
        thalf_x0 = 12940929;
        half_x03 = 9125208;
        break;
    case 1825:
        thalf_x0 = 12939257;
        half_x03 = 9121671;
        break;
    case 1826:
        thalf_x0 = 12937587;
        half_x03 = 9118140;
        break;
    case 1827:
        thalf_x0 = 12935919;
        half_x03 = 9114614;
        break;
    case 1828:
        thalf_x0 = 12934251;
        half_x03 = 9111089;
        break;
    case 1829:
        thalf_x0 = 12932583;
        half_x03 = 9107564;
        break;
    case 1830:
        thalf_x0 = 12930915;
        half_x03 = 9104041;
        break;
    case 1831:
        thalf_x0 = 12929247;
        half_x03 = 9100518;
        break;
    case 1832:
        thalf_x0 = 12927582;
        half_x03 = 9097003;
        break;
    case 1833:
        thalf_x0 = 12925917;
        half_x03 = 9093488;
        break;
    case 1834:
        thalf_x0 = 12924252;
        half_x03 = 9089975;
        break;
    case 1835:
        thalf_x0 = 12922587;
        half_x03 = 9086462;
        break;
    case 1836:
        thalf_x0 = 12920924;
        half_x03 = 9082953;
        break;
    case 1837:
        thalf_x0 = 12919262;
        half_x03 = 9079449;
        break;
    case 1838:
        thalf_x0 = 12917600;
        half_x03 = 9075945;
        break;
    case 1839:
        thalf_x0 = 12915938;
        half_x03 = 9072443;
        break;
    case 1840:
        thalf_x0 = 12914277;
        half_x03 = 9068944;
        break;
    case 1841:
        thalf_x0 = 12912617;
        half_x03 = 9065446;
        break;
    case 1842:
        thalf_x0 = 12910958;
        half_x03 = 9061952;
        break;
    case 1843:
        thalf_x0 = 12909299;
        half_x03 = 9058460;
        break;
    case 1844:
        thalf_x0 = 12907640;
        half_x03 = 9054968;
        break;
    case 1845:
        thalf_x0 = 12905981;
        half_x03 = 9051477;
        break;
    case 1846:
        thalf_x0 = 12904325;
        half_x03 = 9047993;
        break;
    case 1847:
        thalf_x0 = 12902669;
        half_x03 = 9044510;
        break;
    case 1848:
        thalf_x0 = 12901013;
        half_x03 = 9041028;
        break;
    case 1849:
        thalf_x0 = 12899357;
        half_x03 = 9037547;
        break;
    case 1850:
        thalf_x0 = 12897704;
        half_x03 = 9034073;
        break;
    case 1851:
        thalf_x0 = 12896049;
        half_x03 = 9030597;
        break;
    case 1852:
        thalf_x0 = 12894396;
        half_x03 = 9027124;
        break;
    case 1853:
        thalf_x0 = 12892743;
        half_x03 = 9023653;
        break;
    case 1854:
        thalf_x0 = 12891092;
        half_x03 = 9020186;
        break;
    case 1855:
        thalf_x0 = 12889440;
        half_x03 = 9016720;
        break;
    case 1856:
        thalf_x0 = 12887789;
        half_x03 = 9013254;
        break;
    case 1857:
        thalf_x0 = 12886139;
        half_x03 = 9009793;
        break;
    case 1858:
        thalf_x0 = 12884490;
        half_x03 = 9006335;
        break;
    case 1859:
        thalf_x0 = 12882842;
        half_x03 = 9002879;
        break;
    case 1860:
        thalf_x0 = 12881193;
        half_x03 = 8999423;
        break;
    case 1861:
        thalf_x0 = 12879545;
        half_x03 = 8995969;
        break;
    case 1862:
        thalf_x0 = 12877898;
        half_x03 = 8992518;
        break;
    case 1863:
        thalf_x0 = 12876252;
        half_x03 = 8989071;
        break;
    case 1864:
        thalf_x0 = 12874607;
        half_x03 = 8985626;
        break;
    case 1865:
        thalf_x0 = 12872961;
        half_x03 = 8982181;
        break;
    case 1866:
        thalf_x0 = 12871317;
        half_x03 = 8978740;
        break;
    case 1867:
        thalf_x0 = 12869673;
        half_x03 = 8975300;
        break;
    case 1868:
        thalf_x0 = 12868029;
        half_x03 = 8971860;
        break;
    case 1869:
        thalf_x0 = 12866388;
        half_x03 = 8968429;
        break;
    case 1870:
        thalf_x0 = 12864746;
        half_x03 = 8964994;
        break;
    case 1871:
        thalf_x0 = 12863105;
        half_x03 = 8961564;
        break;
    case 1872:
        thalf_x0 = 12861464;
        half_x03 = 8958135;
        break;
    case 1873:
        thalf_x0 = 12859826;
        half_x03 = 8954712;
        break;
    case 1874:
        thalf_x0 = 12858185;
        half_x03 = 8951285;
        break;
    case 1875:
        thalf_x0 = 12856547;
        half_x03 = 8947864;
        break;
    case 1876:
        thalf_x0 = 12854909;
        half_x03 = 8944445;
        break;
    case 1877:
        thalf_x0 = 12853271;
        half_x03 = 8941026;
        break;
    case 1878:
        thalf_x0 = 12851634;
        half_x03 = 8937611;
        break;
    case 1879:
        thalf_x0 = 12849998;
        half_x03 = 8934197;
        break;
    case 1880:
        thalf_x0 = 12848361;
        half_x03 = 8930785;
        break;
    case 1881:
        thalf_x0 = 12846728;
        half_x03 = 8927379;
        break;
    case 1882:
        thalf_x0 = 12845093;
        half_x03 = 8923971;
        break;
    case 1883:
        thalf_x0 = 12843458;
        half_x03 = 8920563;
        break;
    case 1884:
        thalf_x0 = 12841826;
        half_x03 = 8917163;
        break;
    case 1885:
        thalf_x0 = 12840194;
        half_x03 = 8913764;
        break;
    case 1886:
        thalf_x0 = 12838562;
        half_x03 = 8910365;
        break;
    case 1887:
        thalf_x0 = 12836930;
        half_x03 = 8906968;
        break;
    case 1888:
        thalf_x0 = 12835301;
        half_x03 = 8903577;
        break;
    case 1889:
        thalf_x0 = 12833669;
        half_x03 = 8900182;
        break;
    case 1890:
        thalf_x0 = 12832040;
        half_x03 = 8896793;
        break;
    case 1891:
        thalf_x0 = 12830411;
        half_x03 = 8893405;
        break;
    case 1892:
        thalf_x0 = 12828785;
        half_x03 = 8890024;
        break;
    case 1893:
        thalf_x0 = 12827156;
        half_x03 = 8886638;
        break;
    case 1894:
        thalf_x0 = 12825528;
        half_x03 = 8883256;
        break;
    case 1895:
        thalf_x0 = 12823902;
        half_x03 = 8879878;
        break;
    case 1896:
        thalf_x0 = 12822278;
        half_x03 = 8876504;
        break;
    case 1897:
        thalf_x0 = 12820652;
        half_x03 = 8873127;
        break;
    case 1898:
        thalf_x0 = 12819029;
        half_x03 = 8869758;
        break;
    case 1899:
        thalf_x0 = 12817403;
        half_x03 = 8866383;
        break;
    case 1900:
        thalf_x0 = 12815781;
        half_x03 = 8863018;
        break;
    case 1901:
        thalf_x0 = 12814158;
        half_x03 = 8859652;
        break;
    case 1902:
        thalf_x0 = 12812535;
        half_x03 = 8856286;
        break;
    case 1903:
        thalf_x0 = 12810915;
        half_x03 = 8852927;
        break;
    case 1904:
        thalf_x0 = 12809295;
        half_x03 = 8849569;
        break;
    case 1905:
        thalf_x0 = 12807675;
        half_x03 = 8846211;
        break;
    case 1906:
        thalf_x0 = 12806055;
        half_x03 = 8842855;
        break;
    case 1907:
        thalf_x0 = 12804435;
        half_x03 = 8839500;
        break;
    case 1908:
        thalf_x0 = 12802817;
        half_x03 = 8836148;
        break;
    case 1909:
        thalf_x0 = 12801200;
        half_x03 = 8832800;
        break;
    case 1910:
        thalf_x0 = 12799583;
        half_x03 = 8829454;
        break;
    case 1911:
        thalf_x0 = 12797966;
        half_x03 = 8826108;
        break;
    case 1912:
        thalf_x0 = 12796350;
        half_x03 = 8822766;
        break;
    case 1913:
        thalf_x0 = 12794735;
        half_x03 = 8819425;
        break;
    case 1914:
        thalf_x0 = 12793121;
        half_x03 = 8816088;
        break;
    case 1915:
        thalf_x0 = 12791507;
        half_x03 = 8812751;
        break;
    case 1916:
        thalf_x0 = 12789893;
        half_x03 = 8809416;
        break;
    case 1917:
        thalf_x0 = 12788282;
        half_x03 = 8806087;
        break;
    case 1918:
        thalf_x0 = 12786669;
        half_x03 = 8802757;
        break;
    case 1919:
        thalf_x0 = 12785057;
        half_x03 = 8799427;
        break;
    case 1920:
        thalf_x0 = 12783447;
        half_x03 = 8796104;
        break;
    case 1921:
        thalf_x0 = 12781835;
        half_x03 = 8792776;
        break;
    case 1922:
        thalf_x0 = 12780227;
        half_x03 = 8789457;
        break;
    case 1923:
        thalf_x0 = 12778617;
        half_x03 = 8786137;
        break;
    case 1924:
        thalf_x0 = 12777009;
        half_x03 = 8782821;
        break;
    case 1925:
        thalf_x0 = 12775401;
        half_x03 = 8779505;
        break;
    case 1926:
        thalf_x0 = 12773793;
        half_x03 = 8776191;
        break;
    case 1927:
        thalf_x0 = 12772187;
        half_x03 = 8772880;
        break;
    case 1928:
        thalf_x0 = 12770582;
        half_x03 = 8769573;
        break;
    case 1929:
        thalf_x0 = 12768975;
        half_x03 = 8766264;
        break;
    case 1930:
        thalf_x0 = 12767372;
        half_x03 = 8762962;
        break;
    case 1931:
        thalf_x0 = 12765765;
        half_x03 = 8759654;
        break;
    case 1932:
        thalf_x0 = 12764163;
        half_x03 = 8756357;
        break;
    case 1933:
        thalf_x0 = 12762560;
        half_x03 = 8753057;
        break;
    case 1934:
        thalf_x0 = 12760958;
        half_x03 = 8749761;
        break;
    case 1935:
        thalf_x0 = 12759356;
        half_x03 = 8746466;
        break;
    case 1936:
        thalf_x0 = 12757754;
        half_x03 = 8743172;
        break;
    case 1937:
        thalf_x0 = 12756153;
        half_x03 = 8739882;
        break;
    case 1938:
        thalf_x0 = 12754553;
        half_x03 = 8736593;
        break;
    case 1939:
        thalf_x0 = 12752954;
        half_x03 = 8733307;
        break;
    case 1940:
        thalf_x0 = 12751355;
        half_x03 = 8730023;
        break;
    case 1941:
        thalf_x0 = 12749757;
        half_x03 = 8726742;
        break;
    case 1942:
        thalf_x0 = 12748160;
        half_x03 = 8723462;
        break;
    case 1943:
        thalf_x0 = 12746562;
        half_x03 = 8720183;
        break;
    case 1944:
        thalf_x0 = 12744965;
        half_x03 = 8716905;
        break;
    case 1945:
        thalf_x0 = 12743370;
        half_x03 = 8713634;
        break;
    case 1946:
        thalf_x0 = 12741776;
        half_x03 = 8710363;
        break;
    case 1947:
        thalf_x0 = 12740181;
        half_x03 = 8707094;
        break;
    case 1948:
        thalf_x0 = 12738585;
        half_x03 = 8703822;
        break;
    case 1949:
        thalf_x0 = 12736994;
        half_x03 = 8700560;
        break;
    case 1950:
        thalf_x0 = 12735399;
        half_x03 = 8697293;
        break;
    case 1951:
        thalf_x0 = 12733808;
        half_x03 = 8694032;
        break;
    case 1952:
        thalf_x0 = 12732218;
        half_x03 = 8690776;
        break;
    case 1953:
        thalf_x0 = 12730625;
        half_x03 = 8687515;
        break;
    case 1954:
        thalf_x0 = 12729035;
        half_x03 = 8684260;
        break;
    case 1955:
        thalf_x0 = 12727445;
        half_x03 = 8681006;
        break;
    case 1956:
        thalf_x0 = 12725856;
        half_x03 = 8677756;
        break;
    case 1957:
        thalf_x0 = 12724268;
        half_x03 = 8674507;
        break;
    case 1958:
        thalf_x0 = 12722678;
        half_x03 = 8671255;
        break;
    case 1959:
        thalf_x0 = 12721092;
        half_x03 = 8668014;
        break;
    case 1960:
        thalf_x0 = 12719504;
        half_x03 = 8664767;
        break;
    case 1961:
        thalf_x0 = 12717920;
        half_x03 = 8661530;
        break;
    case 1962:
        thalf_x0 = 12716333;
        half_x03 = 8658288;
        break;
    case 1963:
        thalf_x0 = 12714749;
        half_x03 = 8655053;
        break;
    case 1964:
        thalf_x0 = 12713162;
        half_x03 = 8651813;
        break;
    case 1965:
        thalf_x0 = 12711581;
        half_x03 = 8648585;
        break;
    case 1966:
        thalf_x0 = 12709997;
        half_x03 = 8645353;
        break;
    case 1967:
        thalf_x0 = 12708413;
        half_x03 = 8642121;
        break;
    case 1968:
        thalf_x0 = 12706830;
        half_x03 = 8638893;
        break;
    case 1969:
        thalf_x0 = 12705251;
        half_x03 = 8635672;
        break;
    case 1970:
        thalf_x0 = 12703668;
        half_x03 = 8632445;
        break;
    case 1971:
        thalf_x0 = 12702089;
        half_x03 = 8629226;
        break;
    case 1972:
        thalf_x0 = 12700509;
        half_x03 = 8626007;
        break;
    case 1973:
        thalf_x0 = 12698930;
        half_x03 = 8622789;
        break;
    case 1974:
        thalf_x0 = 12697350;
        half_x03 = 8619572;
        break;
    case 1975:
        thalf_x0 = 12695772;
        half_x03 = 8616359;
        break;
    case 1976:
        thalf_x0 = 12694196;
        half_x03 = 8613149;
        break;
    case 1977:
        thalf_x0 = 12692619;
        half_x03 = 8609941;
        break;
    case 1978:
        thalf_x0 = 12691043;
        half_x03 = 8606733;
        break;
    case 1979:
        thalf_x0 = 12689466;
        half_x03 = 8603526;
        break;
    case 1980:
        thalf_x0 = 12687891;
        half_x03 = 8600323;
        break;
    case 1981:
        thalf_x0 = 12686318;
        half_x03 = 8597123;
        break;
    case 1982:
        thalf_x0 = 12684743;
        half_x03 = 8593922;
        break;
    case 1983:
        thalf_x0 = 12683169;
        half_x03 = 8590724;
        break;
    case 1984:
        thalf_x0 = 12681597;
        half_x03 = 8587530;
        break;
    case 1985:
        thalf_x0 = 12680025;
        half_x03 = 8584337;
        break;
    case 1986:
        thalf_x0 = 12678453;
        half_x03 = 8581144;
        break;
    case 1987:
        thalf_x0 = 12676883;
        half_x03 = 8577956;
        break;
    case 1988:
        thalf_x0 = 12675312;
        half_x03 = 8574768;
        break;
    case 1989:
        thalf_x0 = 12673743;
        half_x03 = 8571584;
        break;
    case 1990:
        thalf_x0 = 12672173;
        half_x03 = 8568398;
        break;
    case 1991:
        thalf_x0 = 12670604;
        half_x03 = 8565216;
        break;
    case 1992:
        thalf_x0 = 12669036;
        half_x03 = 8562038;
        break;
    case 1993:
        thalf_x0 = 12667469;
        half_x03 = 8558860;
        break;
    case 1994:
        thalf_x0 = 12665903;
        half_x03 = 8555686;
        break;
    case 1995:
        thalf_x0 = 12664335;
        half_x03 = 8552510;
        break;
    case 1996:
        thalf_x0 = 12662771;
        half_x03 = 8549341;
        break;
    case 1997:
        thalf_x0 = 12661205;
        half_x03 = 8546169;
        break;
    case 1998:
        thalf_x0 = 12659640;
        half_x03 = 8543002;
        break;
    case 1999:
        thalf_x0 = 12658077;
        half_x03 = 8539838;
        break;
    case 2000:
        thalf_x0 = 12656513;
        half_x03 = 8536672;
        break;
    case 2001:
        thalf_x0 = 12654951;
        half_x03 = 8533512;
        break;
    case 2002:
        thalf_x0 = 12653387;
        half_x03 = 8530348;
        break;
    case 2003:
        thalf_x0 = 12651827;
        half_x03 = 8527193;
        break;
    case 2004:
        thalf_x0 = 12650265;
        half_x03 = 8524036;
        break;
    case 2005:
        thalf_x0 = 12648705;
        half_x03 = 8520883;
        break;
    case 2006:
        thalf_x0 = 12647145;
        half_x03 = 8517731;
        break;
    case 2007:
        thalf_x0 = 12645585;
        half_x03 = 8514579;
        break;
    case 2008:
        thalf_x0 = 12644027;
        half_x03 = 8511432;
        break;
    case 2009:
        thalf_x0 = 12642470;
        half_x03 = 8508288;
        break;
    case 2010:
        thalf_x0 = 12640911;
        half_x03 = 8505141;
        break;
    case 2011:
        thalf_x0 = 12639353;
        half_x03 = 8501996;
        break;
    case 2012:
        thalf_x0 = 12637797;
        half_x03 = 8498857;
        break;
    case 2013:
        thalf_x0 = 12636242;
        half_x03 = 8495720;
        break;
    case 2014:
        thalf_x0 = 12634686;
        half_x03 = 8492583;
        break;
    case 2015:
        thalf_x0 = 12633131;
        half_x03 = 8489446;
        break;
    case 2016:
        thalf_x0 = 12631577;
        half_x03 = 8486314;
        break;
    case 2017:
        thalf_x0 = 12630023;
        half_x03 = 8483182;
        break;
    case 2018:
        thalf_x0 = 12628470;
        half_x03 = 8480054;
        break;
    case 2019:
        thalf_x0 = 12626918;
        half_x03 = 8476927;
        break;
    case 2020:
        thalf_x0 = 12625367;
        half_x03 = 8473804;
        break;
    case 2021:
        thalf_x0 = 12623814;
        half_x03 = 8470678;
        break;
    case 2022:
        thalf_x0 = 12622263;
        half_x03 = 8467556;
        break;
    case 2023:
        thalf_x0 = 12620714;
        half_x03 = 8464438;
        break;
    case 2024:
        thalf_x0 = 12619164;
        half_x03 = 8461321;
        break;
    case 2025:
        thalf_x0 = 12617615;
        half_x03 = 8458205;
        break;
    case 2026:
        thalf_x0 = 12616067;
        half_x03 = 8455092;
        break;
    case 2027:
        thalf_x0 = 12614519;
        half_x03 = 8451980;
        break;
    case 2028:
        thalf_x0 = 12612971;
        half_x03 = 8448869;
        break;
    case 2029:
        thalf_x0 = 12611426;
        half_x03 = 8445764;
        break;
    case 2030:
        thalf_x0 = 12609879;
        half_x03 = 8442658;
        break;
    case 2031:
        thalf_x0 = 12608333;
        half_x03 = 8439552;
        break;
    case 2032:
        thalf_x0 = 12606788;
        half_x03 = 8436450;
        break;
    case 2033:
        thalf_x0 = 12605243;
        half_x03 = 8433348;
        break;
    case 2034:
        thalf_x0 = 12603699;
        half_x03 = 8430251;
        break;
    case 2035:
        thalf_x0 = 12602156;
        half_x03 = 8427154;
        break;
    case 2036:
        thalf_x0 = 12600614;
        half_x03 = 8424061;
        break;
    case 2037:
        thalf_x0 = 12599072;
        half_x03 = 8420968;
        break;
    case 2038:
        thalf_x0 = 12597530;
        half_x03 = 8417877;
        break;
    case 2039:
        thalf_x0 = 12595988;
        half_x03 = 8414786;
        break;
    case 2040:
        thalf_x0 = 12594447;
        half_x03 = 8411699;
        break;
    case 2041:
        thalf_x0 = 12592908;
        half_x03 = 8408616;
        break;
    case 2042:
        thalf_x0 = 12591368;
        half_x03 = 8405530;
        break;
    case 2043:
        thalf_x0 = 12589830;
        half_x03 = 8402452;
        break;
    case 2044:
        thalf_x0 = 12588291;
        half_x03 = 8399371;
        break;
    case 2045:
        thalf_x0 = 12586754;
        half_x03 = 8396293;
        break;
    case 2046:
        thalf_x0 = 12585218;
        half_x03 = 8393220;
        break;
    case 2047:
        thalf_x0 = 12583680;
        half_x03 = 8390144;
        break;
    case 2048:
        thalf_x0 = 25162752;
        half_x03 = 33542145;
        break;
    case 2049:
        thalf_x0 = 25156616;
        half_x03 = 33517611;
        break;
    case 2050:
        thalf_x0 = 25150478;
        half_x03 = 33493083;
        break;
    case 2051:
        thalf_x0 = 25144349;
        half_x03 = 33468603;
        break;
    case 2052:
        thalf_x0 = 25138221;
        half_x03 = 33444141;
        break;
    case 2053:
        thalf_x0 = 25132100;
        half_x03 = 33419715;
        break;
    case 2054:
        thalf_x0 = 25125984;
        half_x03 = 33395324;
        break;
    case 2055:
        thalf_x0 = 25119872;
        half_x03 = 33370957;
        break;
    case 2056:
        thalf_x0 = 25113761;
        half_x03 = 33346608;
        break;
    case 2057:
        thalf_x0 = 25107659;
        half_x03 = 33322307;
        break;
    case 2058:
        thalf_x0 = 25101561;
        half_x03 = 33298036;
        break;
    case 2059:
        thalf_x0 = 25095465;
        half_x03 = 33273782;
        break;
    case 2060:
        thalf_x0 = 25089374;
        half_x03 = 33249558;
        break;
    case 2061:
        thalf_x0 = 25083288;
        half_x03 = 33225370;
        break;
    case 2062:
        thalf_x0 = 25077206;
        half_x03 = 33201205;
        break;
    case 2063:
        thalf_x0 = 25071129;
        half_x03 = 33177075;
        break;
    case 2064:
        thalf_x0 = 25065056;
        half_x03 = 33152970;
        break;
    case 2065:
        thalf_x0 = 25058988;
        half_x03 = 33128900;
        break;
    case 2066:
        thalf_x0 = 25052924;
        half_x03 = 33104853;
        break;
    case 2067:
        thalf_x0 = 25046865;
        half_x03 = 33080842;
        break;
    case 2068:
        thalf_x0 = 25040810;
        half_x03 = 33056854;
        break;
    case 2069:
        thalf_x0 = 25034760;
        half_x03 = 33032901;
        break;
    case 2070:
        thalf_x0 = 25028712;
        half_x03 = 33008967;
        break;
    case 2071:
        thalf_x0 = 25022672;
        half_x03 = 32985073;
        break;
    case 2072:
        thalf_x0 = 25016636;
        half_x03 = 32961209;
        break;
    case 2073:
        thalf_x0 = 25010600;
        half_x03 = 32937356;
        break;
    case 2074:
        thalf_x0 = 25004571;
        half_x03 = 32913544;
        break;
    case 2075:
        thalf_x0 = 24998546;
        half_x03 = 32889756;
        break;
    case 2076:
        thalf_x0 = 24992528;
        half_x03 = 32866008;
        break;
    case 2077:
        thalf_x0 = 24986510;
        half_x03 = 32842272;
        break;
    case 2078:
        thalf_x0 = 24980501;
        half_x03 = 32818584;
        break;
    case 2079:
        thalf_x0 = 24974493;
        half_x03 = 32794912;
        break;
    case 2080:
        thalf_x0 = 24968489;
        half_x03 = 32771263;
        break;
    case 2081:
        thalf_x0 = 24962492;
        half_x03 = 32747656;
        break;
    case 2082:
        thalf_x0 = 24956498;
        half_x03 = 32724071;
        break;
    case 2083:
        thalf_x0 = 24950508;
        half_x03 = 32700516;
        break;
    case 2084:
        thalf_x0 = 24944522;
        half_x03 = 32676983;
        break;
    case 2085:
        thalf_x0 = 24938541;
        half_x03 = 32653486;
        break;
    case 2086:
        thalf_x0 = 24932564;
        half_x03 = 32630012;
        break;
    case 2087:
        thalf_x0 = 24926592;
        half_x03 = 32606572;
        break;
    case 2088:
        thalf_x0 = 24920621;
        half_x03 = 32583144;
        break;
    case 2089:
        thalf_x0 = 24914657;
        half_x03 = 32559756;
        break;
    case 2090:
        thalf_x0 = 24908700;
        half_x03 = 32536409;
        break;
    case 2091:
        thalf_x0 = 24902745;
        half_x03 = 32513078;
        break;
    case 2092:
        thalf_x0 = 24896793;
        half_x03 = 32489771;
        break;
    case 2093:
        thalf_x0 = 24890844;
        half_x03 = 32466487;
        break;
    case 2094:
        thalf_x0 = 24884903;
        half_x03 = 32443243;
        break;
    case 2095:
        thalf_x0 = 24878964;
        half_x03 = 32420022;
        break;
    case 2096:
        thalf_x0 = 24873032;
        half_x03 = 32396835;
        break;
    case 2097:
        thalf_x0 = 24867101;
        half_x03 = 32373666;
        break;
    case 2098:
        thalf_x0 = 24861173;
        half_x03 = 32350519;
        break;
    case 2099:
        thalf_x0 = 24855254;
        half_x03 = 32327418;
        break;
    case 2100:
        thalf_x0 = 24849336;
        half_x03 = 32304334;
        break;
    case 2101:
        thalf_x0 = 24843423;
        half_x03 = 32281279;
        break;
    case 2102:
        thalf_x0 = 24837515;
        half_x03 = 32258252;
        break;
    case 2103:
        thalf_x0 = 24831611;
        half_x03 = 32235253;
        break;
    case 2104:
        thalf_x0 = 24825710;
        half_x03 = 32212278;
        break;
    case 2105:
        thalf_x0 = 24819815;
        half_x03 = 32189336;
        break;
    case 2106:
        thalf_x0 = 24813923;
        half_x03 = 32166417;
        break;
    case 2107:
        thalf_x0 = 24808034;
        half_x03 = 32143521;
        break;
    case 2108:
        thalf_x0 = 24802151;
        half_x03 = 32120659;
        break;
    case 2109:
        thalf_x0 = 24796271;
        half_x03 = 32097819;
        break;
    case 2110:
        thalf_x0 = 24790397;
        half_x03 = 32075013;
        break;
    case 2111:
        thalf_x0 = 24784526;
        half_x03 = 32052230;
        break;
    case 2112:
        thalf_x0 = 24778658;
        half_x03 = 32029469;
        break;
    case 2113:
        thalf_x0 = 24772793;
        half_x03 = 32006731;
        break;
    case 2114:
        thalf_x0 = 24766935;
        half_x03 = 31984033;
        break;
    case 2115:
        thalf_x0 = 24761084;
        half_x03 = 31961368;
        break;
    case 2116:
        thalf_x0 = 24755232;
        half_x03 = 31938714;
        break;
    case 2117:
        thalf_x0 = 24749385;
        half_x03 = 31916088;
        break;
    case 2118:
        thalf_x0 = 24743543;
        half_x03 = 31893491;
        break;
    case 2119:
        thalf_x0 = 24737708;
        half_x03 = 31870933;
        break;
    case 2120:
        thalf_x0 = 24731873;
        half_x03 = 31848386;
        break;
    case 2121:
        thalf_x0 = 24726041;
        half_x03 = 31825860;
        break;
    case 2122:
        thalf_x0 = 24720218;
        half_x03 = 31803381;
        break;
    case 2123:
        thalf_x0 = 24714396;
        half_x03 = 31780917;
        break;
    case 2124:
        thalf_x0 = 24708579;
        half_x03 = 31758482;
        break;
    case 2125:
        thalf_x0 = 24702767;
        half_x03 = 31736074;
        break;
    case 2126:
        thalf_x0 = 24696957;
        half_x03 = 31713689;
        break;
    case 2127:
        thalf_x0 = 24691152;
        half_x03 = 31691331;
        break;
    case 2128:
        thalf_x0 = 24685352;
        half_x03 = 31669002;
        break;
    case 2129:
        thalf_x0 = 24679553;
        half_x03 = 31646688;
        break;
    case 2130:
        thalf_x0 = 24673763;
        half_x03 = 31624420;
        break;
    case 2131:
        thalf_x0 = 24667976;
        half_x03 = 31602173;
        break;
    case 2132:
        thalf_x0 = 24662189;
        half_x03 = 31579937;
        break;
    case 2133:
        thalf_x0 = 24656408;
        half_x03 = 31557735;
        break;
    case 2134:
        thalf_x0 = 24650631;
        half_x03 = 31535560;
        break;
    case 2135:
        thalf_x0 = 24644859;
        half_x03 = 31513413;
        break;
    case 2136:
        thalf_x0 = 24639089;
        half_x03 = 31491282;
        break;
    case 2137:
        thalf_x0 = 24633326;
        half_x03 = 31469190;
        break;
    case 2138:
        thalf_x0 = 24627566;
        half_x03 = 31447120;
        break;
    case 2139:
        thalf_x0 = 24621812;
        half_x03 = 31425083;
        break;
    case 2140:
        thalf_x0 = 24616058;
        half_x03 = 31403056;
        break;
    case 2141:
        thalf_x0 = 24610311;
        half_x03 = 31381069;
        break;
    case 2142:
        thalf_x0 = 24604568;
        half_x03 = 31359103;
        break;
    case 2143:
        thalf_x0 = 24598826;
        half_x03 = 31337153;
        break;
    case 2144:
        thalf_x0 = 24593090;
        half_x03 = 31315237;
        break;
    case 2145:
        thalf_x0 = 24587357;
        half_x03 = 31293342;
        break;
    case 2146:
        thalf_x0 = 24581630;
        half_x03 = 31271480;
        break;
    case 2147:
        thalf_x0 = 24575906;
        half_x03 = 31249639;
        break;
    case 2148:
        thalf_x0 = 24570185;
        half_x03 = 31227821;
        break;
    case 2149:
        thalf_x0 = 24564470;
        half_x03 = 31206035;
        break;
    case 2150:
        thalf_x0 = 24558758;
        half_x03 = 31184271;
        break;
    case 2151:
        thalf_x0 = 24553052;
        half_x03 = 31162540;
        break;
    case 2152:
        thalf_x0 = 24547346;
        half_x03 = 31140819;
        break;
    case 2153:
        thalf_x0 = 24541646;
        half_x03 = 31119131;
        break;
    case 2154:
        thalf_x0 = 24535952;
        half_x03 = 31097476;
        break;
    case 2155:
        thalf_x0 = 24530258;
        half_x03 = 31075831;
        break;
    case 2156:
        thalf_x0 = 24524570;
        half_x03 = 31054218;
        break;
    case 2157:
        thalf_x0 = 24518885;
        half_x03 = 31032628;
        break;
    case 2158:
        thalf_x0 = 24513206;
        half_x03 = 31011069;
        break;
    case 2159:
        thalf_x0 = 24507530;
        half_x03 = 30989533;
        break;
    case 2160:
        thalf_x0 = 24501855;
        half_x03 = 30968012;
        break;
    case 2161:
        thalf_x0 = 24496188;
        half_x03 = 30946529;
        break;
    case 2162:
        thalf_x0 = 24490524;
        half_x03 = 30925068;
        break;
    case 2163:
        thalf_x0 = 24484862;
        half_x03 = 30903622;
        break;
    case 2164:
        thalf_x0 = 24479207;
        half_x03 = 30882214;
        break;
    case 2165:
        thalf_x0 = 24473553;
        half_x03 = 30860823;
        break;
    case 2166:
        thalf_x0 = 24467904;
        half_x03 = 30839457;
        break;
    case 2167:
        thalf_x0 = 24462260;
        half_x03 = 30818119;
        break;
    case 2168:
        thalf_x0 = 24456620;
        half_x03 = 30796808;
        break;
    case 2169:
        thalf_x0 = 24450983;
        half_x03 = 30775518;
        break;
    case 2170:
        thalf_x0 = 24445347;
        half_x03 = 30754243;
        break;
    case 2171:
        thalf_x0 = 24439719;
        half_x03 = 30733007;
        break;
    case 2172:
        thalf_x0 = 24434093;
        half_x03 = 30711786;
        break;
    case 2173:
        thalf_x0 = 24428472;
        half_x03 = 30690597;
        break;
    case 2174:
        thalf_x0 = 24422855;
        half_x03 = 30669429;
        break;
    case 2175:
        thalf_x0 = 24417242;
        half_x03 = 30648288;
        break;
    case 2176:
        thalf_x0 = 24411632;
        half_x03 = 30627168;
        break;
    case 2177:
        thalf_x0 = 24406025;
        half_x03 = 30606069;
        break;
    case 2178:
        thalf_x0 = 24400424;
        half_x03 = 30585002;
        break;
    case 2179:
        thalf_x0 = 24394824;
        half_x03 = 30563951;
        break;
    case 2180:
        thalf_x0 = 24389231;
        half_x03 = 30542932;
        break;
    case 2181:
        thalf_x0 = 24383640;
        half_x03 = 30521933;
        break;
    case 2182:
        thalf_x0 = 24378053;
        half_x03 = 30500956;
        break;
    case 2183:
        thalf_x0 = 24372470;
        half_x03 = 30480005;
        break;
    case 2184:
        thalf_x0 = 24366891;
        half_x03 = 30459080;
        break;
    case 2185:
        thalf_x0 = 24361313;
        half_x03 = 30438166;
        break;
    case 2186:
        thalf_x0 = 24355743;
        half_x03 = 30417294;
        break;
    case 2187:
        thalf_x0 = 24350175;
        half_x03 = 30396437;
        break;
    case 2188:
        thalf_x0 = 24344613;
        half_x03 = 30375613;
        break;
    case 2189:
        thalf_x0 = 24339053;
        half_x03 = 30354804;
        break;
    case 2190:
        thalf_x0 = 24333497;
        half_x03 = 30334021;
        break;
    case 2191:
        thalf_x0 = 24327944;
        half_x03 = 30313258;
        break;
    case 2192:
        thalf_x0 = 24322395;
        half_x03 = 30292522;
        break;
    case 2193:
        thalf_x0 = 24316850;
        half_x03 = 30271807;
        break;
    case 2194:
        thalf_x0 = 24311309;
        half_x03 = 30251118;
        break;
    case 2195:
        thalf_x0 = 24305772;
        half_x03 = 30230455;
        break;
    case 2196:
        thalf_x0 = 24300239;
        half_x03 = 30209813;
        break;
    case 2197:
        thalf_x0 = 24294708;
        half_x03 = 30189191;
        break;
    case 2198:
        thalf_x0 = 24289181;
        half_x03 = 30168590;
        break;
    case 2199:
        thalf_x0 = 24283659;
        half_x03 = 30148021;
        break;
    case 2200:
        thalf_x0 = 24278144;
        half_x03 = 30127483;
        break;
    case 2201:
        thalf_x0 = 24272628;
        half_x03 = 30106954;
        break;
    case 2202:
        thalf_x0 = 24267117;
        half_x03 = 30086452;
        break;
    case 2203:
        thalf_x0 = 24261611;
        half_x03 = 30065976;
        break;
    case 2204:
        thalf_x0 = 24256106;
        half_x03 = 30045514;
        break;
    case 2205:
        thalf_x0 = 24250607;
        half_x03 = 30025085;
        break;
    case 2206:
        thalf_x0 = 24245111;
        half_x03 = 30004675;
        break;
    case 2207:
        thalf_x0 = 24239618;
        half_x03 = 29984286;
        break;
    case 2208:
        thalf_x0 = 24234131;
        half_x03 = 29963928;
        break;
    case 2209:
        thalf_x0 = 24228647;
        half_x03 = 29943591;
        break;
    case 2210:
        thalf_x0 = 24223164;
        half_x03 = 29923269;
        break;
    case 2211:
        thalf_x0 = 24217688;
        half_x03 = 29902978;
        break;
    case 2212:
        thalf_x0 = 24212211;
        half_x03 = 29882696;
        break;
    case 2213:
        thalf_x0 = 24206745;
        half_x03 = 29862462;
        break;
    case 2214:
        thalf_x0 = 24201276;
        half_x03 = 29842226;
        break;
    case 2215:
        thalf_x0 = 24195815;
        half_x03 = 29822027;
        break;
    case 2216:
        thalf_x0 = 24190356;
        half_x03 = 29801849;
        break;
    case 2217:
        thalf_x0 = 24184901;
        half_x03 = 29781690;
        break;
    case 2218:
        thalf_x0 = 24179450;
        half_x03 = 29761557;
        break;
    case 2219:
        thalf_x0 = 24174002;
        half_x03 = 29741445;
        break;
    case 2220:
        thalf_x0 = 24168557;
        half_x03 = 29721352;
        break;
    case 2221:
        thalf_x0 = 24163118;
        half_x03 = 29701291;
        break;
    case 2222:
        thalf_x0 = 24157680;
        half_x03 = 29681244;
        break;
    case 2223:
        thalf_x0 = 24152249;
        half_x03 = 29661228;
        break;
    case 2224:
        thalf_x0 = 24146819;
        half_x03 = 29641227;
        break;
    case 2225:
        thalf_x0 = 24141395;
        half_x03 = 29621257;
        break;
    case 2226:
        thalf_x0 = 24135972;
        half_x03 = 29601301;
        break;
    case 2227:
        thalf_x0 = 24130553;
        half_x03 = 29581366;
        break;
    case 2228:
        thalf_x0 = 24125138;
        half_x03 = 29561456;
        break;
    case 2229:
        thalf_x0 = 24119727;
        half_x03 = 29541571;
        break;
    case 2230:
        thalf_x0 = 24114321;
        half_x03 = 29521712;
        break;
    case 2231:
        thalf_x0 = 24108917;
        half_x03 = 29501867;
        break;
    case 2232:
        thalf_x0 = 24103517;
        half_x03 = 29482048;
        break;
    case 2233:
        thalf_x0 = 24098120;
        half_x03 = 29462248;
        break;
    case 2234:
        thalf_x0 = 24092727;
        half_x03 = 29442474;
        break;
    case 2235:
        thalf_x0 = 24087338;
        half_x03 = 29422720;
        break;
    case 2236:
        thalf_x0 = 24081951;
        half_x03 = 29402986;
        break;
    case 2237:
        thalf_x0 = 24076572;
        half_x03 = 29383287;
        break;
    case 2238:
        thalf_x0 = 24071193;
        half_x03 = 29363598;
        break;
    case 2239:
        thalf_x0 = 24065817;
        half_x03 = 29343928;
        break;
    case 2240:
        thalf_x0 = 24060444;
        half_x03 = 29324279;
        break;
    case 2241:
        thalf_x0 = 24055077;
        half_x03 = 29304660;
        break;
    case 2242:
        thalf_x0 = 24049713;
        half_x03 = 29285060;
        break;
    case 2243:
        thalf_x0 = 24044352;
        half_x03 = 29265480;
        break;
    case 2244:
        thalf_x0 = 24038996;
        half_x03 = 29245926;
        break;
    case 2245:
        thalf_x0 = 24033644;
        half_x03 = 29226396;
        break;
    case 2246:
        thalf_x0 = 24028295;
        half_x03 = 29206887;
        break;
    case 2247:
        thalf_x0 = 24022946;
        half_x03 = 29187385;
        break;
    case 2248:
        thalf_x0 = 24017604;
        half_x03 = 29167920;
        break;
    case 2249:
        thalf_x0 = 24012266;
        half_x03 = 29148475;
        break;
    case 2250:
        thalf_x0 = 24006929;
        half_x03 = 29129043;
        break;
    case 2251:
        thalf_x0 = 24001598;
        half_x03 = 29109642;
        break;
    case 2252:
        thalf_x0 = 23996270;
        half_x03 = 29090261;
        break;
    case 2253:
        thalf_x0 = 23990945;
        half_x03 = 29070899;
        break;
    case 2254:
        thalf_x0 = 23985624;
        half_x03 = 29051562;
        break;
    case 2255:
        thalf_x0 = 23980307;
        half_x03 = 29032245;
        break;
    case 2256:
        thalf_x0 = 23974992;
        half_x03 = 29012947;
        break;
    case 2257:
        thalf_x0 = 23969684;
        half_x03 = 28993679;
        break;
    case 2258:
        thalf_x0 = 23964374;
        half_x03 = 28974414;
        break;
    case 2259:
        thalf_x0 = 23959071;
        half_x03 = 28955185;
        break;
    case 2260:
        thalf_x0 = 23953769;
        half_x03 = 28935965;
        break;
    case 2261:
        thalf_x0 = 23948474;
        half_x03 = 28916780;
        break;
    case 2262:
        thalf_x0 = 23943182;
        half_x03 = 28897615;
        break;
    case 2263:
        thalf_x0 = 23937891;
        half_x03 = 28878463;
        break;
    case 2264:
        thalf_x0 = 23932607;
        half_x03 = 28859342;
        break;
    case 2265:
        thalf_x0 = 23927325;
        half_x03 = 28840240;
        break;
    case 2266:
        thalf_x0 = 23922045;
        half_x03 = 28821152;
        break;
    case 2267:
        thalf_x0 = 23916768;
        half_x03 = 28802083;
        break;
    case 2268:
        thalf_x0 = 23911497;
        half_x03 = 28783044;
        break;
    case 2269:
        thalf_x0 = 23906228;
        half_x03 = 28764019;
        break;
    case 2270:
        thalf_x0 = 23900961;
        half_x03 = 28745013;
        break;
    case 2271:
        thalf_x0 = 23895701;
        half_x03 = 28726038;
        break;
    case 2272:
        thalf_x0 = 23890442;
        half_x03 = 28707076;
        break;
    case 2273:
        thalf_x0 = 23885187;
        half_x03 = 28688138;
        break;
    case 2274:
        thalf_x0 = 23879936;
        half_x03 = 28669220;
        break;
    case 2275:
        thalf_x0 = 23874687;
        half_x03 = 28650321;
        break;
    case 2276:
        thalf_x0 = 23869445;
        half_x03 = 28631451;
        break;
    case 2277:
        thalf_x0 = 23864204;
        half_x03 = 28612596;
        break;
    case 2278:
        thalf_x0 = 23858966;
        half_x03 = 28593759;
        break;
    case 2279:
        thalf_x0 = 23853732;
        half_x03 = 28574947;
        break;
    case 2280:
        thalf_x0 = 23848502;
        half_x03 = 28556154;
        break;
    case 2281:
        thalf_x0 = 23843276;
        half_x03 = 28537385;
        break;
    case 2282:
        thalf_x0 = 23838050;
        half_x03 = 28518625;
        break;
    case 2283:
        thalf_x0 = 23832830;
        half_x03 = 28499894;
        break;
    case 2284:
        thalf_x0 = 23827616;
        half_x03 = 28481193;
        break;
    case 2285:
        thalf_x0 = 23822400;
        half_x03 = 28462495;
        break;
    case 2286:
        thalf_x0 = 23817191;
        half_x03 = 28443826;
        break;
    case 2287:
        thalf_x0 = 23811984;
        half_x03 = 28425177;
        break;
    case 2288:
        thalf_x0 = 23806781;
        half_x03 = 28406546;
        break;
    case 2289:
        thalf_x0 = 23801582;
        half_x03 = 28387939;
        break;
    case 2290:
        thalf_x0 = 23796386;
        half_x03 = 28369352;
        break;
    case 2291:
        thalf_x0 = 23791191;
        half_x03 = 28350778;
        break;
    case 2292:
        thalf_x0 = 23786004;
        half_x03 = 28332238;
        break;
    case 2293:
        thalf_x0 = 23780817;
        half_x03 = 28313707;
        break;
    case 2294:
        thalf_x0 = 23775635;
        half_x03 = 28295200;
        break;
    case 2295:
        thalf_x0 = 23770452;
        half_x03 = 28276701;
        break;
    case 2296:
        thalf_x0 = 23765279;
        half_x03 = 28258243;
        break;
    case 2297:
        thalf_x0 = 23760105;
        half_x03 = 28239792;
        break;
    case 2298:
        thalf_x0 = 23754936;
        half_x03 = 28221365;
        break;
    case 2299:
        thalf_x0 = 23749772;
        half_x03 = 28202963;
        break;
    case 2300:
        thalf_x0 = 23744609;
        half_x03 = 28184573;
        break;
    case 2301:
        thalf_x0 = 23739449;
        half_x03 = 28166203;
        break;
    case 2302:
        thalf_x0 = 23734295;
        half_x03 = 28147862;
        break;
    case 2303:
        thalf_x0 = 23729144;
        half_x03 = 28129539;
        break;
    case 2304:
        thalf_x0 = 23723993;
        half_x03 = 28111224;
        break;
    case 2305:
        thalf_x0 = 23718845;
        half_x03 = 28092928;
        break;
    case 2306:
        thalf_x0 = 23713704;
        half_x03 = 28074667;
        break;
    case 2307:
        thalf_x0 = 23708567;
        half_x03 = 28056424;
        break;
    case 2308:
        thalf_x0 = 23703431;
        half_x03 = 28038194;
        break;
    case 2309:
        thalf_x0 = 23698298;
        half_x03 = 28019983;
        break;
    case 2310:
        thalf_x0 = 23693169;
        half_x03 = 28001796;
        break;
    case 2311:
        thalf_x0 = 23688044;
        half_x03 = 27983627;
        break;
    case 2312:
        thalf_x0 = 23682921;
        half_x03 = 27965477;
        break;
    case 2313:
        thalf_x0 = 23677802;
        half_x03 = 27947345;
        break;
    case 2314:
        thalf_x0 = 23672687;
        half_x03 = 27929237;
        break;
    case 2315:
        thalf_x0 = 23667575;
        half_x03 = 27911147;
        break;
    case 2316:
        thalf_x0 = 23662464;
        half_x03 = 27893070;
        break;
    case 2317:
        thalf_x0 = 23657360;
        half_x03 = 27875023;
        break;
    case 2318:
        thalf_x0 = 23652257;
        half_x03 = 27856989;
        break;
    case 2319:
        thalf_x0 = 23647157;
        half_x03 = 27838972;
        break;
    case 2320:
        thalf_x0 = 23642064;
        half_x03 = 27820991;
        break;
    case 2321:
        thalf_x0 = 23636967;
        half_x03 = 27803001;
        break;
    case 2322:
        thalf_x0 = 23631879;
        half_x03 = 27785050;
        break;
    case 2323:
        thalf_x0 = 23626796;
        half_x03 = 27767124;
        break;
    case 2324:
        thalf_x0 = 23621712;
        half_x03 = 27749204;
        break;
    case 2325:
        thalf_x0 = 23616633;
        half_x03 = 27731309;
        break;
    case 2326:
        thalf_x0 = 23611556;
        half_x03 = 27713426;
        break;
    case 2327:
        thalf_x0 = 23606483;
        half_x03 = 27695567;
        break;
    case 2328:
        thalf_x0 = 23601413;
        half_x03 = 27677726;
        break;
    case 2329:
        thalf_x0 = 23596347;
        half_x03 = 27659909;
        break;
    case 2330:
        thalf_x0 = 23591285;
        half_x03 = 27642110;
        break;
    case 2331:
        thalf_x0 = 23586224;
        half_x03 = 27624324;
        break;
    case 2332:
        thalf_x0 = 23581167;
        half_x03 = 27606561;
        break;
    case 2333:
        thalf_x0 = 23576114;
        half_x03 = 27588816;
        break;
    case 2334:
        thalf_x0 = 23571065;
        half_x03 = 27571095;
        break;
    case 2335:
        thalf_x0 = 23566019;
        half_x03 = 27553392;
        break;
    case 2336:
        thalf_x0 = 23560973;
        half_x03 = 27535696;
        break;
    case 2337:
        thalf_x0 = 23555936;
        half_x03 = 27518040;
        break;
    case 2338:
        thalf_x0 = 23550897;
        half_x03 = 27500386;
        break;
    case 2339:
        thalf_x0 = 23545862;
        half_x03 = 27482750;
        break;
    case 2340:
        thalf_x0 = 23540832;
        half_x03 = 27465142;
        break;
    case 2341:
        thalf_x0 = 23535804;
        half_x03 = 27447547;
        break;
    case 2342:
        thalf_x0 = 23530781;
        half_x03 = 27429976;
        break;
    case 2343:
        thalf_x0 = 23525759;
        half_x03 = 27412417;
        break;
    case 2344:
        thalf_x0 = 23520743;
        half_x03 = 27394887;
        break;
    case 2345:
        thalf_x0 = 23515728;
        half_x03 = 27377369;
        break;
    case 2346:
        thalf_x0 = 23510717;
        half_x03 = 27359869;
        break;
    case 2347:
        thalf_x0 = 23505710;
        half_x03 = 27342393;
        break;
    case 2348:
        thalf_x0 = 23500704;
        half_x03 = 27324929;
        break;
    case 2349:
        thalf_x0 = 23495702;
        half_x03 = 27307483;
        break;
    case 2350:
        thalf_x0 = 23490701;
        half_x03 = 27290050;
        break;
    case 2351:
        thalf_x0 = 23485707;
        half_x03 = 27272650;
        break;
    case 2352:
        thalf_x0 = 23480714;
        half_x03 = 27255258;
        break;
    case 2353:
        thalf_x0 = 23475728;
        half_x03 = 27237899;
        break;
    case 2354:
        thalf_x0 = 23470740;
        half_x03 = 27220542;
        break;
    case 2355:
        thalf_x0 = 23465757;
        half_x03 = 27203209;
        break;
    case 2356:
        thalf_x0 = 23460777;
        half_x03 = 27185893;
        break;
    case 2357:
        thalf_x0 = 23455803;
        half_x03 = 27168605;
        break;
    case 2358:
        thalf_x0 = 23450828;
        half_x03 = 27151320;
        break;
    case 2359:
        thalf_x0 = 23445860;
        half_x03 = 27134067;
        break;
    case 2360:
        thalf_x0 = 23440892;
        half_x03 = 27116823;
        break;
    case 2361:
        thalf_x0 = 23435928;
        half_x03 = 27099601;
        break;
    case 2362:
        thalf_x0 = 23430968;
        half_x03 = 27082396;
        break;
    case 2363:
        thalf_x0 = 23426012;
        half_x03 = 27065215;
        break;
    case 2364:
        thalf_x0 = 23421056;
        half_x03 = 27048041;
        break;
    case 2365:
        thalf_x0 = 23416104;
        half_x03 = 27030890;
        break;
    case 2366:
        thalf_x0 = 23411157;
        half_x03 = 27013761;
        break;
    case 2367:
        thalf_x0 = 23406213;
        half_x03 = 26996650;
        break;
    case 2368:
        thalf_x0 = 23401272;
        half_x03 = 26979557;
        break;
    case 2369:
        thalf_x0 = 23396331;
        half_x03 = 26962471;
        break;
    case 2370:
        thalf_x0 = 23391396;
        half_x03 = 26945413;
        break;
    case 2371:
        thalf_x0 = 23386464;
        half_x03 = 26928373;
        break;
    case 2372:
        thalf_x0 = 23381535;
        half_x03 = 26911350;
        break;
    case 2373:
        thalf_x0 = 23376609;
        half_x03 = 26894345;
        break;
    case 2374:
        thalf_x0 = 23371688;
        half_x03 = 26877362;
        break;
    case 2375:
        thalf_x0 = 23366768;
        half_x03 = 26860391;
        break;
    case 2376:
        thalf_x0 = 23361849;
        half_x03 = 26843433;
        break;
    case 2377:
        thalf_x0 = 23356937;
        half_x03 = 26826503;
        break;
    case 2378:
        thalf_x0 = 23352026;
        half_x03 = 26809585;
        break;
    case 2379:
        thalf_x0 = 23347118;
        half_x03 = 26792685;
        break;
    case 2380:
        thalf_x0 = 23342213;
        half_x03 = 26775802;
        break;
    case 2381:
        thalf_x0 = 23337312;
        half_x03 = 26758941;
        break;
    case 2382:
        thalf_x0 = 23332415;
        half_x03 = 26742098;
        break;
    case 2383:
        thalf_x0 = 23327519;
        half_x03 = 26725267;
        break;
    case 2384:
        thalf_x0 = 23322626;
        half_x03 = 26708453;
        break;
    case 2385:
        thalf_x0 = 23317739;
        half_x03 = 26691668;
        break;
    case 2386:
        thalf_x0 = 23312853;
        half_x03 = 26674894;
        break;
    case 2387:
        thalf_x0 = 23307969;
        half_x03 = 26658132;
        break;
    case 2388:
        thalf_x0 = 23303091;
        half_x03 = 26641399;
        break;
    case 2389:
        thalf_x0 = 23298213;
        half_x03 = 26624672;
        break;
    case 2390:
        thalf_x0 = 23293340;
        half_x03 = 26607967;
        break;
    case 2391:
        thalf_x0 = 23288469;
        half_x03 = 26591280;
        break;
    case 2392:
        thalf_x0 = 23283602;
        half_x03 = 26574610;
        break;
    case 2393:
        thalf_x0 = 23278737;
        half_x03 = 26557957;
        break;
    case 2394:
        thalf_x0 = 23273877;
        half_x03 = 26541327;
        break;
    case 2395:
        thalf_x0 = 23269019;
        half_x03 = 26524709;
        break;
    case 2396:
        thalf_x0 = 23264163;
        half_x03 = 26508107;
        break;
    case 2397:
        thalf_x0 = 23259311;
        half_x03 = 26491524;
        break;
    case 2398:
        thalf_x0 = 23254461;
        half_x03 = 26474957;
        break;
    case 2399:
        thalf_x0 = 23249615;
        half_x03 = 26458407;
        break;
    case 2400:
        thalf_x0 = 23244771;
        half_x03 = 26441875;
        break;
    case 2401:
        thalf_x0 = 23239932;
        half_x03 = 26425364;
        break;
    case 2402:
        thalf_x0 = 23235095;
        half_x03 = 26408866;
        break;
    case 2403:
        thalf_x0 = 23230260;
        half_x03 = 26392385;
        break;
    case 2404:
        thalf_x0 = 23225429;
        half_x03 = 26375921;
        break;
    case 2405:
        thalf_x0 = 23220602;
        half_x03 = 26359479;
        break;
    case 2406:
        thalf_x0 = 23215775;
        half_x03 = 26343044;
        break;
    case 2407:
        thalf_x0 = 23210954;
        half_x03 = 26326636;
        break;
    case 2408:
        thalf_x0 = 23206133;
        half_x03 = 26310235;
        break;
    case 2409:
        thalf_x0 = 23201319;
        half_x03 = 26293866;
        break;
    case 2410:
        thalf_x0 = 23196506;
        half_x03 = 26277504;
        break;
    case 2411:
        thalf_x0 = 23191695;
        half_x03 = 26261160;
        break;
    case 2412:
        thalf_x0 = 23186891;
        half_x03 = 26244842;
        break;
    case 2413:
        thalf_x0 = 23182083;
        half_x03 = 26228521;
        break;
    case 2414:
        thalf_x0 = 23177283;
        half_x03 = 26212232;
        break;
    case 2415:
        thalf_x0 = 23172485;
        half_x03 = 26195954;
        break;
    case 2416:
        thalf_x0 = 23167691;
        half_x03 = 26179699;
        break;
    case 2417:
        thalf_x0 = 23162900;
        half_x03 = 26163461;
        break;
    case 2418:
        thalf_x0 = 23158112;
        half_x03 = 26147240;
        break;
    case 2419:
        thalf_x0 = 23153324;
        half_x03 = 26131025;
        break;
    case 2420:
        thalf_x0 = 23148540;
        half_x03 = 26114832;
        break;
    case 2421:
        thalf_x0 = 23143760;
        half_x03 = 26098656;
        break;
    case 2422:
        thalf_x0 = 23138981;
        half_x03 = 26082492;
        break;
    case 2423:
        thalf_x0 = 23134205;
        half_x03 = 26066345;
        break;
    case 2424:
        thalf_x0 = 23129436;
        half_x03 = 26050230;
        break;
    case 2425:
        thalf_x0 = 23124668;
        half_x03 = 26034121;
        break;
    case 2426:
        thalf_x0 = 23119901;
        half_x03 = 26018024;
        break;
    case 2427:
        thalf_x0 = 23115140;
        half_x03 = 26001954;
        break;
    case 2428:
        thalf_x0 = 23110380;
        half_x03 = 25985895;
        break;
    case 2429:
        thalf_x0 = 23105625;
        half_x03 = 25969859;
        break;
    case 2430:
        thalf_x0 = 23100869;
        half_x03 = 25953824;
        break;
    case 2431:
        thalf_x0 = 23096120;
        half_x03 = 25937820;
        break;
    case 2432:
        thalf_x0 = 23091372;
        half_x03 = 25921829;
        break;
    case 2433:
        thalf_x0 = 23086628;
        half_x03 = 25905854;
        break;
    case 2434:
        thalf_x0 = 23081883;
        half_x03 = 25889886;
        break;
    case 2435:
        thalf_x0 = 23077145;
        half_x03 = 25873944;
        break;
    case 2436:
        thalf_x0 = 23072409;
        half_x03 = 25858019;
        break;
    case 2437:
        thalf_x0 = 23067674;
        half_x03 = 25842101;
        break;
    case 2438:
        thalf_x0 = 23062946;
        half_x03 = 25826214;
        break;
    case 2439:
        thalf_x0 = 23058216;
        half_x03 = 25810329;
        break;
    case 2440:
        thalf_x0 = 23053493;
        half_x03 = 25794470;
        break;
    case 2441:
        thalf_x0 = 23048771;
        half_x03 = 25778623;
        break;
    case 2442:
        thalf_x0 = 23044052;
        half_x03 = 25762793;
        break;
    case 2443:
        thalf_x0 = 23039336;
        half_x03 = 25746979;
        break;
    case 2444:
        thalf_x0 = 23034624;
        half_x03 = 25731186;
        break;
    case 2445:
        thalf_x0 = 23029911;
        half_x03 = 25715395;
        break;
    case 2446:
        thalf_x0 = 23025206;
        half_x03 = 25699636;
        break;
    case 2447:
        thalf_x0 = 23020502;
        half_x03 = 25683888;
        break;
    case 2448:
        thalf_x0 = 23015799;
        half_x03 = 25668152;
        break;
    case 2449:
        thalf_x0 = 23011103;
        half_x03 = 25652442;
        break;
    case 2450:
        thalf_x0 = 23006408;
        half_x03 = 25636743;
        break;
    case 2451:
        thalf_x0 = 23001716;
        half_x03 = 25621061;
        break;
    case 2452:
        thalf_x0 = 22997024;
        half_x03 = 25605385;
        break;
    case 2453:
        thalf_x0 = 22992336;
        half_x03 = 25589731;
        break;
    case 2454:
        thalf_x0 = 22987652;
        half_x03 = 25574093;
        break;
    case 2455:
        thalf_x0 = 22982972;
        half_x03 = 25558476;
        break;
    case 2456:
        thalf_x0 = 22978293;
        half_x03 = 25542871;
        break;
    case 2457:
        thalf_x0 = 22973616;
        half_x03 = 25527277;
        break;
    case 2458:
        thalf_x0 = 22968944;
        half_x03 = 25511705;
        break;
    case 2459:
        thalf_x0 = 22964276;
        half_x03 = 25496154;
        break;
    case 2460:
        thalf_x0 = 22959608;
        half_x03 = 25480609;
        break;
    case 2461:
        thalf_x0 = 22954943;
        half_x03 = 25465081;
        break;
    case 2462:
        thalf_x0 = 22950281;
        half_x03 = 25449568;
        break;
    case 2463:
        thalf_x0 = 22945622;
        half_x03 = 25434072;
        break;
    case 2464:
        thalf_x0 = 22940966;
        half_x03 = 25418593;
        break;
    case 2465:
        thalf_x0 = 22936316;
        half_x03 = 25403139;
        break;
    case 2466:
        thalf_x0 = 22931664;
        half_x03 = 25387687;
        break;
    case 2467:
        thalf_x0 = 22927017;
        half_x03 = 25372256;
        break;
    case 2468:
        thalf_x0 = 22922373;
        half_x03 = 25356841;
        break;
    case 2469:
        thalf_x0 = 22917731;
        half_x03 = 25341438;
        break;
    case 2470:
        thalf_x0 = 22913093;
        half_x03 = 25326055;
        break;
    case 2471:
        thalf_x0 = 22908456;
        half_x03 = 25310684;
        break;
    case 2472:
        thalf_x0 = 22903823;
        half_x03 = 25295329;
        break;
    case 2473:
        thalf_x0 = 22899192;
        half_x03 = 25279990;
        break;
    case 2474:
        thalf_x0 = 22894565;
        half_x03 = 25264667;
        break;
    case 2475:
        thalf_x0 = 22889942;
        half_x03 = 25249366;
        break;
    case 2476:
        thalf_x0 = 22885320;
        half_x03 = 25234075;
        break;
    case 2477:
        thalf_x0 = 22880700;
        half_x03 = 25218796;
        break;
    case 2478:
        thalf_x0 = 22876083;
        half_x03 = 25203533;
        break;
    case 2479:
        thalf_x0 = 22871472;
        half_x03 = 25188295;
        break;
    case 2480:
        thalf_x0 = 22866861;
        half_x03 = 25173064;
        break;
    case 2481:
        thalf_x0 = 22862253;
        half_x03 = 25157849;
        break;
    case 2482:
        thalf_x0 = 22857647;
        half_x03 = 25142645;
        break;
    case 2483:
        thalf_x0 = 22853043;
        half_x03 = 25127457;
        break;
    case 2484:
        thalf_x0 = 22848444;
        half_x03 = 25112290;
        break;
    case 2485:
        thalf_x0 = 22843847;
        half_x03 = 25097134;
        break;
    case 2486:
        thalf_x0 = 22839254;
        half_x03 = 25081999;
        break;
    case 2487:
        thalf_x0 = 22834664;
        half_x03 = 25066880;
        break;
    case 2488:
        thalf_x0 = 22830074;
        half_x03 = 25051766;
        break;
    case 2489:
        thalf_x0 = 22825488;
        half_x03 = 25036674;
        break;
    case 2490:
        thalf_x0 = 22820906;
        half_x03 = 25021598;
        break;
    case 2491:
        thalf_x0 = 22816325;
        half_x03 = 25006533;
        break;
    case 2492:
        thalf_x0 = 22811748;
        half_x03 = 24991488;
        break;
    case 2493:
        thalf_x0 = 22807173;
        half_x03 = 24976455;
        break;
    case 2494:
        thalf_x0 = 22802601;
        half_x03 = 24961437;
        break;
    case 2495:
        thalf_x0 = 22798032;
        half_x03 = 24946436;
        break;
    case 2496:
        thalf_x0 = 22793465;
        half_x03 = 24931445;
        break;
    case 2497:
        thalf_x0 = 22788902;
        half_x03 = 24916475;
        break;
    case 2498:
        thalf_x0 = 22784342;
        half_x03 = 24901521;
        break;
    case 2499:
        thalf_x0 = 22779782;
        half_x03 = 24886573;
        break;
    case 2500:
        thalf_x0 = 22775228;
        half_x03 = 24871650;
        break;
    case 2501:
        thalf_x0 = 22770674;
        half_x03 = 24856733;
        break;
    case 2502:
        thalf_x0 = 22766124;
        half_x03 = 24841837;
        break;
    case 2503:
        thalf_x0 = 22761576;
        half_x03 = 24826952;
        break;
    case 2504:
        thalf_x0 = 22757031;
        half_x03 = 24812083;
        break;
    case 2505:
        thalf_x0 = 22752491;
        half_x03 = 24797235;
        break;
    case 2506:
        thalf_x0 = 22747952;
        half_x03 = 24782397;
        break;
    case 2507:
        thalf_x0 = 22743416;
        half_x03 = 24767575;
        break;
    case 2508:
        thalf_x0 = 22738880;
        half_x03 = 24752759;
        break;
    case 2509:
        thalf_x0 = 22734350;
        half_x03 = 24737968;
        break;
    case 2510:
        thalf_x0 = 22729821;
        half_x03 = 24723188;
        break;
    case 2511:
        thalf_x0 = 22725296;
        half_x03 = 24708424;
        break;
    case 2512:
        thalf_x0 = 22720773;
        half_x03 = 24693675;
        break;
    case 2513:
        thalf_x0 = 22716252;
        half_x03 = 24678938;
        break;
    case 2514:
        thalf_x0 = 22711733;
        half_x03 = 24664210;
        break;
    case 2515:
        thalf_x0 = 22707219;
        half_x03 = 24649509;
        break;
    case 2516:
        thalf_x0 = 22702707;
        half_x03 = 24634818;
        break;
    case 2517:
        thalf_x0 = 22698201;
        half_x03 = 24620152;
        break;
    case 2518:
        thalf_x0 = 22693692;
        half_x03 = 24605483;
        break;
    case 2519:
        thalf_x0 = 22689189;
        half_x03 = 24590839;
        break;
    case 2520:
        thalf_x0 = 22684688;
        half_x03 = 24576205;
        break;
    case 2521:
        thalf_x0 = 22680188;
        half_x03 = 24561583;
        break;
    case 2522:
        thalf_x0 = 22675692;
        half_x03 = 24546980;
        break;
    case 2523:
        thalf_x0 = 22671200;
        half_x03 = 24532393;
        break;
    case 2524:
        thalf_x0 = 22666709;
        half_x03 = 24517817;
        break;
    case 2525:
        thalf_x0 = 22662221;
        half_x03 = 24503257;
        break;
    case 2526:
        thalf_x0 = 22657733;
        half_x03 = 24488702;
        break;
    case 2527:
        thalf_x0 = 22653252;
        half_x03 = 24474177;
        break;
    case 2528:
        thalf_x0 = 22648772;
        half_x03 = 24459658;
        break;
    case 2529:
        thalf_x0 = 22644296;
        half_x03 = 24445159;
        break;
    case 2530:
        thalf_x0 = 22639820;
        half_x03 = 24430666;
        break;
    case 2531:
        thalf_x0 = 22635348;
        half_x03 = 24416193;
        break;
    case 2532:
        thalf_x0 = 22630877;
        half_x03 = 24401726;
        break;
    case 2533:
        thalf_x0 = 22626411;
        half_x03 = 24387284;
        break;
    case 2534:
        thalf_x0 = 22621947;
        half_x03 = 24372853;
        break;
    case 2535:
        thalf_x0 = 22617488;
        half_x03 = 24358442;
        break;
    case 2536:
        thalf_x0 = 22613028;
        half_x03 = 24344036;
        break;
    case 2537:
        thalf_x0 = 22608572;
        half_x03 = 24329646;
        break;
    case 2538:
        thalf_x0 = 22604117;
        half_x03 = 24315267;
        break;
    case 2539:
        thalf_x0 = 22599665;
        half_x03 = 24300902;
        break;
    case 2540:
        thalf_x0 = 22595219;
        half_x03 = 24286563;
        break;
    case 2541:
        thalf_x0 = 22590773;
        half_x03 = 24272230;
        break;
    case 2542:
        thalf_x0 = 22586330;
        half_x03 = 24257911;
        break;
    case 2543:
        thalf_x0 = 22581888;
        half_x03 = 24243604;
        break;
    case 2544:
        thalf_x0 = 22577451;
        half_x03 = 24229316;
        break;
    case 2545:
        thalf_x0 = 22573016;
        half_x03 = 24215039;
        break;
    case 2546:
        thalf_x0 = 22568583;
        half_x03 = 24200777;
        break;
    case 2547:
        thalf_x0 = 22564154;
        half_x03 = 24186530;
        break;
    case 2548:
        thalf_x0 = 22559726;
        half_x03 = 24172293;
        break;
    case 2549:
        thalf_x0 = 22555299;
        half_x03 = 24158068;
        break;
    case 2550:
        thalf_x0 = 22550880;
        half_x03 = 24143871;
        break;
    case 2551:
        thalf_x0 = 22546461;
        half_x03 = 24129681;
        break;
    case 2552:
        thalf_x0 = 22542045;
        half_x03 = 24115505;
        break;
    case 2553:
        thalf_x0 = 22537629;
        half_x03 = 24101335;
        break;
    case 2554:
        thalf_x0 = 22533216;
        half_x03 = 24087180;
        break;
    case 2555:
        thalf_x0 = 22528808;
        half_x03 = 24073046;
        break;
    case 2556:
        thalf_x0 = 22524401;
        half_x03 = 24058921;
        break;
    case 2557:
        thalf_x0 = 22519997;
        half_x03 = 24044812;
        break;
    case 2558:
        thalf_x0 = 22515596;
        half_x03 = 24030718;
        break;
    case 2559:
        thalf_x0 = 22511196;
        half_x03 = 24016634;
        break;
    case 2560:
        thalf_x0 = 22506800;
        half_x03 = 24002565;
        break;
    case 2561:
        thalf_x0 = 22502405;
        half_x03 = 23988506;
        break;
    case 2562:
        thalf_x0 = 22498013;
        half_x03 = 23974463;
        break;
    case 2563:
        thalf_x0 = 22493627;
        half_x03 = 23960444;
        break;
    case 2564:
        thalf_x0 = 22489239;
        half_x03 = 23946426;
        break;
    case 2565:
        thalf_x0 = 22484856;
        half_x03 = 23932428;
        break;
    case 2566:
        thalf_x0 = 22480476;
        half_x03 = 23918445;
        break;
    case 2567:
        thalf_x0 = 22476098;
        half_x03 = 23904472;
        break;
    case 2568:
        thalf_x0 = 22471721;
        half_x03 = 23890509;
        break;
    case 2569:
        thalf_x0 = 22467348;
        half_x03 = 23876566;
        break;
    case 2570:
        thalf_x0 = 22462979;
        half_x03 = 23862638;
        break;
    case 2571:
        thalf_x0 = 22458611;
        half_x03 = 23848720;
        break;
    case 2572:
        thalf_x0 = 22454244;
        half_x03 = 23834812;
        break;
    case 2573:
        thalf_x0 = 22449881;
        half_x03 = 23820920;
        break;
    case 2574:
        thalf_x0 = 22445520;
        half_x03 = 23807042;
        break;
    case 2575:
        thalf_x0 = 22441164;
        half_x03 = 23793184;
        break;
    case 2576:
        thalf_x0 = 22436808;
        half_x03 = 23779331;
        break;
    case 2577:
        thalf_x0 = 22432454;
        half_x03 = 23765489;
        break;
    case 2578:
        thalf_x0 = 22428105;
        half_x03 = 23751671;
        break;
    case 2579:
        thalf_x0 = 22423760;
        half_x03 = 23737868;
        break;
    case 2580:
        thalf_x0 = 22419413;
        half_x03 = 23724065;
        break;
    case 2581:
        thalf_x0 = 22415069;
        half_x03 = 23710277;
        break;
    case 2582:
        thalf_x0 = 22410728;
        half_x03 = 23696505;
        break;
    case 2583:
        thalf_x0 = 22406391;
        half_x03 = 23682751;
        break;
    case 2584:
        thalf_x0 = 22402056;
        half_x03 = 23669008;
        break;
    case 2585:
        thalf_x0 = 22397724;
        half_x03 = 23655280;
        break;
    case 2586:
        thalf_x0 = 22393392;
        half_x03 = 23641557;
        break;
    case 2587:
        thalf_x0 = 22389063;
        half_x03 = 23627849;
        break;
    case 2588:
        thalf_x0 = 22384740;
        half_x03 = 23614165;
        break;
    case 2589:
        thalf_x0 = 22380419;
        half_x03 = 23600491;
        break;
    case 2590:
        thalf_x0 = 22376097;
        half_x03 = 23586822;
        break;
    case 2591:
        thalf_x0 = 22371779;
        half_x03 = 23573168;
        break;
    case 2592:
        thalf_x0 = 22367463;
        half_x03 = 23559529;
        break;
    case 2593:
        thalf_x0 = 22363152;
        half_x03 = 23545910;
        break;
    case 2594:
        thalf_x0 = 22358841;
        half_x03 = 23532295;
        break;
    case 2595:
        thalf_x0 = 22354533;
        half_x03 = 23518696;
        break;
    case 2596:
        thalf_x0 = 22350228;
        half_x03 = 23505111;
        break;
    case 2597:
        thalf_x0 = 22345928;
        half_x03 = 23491545;
        break;
    case 2598:
        thalf_x0 = 22341626;
        half_x03 = 23477980;
        break;
    case 2599:
        thalf_x0 = 22337328;
        half_x03 = 23464434;
        break;
    case 2600:
        thalf_x0 = 22333034;
        half_x03 = 23450903;
        break;
    case 2601:
        thalf_x0 = 22328741;
        half_x03 = 23437382;
        break;
    case 2602:
        thalf_x0 = 22324451;
        half_x03 = 23423876;
        break;
    case 2603:
        thalf_x0 = 22320164;
        half_x03 = 23410384;
        break;
    case 2604:
        thalf_x0 = 22315877;
        half_x03 = 23396898;
        break;
    case 2605:
        thalf_x0 = 22311593;
        half_x03 = 23383426;
        break;
    case 2606:
        thalf_x0 = 22307315;
        half_x03 = 23369978;
        break;
    case 2607:
        thalf_x0 = 22303037;
        half_x03 = 23356535;
        break;
    case 2608:
        thalf_x0 = 22298760;
        half_x03 = 23343102;
        break;
    case 2609:
        thalf_x0 = 22294487;
        half_x03 = 23329684;
        break;
    case 2610:
        thalf_x0 = 22290218;
        half_x03 = 23316284;
        break;
    case 2611:
        thalf_x0 = 22285947;
        half_x03 = 23302886;
        break;
    case 2612:
        thalf_x0 = 22281683;
        half_x03 = 23289511;
        break;
    case 2613:
        thalf_x0 = 22277420;
        half_x03 = 23276146;
        break;
    case 2614:
        thalf_x0 = 22273160;
        half_x03 = 23262796;
        break;
    case 2615:
        thalf_x0 = 22268901;
        half_x03 = 23249455;
        break;
    case 2616:
        thalf_x0 = 22264644;
        half_x03 = 23236124;
        break;
    case 2617:
        thalf_x0 = 22260392;
        half_x03 = 23222813;
        break;
    case 2618:
        thalf_x0 = 22256141;
        half_x03 = 23209511;
        break;
    case 2619:
        thalf_x0 = 22251893;
        half_x03 = 23196224;
        break;
    case 2620:
        thalf_x0 = 22247645;
        half_x03 = 23182941;
        break;
    case 2621:
        thalf_x0 = 22243401;
        half_x03 = 23169678;
        break;
    case 2622:
        thalf_x0 = 22239161;
        half_x03 = 23156429;
        break;
    case 2623:
        thalf_x0 = 22234922;
        half_x03 = 23143190;
        break;
    case 2624:
        thalf_x0 = 22230686;
        half_x03 = 23129966;
        break;
    case 2625:
        thalf_x0 = 22226451;
        half_x03 = 23116751;
        break;
    case 2626:
        thalf_x0 = 22222217;
        half_x03 = 23103541;
        break;
    case 2627:
        thalf_x0 = 22217990;
        half_x03 = 23090360;
        break;
    case 2628:
        thalf_x0 = 22213764;
        half_x03 = 23077188;
        break;
    case 2629:
        thalf_x0 = 22209539;
        half_x03 = 23064021;
        break;
    case 2630:
        thalf_x0 = 22205316;
        half_x03 = 23050869;
        break;
    case 2631:
        thalf_x0 = 22201100;
        half_x03 = 23037740;
        break;
    case 2632:
        thalf_x0 = 22196880;
        half_x03 = 23024607;
        break;
    case 2633:
        thalf_x0 = 22192665;
        half_x03 = 23011493;
        break;
    case 2634:
        thalf_x0 = 22188453;
        half_x03 = 22998393;
        break;
    case 2635:
        thalf_x0 = 22184243;
        half_x03 = 22985303;
        break;
    case 2636:
        thalf_x0 = 22180037;
        half_x03 = 22972232;
        break;
    case 2637:
        thalf_x0 = 22175832;
        half_x03 = 22959171;
        break;
    case 2638:
        thalf_x0 = 22171628;
        half_x03 = 22946114;
        break;
    case 2639:
        thalf_x0 = 22167428;
        half_x03 = 22933076;
        break;
    case 2640:
        thalf_x0 = 22163231;
        half_x03 = 22920053;
        break;
    case 2641:
        thalf_x0 = 22159034;
        half_x03 = 22907034;
        break;
    case 2642:
        thalf_x0 = 22154841;
        half_x03 = 22894035;
        break;
    case 2643:
        thalf_x0 = 22150652;
        half_x03 = 22881049;
        break;
    case 2644:
        thalf_x0 = 22146461;
        half_x03 = 22868064;
        break;
    case 2645:
        thalf_x0 = 22142276;
        half_x03 = 22855103;
        break;
    case 2646:
        thalf_x0 = 22138092;
        half_x03 = 22842151;
        break;
    case 2647:
        thalf_x0 = 22133909;
        half_x03 = 22829203;
        break;
    case 2648:
        thalf_x0 = 22129731;
        half_x03 = 22816280;
        break;
    case 2649:
        thalf_x0 = 22125554;
        half_x03 = 22803361;
        break;
    case 2650:
        thalf_x0 = 22121379;
        half_x03 = 22790456;
        break;
    case 2651:
        thalf_x0 = 22117209;
        half_x03 = 22777570;
        break;
    case 2652:
        thalf_x0 = 22113038;
        half_x03 = 22764684;
        break;
    case 2653:
        thalf_x0 = 22108872;
        half_x03 = 22751822;
        break;
    case 2654:
        thalf_x0 = 22104708;
        half_x03 = 22738969;
        break;
    case 2655:
        thalf_x0 = 22100544;
        half_x03 = 22726121;
        break;
    case 2656:
        thalf_x0 = 22096385;
        half_x03 = 22713292;
        break;
    case 2657:
        thalf_x0 = 22092227;
        half_x03 = 22700472;
        break;
    case 2658:
        thalf_x0 = 22088072;
        half_x03 = 22687666;
        break;
    case 2659:
        thalf_x0 = 22083920;
        half_x03 = 22674874;
        break;
    case 2660:
        thalf_x0 = 22079768;
        half_x03 = 22662088;
        break;
    case 2661:
        thalf_x0 = 22075620;
        half_x03 = 22649319;
        break;
    case 2662:
        thalf_x0 = 22071473;
        half_x03 = 22636556;
        break;
    case 2663:
        thalf_x0 = 22067330;
        half_x03 = 22623811;
        break;
    case 2664:
        thalf_x0 = 22063190;
        half_x03 = 22611080;
        break;
    case 2665:
        thalf_x0 = 22059050;
        half_x03 = 22598354;
        break;
    case 2666:
        thalf_x0 = 22054911;
        half_x03 = 22585638;
        break;
    case 2667:
        thalf_x0 = 22050780;
        half_x03 = 22572949;
        break;
    case 2668:
        thalf_x0 = 22046645;
        half_x03 = 22560251;
        break;
    case 2669:
        thalf_x0 = 22042515;
        half_x03 = 22547576;
        break;
    case 2670:
        thalf_x0 = 22038387;
        half_x03 = 22534911;
        break;
    case 2671:
        thalf_x0 = 22034265;
        half_x03 = 22522268;
        break;
    case 2672:
        thalf_x0 = 22030140;
        half_x03 = 22509622;
        break;
    case 2673:
        thalf_x0 = 22026021;
        half_x03 = 22496998;
        break;
    case 2674:
        thalf_x0 = 22021904;
        half_x03 = 22484384;
        break;
    case 2675:
        thalf_x0 = 22017788;
        half_x03 = 22471779;
        break;
    case 2676:
        thalf_x0 = 22013673;
        half_x03 = 22459183;
        break;
    case 2677:
        thalf_x0 = 22009563;
        half_x03 = 22446606;
        break;
    case 2678:
        thalf_x0 = 22005452;
        half_x03 = 22434029;
        break;
    case 2679:
        thalf_x0 = 22001345;
        half_x03 = 22421470;
        break;
    case 2680:
        thalf_x0 = 21997241;
        half_x03 = 22408926;
        break;
    case 2681:
        thalf_x0 = 21993137;
        half_x03 = 22396386;
        break;
    case 2682:
        thalf_x0 = 21989040;
        half_x03 = 22383873;
        break;
    case 2683:
        thalf_x0 = 21984944;
        half_x03 = 22371365;
        break;
    case 2684:
        thalf_x0 = 21980847;
        half_x03 = 22358862;
        break;
    case 2685:
        thalf_x0 = 21976754;
        half_x03 = 22346373;
        break;
    case 2686:
        thalf_x0 = 21972665;
        half_x03 = 22333902;
        break;
    case 2687:
        thalf_x0 = 21968576;
        half_x03 = 22321435;
        break;
    case 2688:
        thalf_x0 = 21964488;
        half_x03 = 22308978;
        break;
    case 2689:
        thalf_x0 = 21960407;
        half_x03 = 22296544;
        break;
    case 2690:
        thalf_x0 = 21956325;
        half_x03 = 22284114;
        break;
    case 2691:
        thalf_x0 = 21952245;
        half_x03 = 22271694;
        break;
    case 2692:
        thalf_x0 = 21948168;
        half_x03 = 22259287;
        break;
    case 2693:
        thalf_x0 = 21944096;
        half_x03 = 22246899;
        break;
    case 2694:
        thalf_x0 = 21940020;
        half_x03 = 22234506;
        break;
    case 2695:
        thalf_x0 = 21935952;
        half_x03 = 22222140;
        break;
    case 2696:
        thalf_x0 = 21931884;
        half_x03 = 22209779;
        break;
    case 2697:
        thalf_x0 = 21927816;
        half_x03 = 22197423;
        break;
    case 2698:
        thalf_x0 = 21923756;
        half_x03 = 22185094;
        break;
    case 2699:
        thalf_x0 = 21919692;
        half_x03 = 22172761;
        break;
    case 2700:
        thalf_x0 = 21915635;
        half_x03 = 22160450;
        break;
    case 2701:
        thalf_x0 = 21911579;
        half_x03 = 22148148;
        break;
    case 2702:
        thalf_x0 = 21907523;
        half_x03 = 22135851;
        break;
    case 2703:
        thalf_x0 = 21903473;
        half_x03 = 22123577;
        break;
    case 2704:
        thalf_x0 = 21899421;
        half_x03 = 22111302;
        break;
    case 2705:
        thalf_x0 = 21895373;
        half_x03 = 22099042;
        break;
    case 2706:
        thalf_x0 = 21891327;
        half_x03 = 22086795;
        break;
    case 2707:
        thalf_x0 = 21887285;
        half_x03 = 22074561;
        break;
    case 2708:
        thalf_x0 = 21883245;
        half_x03 = 22062341;
        break;
    case 2709:
        thalf_x0 = 21879206;
        half_x03 = 22050126;
        break;
    case 2710:
        thalf_x0 = 21875171;
        half_x03 = 22037928;
        break;
    case 2711:
        thalf_x0 = 21871137;
        half_x03 = 22025740;
        break;
    case 2712:
        thalf_x0 = 21867105;
        half_x03 = 22013561;
        break;
    case 2713:
        thalf_x0 = 21863075;
        half_x03 = 22001391;
        break;
    case 2714:
        thalf_x0 = 21859044;
        half_x03 = 21989225;
        break;
    case 2715:
        thalf_x0 = 21855021;
        half_x03 = 21977086;
        break;
    case 2716:
        thalf_x0 = 21851000;
        half_x03 = 21964956;
        break;
    case 2717:
        thalf_x0 = 21846980;
        half_x03 = 21952836;
        break;
    case 2718:
        thalf_x0 = 21842960;
        half_x03 = 21940720;
        break;
    case 2719:
        thalf_x0 = 21838943;
        half_x03 = 21928617;
        break;
    case 2720:
        thalf_x0 = 21834929;
        half_x03 = 21916528;
        break;
    case 2721:
        thalf_x0 = 21830916;
        half_x03 = 21904447;
        break;
    case 2722:
        thalf_x0 = 21826907;
        half_x03 = 21892381;
        break;
    case 2723:
        thalf_x0 = 21822899;
        half_x03 = 21880323;
        break;
    case 2724:
        thalf_x0 = 21818894;
        half_x03 = 21868278;
        break;
    case 2725:
        thalf_x0 = 21814889;
        half_x03 = 21856238;
        break;
    case 2726:
        thalf_x0 = 21810890;
        half_x03 = 21844221;
        break;
    case 2727:
        thalf_x0 = 21806892;
        half_x03 = 21832212;
        break;
    case 2728:
        thalf_x0 = 21802895;
        half_x03 = 21820208;
        break;
    case 2729:
        thalf_x0 = 21798900;
        half_x03 = 21808217;
        break;
    case 2730:
        thalf_x0 = 21794909;
        half_x03 = 21796240;
        break;
    case 2731:
        thalf_x0 = 21790919;
        half_x03 = 21784271;
        break;
    case 2732:
        thalf_x0 = 21786932;
        half_x03 = 21772316;
        break;
    case 2733:
        thalf_x0 = 21782943;
        half_x03 = 21760361;
        break;
    case 2734:
        thalf_x0 = 21778961;
        half_x03 = 21748428;
        break;
    case 2735:
        thalf_x0 = 21774981;
        half_x03 = 21736508;
        break;
    case 2736:
        thalf_x0 = 21771002;
        half_x03 = 21724593;
        break;
    case 2737:
        thalf_x0 = 21767024;
        half_x03 = 21712687;
        break;
    case 2738:
        thalf_x0 = 21763052;
        half_x03 = 21700802;
        break;
    case 2739:
        thalf_x0 = 21759077;
        half_x03 = 21688914;
        break;
    case 2740:
        thalf_x0 = 21755109;
        half_x03 = 21677052;
        break;
    case 2741:
        thalf_x0 = 21751140;
        half_x03 = 21665190;
        break;
    case 2742:
        thalf_x0 = 21747176;
        half_x03 = 21653345;
        break;
    case 2743:
        thalf_x0 = 21743210;
        half_x03 = 21641501;
        break;
    case 2744:
        thalf_x0 = 21739247;
        half_x03 = 21629670;
        break;
    case 2745:
        thalf_x0 = 21735288;
        half_x03 = 21617856;
        break;
    case 2746:
        thalf_x0 = 21731333;
        half_x03 = 21606056;
        break;
    case 2747:
        thalf_x0 = 21727376;
        half_x03 = 21594256;
        break;
    case 2748:
        thalf_x0 = 21723423;
        half_x03 = 21582473;
        break;
    case 2749:
        thalf_x0 = 21719474;
        half_x03 = 21570703;
        break;
    case 2750:
        thalf_x0 = 21715524;
        half_x03 = 21558938;
        break;
    case 2751:
        thalf_x0 = 21711578;
        half_x03 = 21547186;
        break;
    case 2752:
        thalf_x0 = 21707631;
        half_x03 = 21535438;
        break;
    case 2753:
        thalf_x0 = 21703692;
        half_x03 = 21523717;
        break;
    case 2754:
        thalf_x0 = 21699749;
        half_x03 = 21511987;
        break;
    case 2755:
        thalf_x0 = 21695811;
        half_x03 = 21500279;
        break;
    case 2756:
        thalf_x0 = 21691875;
        half_x03 = 21488579;
        break;
    case 2757:
        thalf_x0 = 21687945;
        half_x03 = 21476902;
        break;
    case 2758:
        thalf_x0 = 21684012;
        half_x03 = 21465220;
        break;
    case 2759:
        thalf_x0 = 21680084;
        half_x03 = 21453555;
        break;
    case 2760:
        thalf_x0 = 21676155;
        half_x03 = 21441895;
        break;
    case 2761:
        thalf_x0 = 21672230;
        half_x03 = 21430248;
        break;
    case 2762:
        thalf_x0 = 21668309;
        half_x03 = 21418618;
        break;
    case 2763:
        thalf_x0 = 21664388;
        half_x03 = 21406993;
        break;
    case 2764:
        thalf_x0 = 21660468;
        half_x03 = 21395377;
        break;
    case 2765:
        thalf_x0 = 21656552;
        half_x03 = 21383773;
        break;
    case 2766:
        thalf_x0 = 21652637;
        half_x03 = 21372178;
        break;
    case 2767:
        thalf_x0 = 21648725;
        half_x03 = 21360596;
        break;
    case 2768:
        thalf_x0 = 21644813;
        half_x03 = 21349018;
        break;
    case 2769:
        thalf_x0 = 21640907;
        half_x03 = 21337462;
        break;
    case 2770:
        thalf_x0 = 21636999;
        half_x03 = 21325906;
        break;
    case 2771:
        thalf_x0 = 21633096;
        half_x03 = 21314368;
        break;
    case 2772:
        thalf_x0 = 21629196;
        half_x03 = 21302842;
        break;
    case 2773:
        thalf_x0 = 21625296;
        half_x03 = 21291321;
        break;
    case 2774:
        thalf_x0 = 21621398;
        half_x03 = 21279808;
        break;
    case 2775:
        thalf_x0 = 21617501;
        half_x03 = 21268304;
        break;
    case 2776:
        thalf_x0 = 21613608;
        half_x03 = 21256817;
        break;
    case 2777:
        thalf_x0 = 21609719;
        half_x03 = 21245343;
        break;
    case 2778:
        thalf_x0 = 21605829;
        half_x03 = 21233874;
        break;
    case 2779:
        thalf_x0 = 21601943;
        half_x03 = 21222417;
        break;
    case 2780:
        thalf_x0 = 21598058;
        half_x03 = 21210969;
        break;
    case 2781:
        thalf_x0 = 21594176;
        half_x03 = 21199534;
        break;
    case 2782:
        thalf_x0 = 21590294;
        half_x03 = 21188102;
        break;
    case 2783:
        thalf_x0 = 21586416;
        half_x03 = 21176689;
        break;
    case 2784:
        thalf_x0 = 21582539;
        half_x03 = 21165279;
        break;
    case 2785:
        thalf_x0 = 21578664;
        half_x03 = 21153882;
        break;
    case 2786:
        thalf_x0 = 21574791;
        half_x03 = 21142494;
        break;
    case 2787:
        thalf_x0 = 21570923;
        half_x03 = 21131123;
        break;
    case 2788:
        thalf_x0 = 21567056;
        half_x03 = 21119761;
        break;
    case 2789:
        thalf_x0 = 21563186;
        half_x03 = 21108394;
        break;
    case 2790:
        thalf_x0 = 21559323;
        half_x03 = 21097052;
        break;
    case 2791:
        thalf_x0 = 21555461;
        half_x03 = 21085715;
        break;
    case 2792:
        thalf_x0 = 21551601;
        half_x03 = 21074391;
        break;
    case 2793:
        thalf_x0 = 21547745;
        half_x03 = 21063080;
        break;
    case 2794:
        thalf_x0 = 21543890;
        half_x03 = 21051777;
        break;
    case 2795:
        thalf_x0 = 21540035;
        half_x03 = 21040478;
        break;
    case 2796:
        thalf_x0 = 21536184;
        half_x03 = 21029197;
        break;
    case 2797:
        thalf_x0 = 21532332;
        half_x03 = 21017915;
        break;
    case 2798:
        thalf_x0 = 21528485;
        half_x03 = 21006650;
        break;
    case 2799:
        thalf_x0 = 21524640;
        half_x03 = 20995398;
        break;
    case 2800:
        thalf_x0 = 21520797;
        half_x03 = 20984155;
        break;
    case 2801:
        thalf_x0 = 21516957;
        half_x03 = 20972924;
        break;
    case 2802:
        thalf_x0 = 21513117;
        half_x03 = 20961697;
        break;
    case 2803:
        thalf_x0 = 21509279;
        half_x03 = 20950479;
        break;
    case 2804:
        thalf_x0 = 21505443;
        half_x03 = 20939273;
        break;
    case 2805:
        thalf_x0 = 21501611;
        half_x03 = 20928080;
        break;
    case 2806:
        thalf_x0 = 21497781;
        half_x03 = 20916900;
        break;
    case 2807:
        thalf_x0 = 21493952;
        half_x03 = 20905724;
        break;
    case 2808:
        thalf_x0 = 21490124;
        half_x03 = 20894557;
        break;
    case 2809:
        thalf_x0 = 21486299;
        half_x03 = 20883402;
        break;
    case 2810:
        thalf_x0 = 21482477;
        half_x03 = 20872259;
        break;
    case 2811:
        thalf_x0 = 21478656;
        half_x03 = 20861125;
        break;
    case 2812:
        thalf_x0 = 21474836;
        half_x03 = 20849995;
        break;
    case 2813:
        thalf_x0 = 21471020;
        half_x03 = 20838882;
        break;
    case 2814:
        thalf_x0 = 21467207;
        half_x03 = 20827782;
        break;
    case 2815:
        thalf_x0 = 21463392;
        half_x03 = 20816681;
        break;
    case 2816:
        thalf_x0 = 21459581;
        half_x03 = 20805593;
        break;
    case 2817:
        thalf_x0 = 21455774;
        half_x03 = 20794523;
        break;
    case 2818:
        thalf_x0 = 21451968;
        half_x03 = 20783460;
        break;
    case 2819:
        thalf_x0 = 21448163;
        half_x03 = 20772401;
        break;
    case 2820:
        thalf_x0 = 21444360;
        half_x03 = 20761355;
        break;
    case 2821:
        thalf_x0 = 21440559;
        half_x03 = 20750317;
        break;
    case 2822:
        thalf_x0 = 21436761;
        half_x03 = 20739292;
        break;
    case 2823:
        thalf_x0 = 21432965;
        half_x03 = 20728275;
        break;
    case 2824:
        thalf_x0 = 21429170;
        half_x03 = 20717266;
        break;
    case 2825:
        thalf_x0 = 21425378;
        half_x03 = 20706270;
        break;
    case 2826:
        thalf_x0 = 21421586;
        half_x03 = 20695278;
        break;
    case 2827:
        thalf_x0 = 21417800;
        half_x03 = 20684307;
        break;
    case 2828:
        thalf_x0 = 21414012;
        half_x03 = 20673335;
        break;
    case 2829:
        thalf_x0 = 21410228;
        half_x03 = 20662377;
        break;
    case 2830:
        thalf_x0 = 21406445;
        half_x03 = 20651426;
        break;
    case 2831:
        thalf_x0 = 21402665;
        half_x03 = 20640488;
        break;
    case 2832:
        thalf_x0 = 21398885;
        half_x03 = 20629554;
        break;
    case 2833:
        thalf_x0 = 21395111;
        half_x03 = 20618640;
        break;
    case 2834:
        thalf_x0 = 21391335;
        half_x03 = 20607727;
        break;
    case 2835:
        thalf_x0 = 21387563;
        half_x03 = 20596826;
        break;
    case 2836:
        thalf_x0 = 21383792;
        half_x03 = 20585933;
        break;
    case 2837:
        thalf_x0 = 21380024;
        half_x03 = 20575053;
        break;
    case 2838:
        thalf_x0 = 21376259;
        half_x03 = 20564185;
        break;
    case 2839:
        thalf_x0 = 21372494;
        half_x03 = 20553321;
        break;
    case 2840:
        thalf_x0 = 21368732;
        half_x03 = 20542470;
        break;
    case 2841:
        thalf_x0 = 21364971;
        half_x03 = 20531626;
        break;
    case 2842:
        thalf_x0 = 21361214;
        half_x03 = 20520795;
        break;
    case 2843:
        thalf_x0 = 21357456;
        half_x03 = 20509968;
        break;
    case 2844:
        thalf_x0 = 21353702;
        half_x03 = 20499154;
        break;
    case 2845:
        thalf_x0 = 21349947;
        half_x03 = 20488343;
        break;
    case 2846:
        thalf_x0 = 21346200;
        half_x03 = 20477557;
        break;
    case 2847:
        thalf_x0 = 21342449;
        half_x03 = 20466763;
        break;
    case 2848:
        thalf_x0 = 21338703;
        half_x03 = 20455989;
        break;
    case 2849:
        thalf_x0 = 21334958;
        half_x03 = 20445219;
        break;
    case 2850:
        thalf_x0 = 21331215;
        half_x03 = 20434462;
        break;
    case 2851:
        thalf_x0 = 21327477;
        half_x03 = 20423721;
        break;
    case 2852:
        thalf_x0 = 21323736;
        half_x03 = 20412976;
        break;
    case 2853:
        thalf_x0 = 21320001;
        half_x03 = 20402251;
        break;
    case 2854:
        thalf_x0 = 21316268;
        half_x03 = 20391535;
        break;
    case 2855:
        thalf_x0 = 21312533;
        half_x03 = 20380818;
        break;
    case 2856:
        thalf_x0 = 21308804;
        half_x03 = 20370122;
        break;
    case 2857:
        thalf_x0 = 21305072;
        half_x03 = 20359421;
        break;
    case 2858:
        thalf_x0 = 21301344;
        half_x03 = 20348736;
        break;
    case 2859:
        thalf_x0 = 21297620;
        half_x03 = 20338064;
        break;
    case 2860:
        thalf_x0 = 21293897;
        half_x03 = 20327400;
        break;
    case 2861:
        thalf_x0 = 21290177;
        half_x03 = 20316749;
        break;
    case 2862:
        thalf_x0 = 21286457;
        half_x03 = 20306101;
        break;
    case 2863:
        thalf_x0 = 21282740;
        half_x03 = 20295465;
        break;
    case 2864:
        thalf_x0 = 21279024;
        half_x03 = 20284838;
        break;
    case 2865:
        thalf_x0 = 21275312;
        half_x03 = 20274223;
        break;
    case 2866:
        thalf_x0 = 21271599;
        half_x03 = 20263611;
        break;
    case 2867:
        thalf_x0 = 21267890;
        half_x03 = 20253012;
        break;
    case 2868:
        thalf_x0 = 21264183;
        half_x03 = 20242425;
        break;
    case 2869:
        thalf_x0 = 21260477;
        half_x03 = 20231841;
        break;
    case 2870:
        thalf_x0 = 21256775;
        half_x03 = 20221274;
        break;
    case 2871:
        thalf_x0 = 21253073;
        half_x03 = 20210711;
        break;
    case 2872:
        thalf_x0 = 21249372;
        half_x03 = 20200156;
        break;
    case 2873:
        thalf_x0 = 21245675;
        half_x03 = 20189613;
        break;
    case 2874:
        thalf_x0 = 21241979;
        half_x03 = 20179078;
        break;
    case 2875:
        thalf_x0 = 21238286;
        half_x03 = 20168555;
        break;
    case 2876:
        thalf_x0 = 21234593;
        half_x03 = 20158036;
        break;
    case 2877:
        thalf_x0 = 21230904;
        half_x03 = 20147533;
        break;
    case 2878:
        thalf_x0 = 21227216;
        half_x03 = 20137034;
        break;
    case 2879:
        thalf_x0 = 21223529;
        half_x03 = 20126543;
        break;
    case 2880:
        thalf_x0 = 21219843;
        half_x03 = 20116060;
        break;
    case 2881:
        thalf_x0 = 21216161;
        half_x03 = 20105589;
        break;
    case 2882:
        thalf_x0 = 21212483;
        half_x03 = 20095135;
        break;
    case 2883:
        thalf_x0 = 21208802;
        half_x03 = 20084675;
        break;
    case 2884:
        thalf_x0 = 21205127;
        half_x03 = 20074236;
        break;
    case 2885:
        thalf_x0 = 21201452;
        half_x03 = 20063801;
        break;
    case 2886:
        thalf_x0 = 21197780;
        half_x03 = 20053378;
        break;
    case 2887:
        thalf_x0 = 21194108;
        half_x03 = 20042958;
        break;
    case 2888:
        thalf_x0 = 21190439;
        half_x03 = 20032551;
        break;
    case 2889:
        thalf_x0 = 21186773;
        half_x03 = 20022156;
        break;
    case 2890:
        thalf_x0 = 21183107;
        half_x03 = 20011764;
        break;
    case 2891:
        thalf_x0 = 21179441;
        half_x03 = 20001376;
        break;
    case 2892:
        thalf_x0 = 21175781;
        half_x03 = 19991009;
        break;
    case 2893:
        thalf_x0 = 21172121;
        half_x03 = 19980645;
        break;
    case 2894:
        thalf_x0 = 21168465;
        half_x03 = 19970297;
        break;
    case 2895:
        thalf_x0 = 21164808;
        half_x03 = 19959949;
        break;
    case 2896:
        thalf_x0 = 21161153;
        half_x03 = 19949608;
        break;
    case 2897:
        thalf_x0 = 21157502;
        half_x03 = 19939284;
        break;
    case 2898:
        thalf_x0 = 21153854;
        half_x03 = 19928972;
        break;
    case 2899:
        thalf_x0 = 21150204;
        half_x03 = 19918660;
        break;
    case 2900:
        thalf_x0 = 21146558;
        half_x03 = 19908359;
        break;
    case 2901:
        thalf_x0 = 21142916;
        half_x03 = 19898074;
        break;
    case 2902:
        thalf_x0 = 21139272;
        half_x03 = 19887789;
        break;
    case 2903:
        thalf_x0 = 21135632;
        half_x03 = 19877516;
        break;
    case 2904:
        thalf_x0 = 21131993;
        half_x03 = 19867251;
        break;
    case 2905:
        thalf_x0 = 21128357;
        half_x03 = 19856997;
        break;
    case 2906:
        thalf_x0 = 21124721;
        half_x03 = 19846747;
        break;
    case 2907:
        thalf_x0 = 21121088;
        half_x03 = 19836509;
        break;
    case 2908:
        thalf_x0 = 21117456;
        half_x03 = 19826279;
        break;
    case 2909:
        thalf_x0 = 21113828;
        half_x03 = 19816061;
        break;
    case 2910:
        thalf_x0 = 21110199;
        half_x03 = 19805846;
        break;
    case 2911:
        thalf_x0 = 21106574;
        half_x03 = 19795644;
        break;
    case 2912:
        thalf_x0 = 21102950;
        half_x03 = 19785449;
        break;
    case 2913:
        thalf_x0 = 21099329;
        half_x03 = 19775266;
        break;
    case 2914:
        thalf_x0 = 21095708;
        half_x03 = 19765086;
        break;
    case 2915:
        thalf_x0 = 21092090;
        half_x03 = 19754918;
        break;
    case 2916:
        thalf_x0 = 21088473;
        half_x03 = 19744759;
        break;
    case 2917:
        thalf_x0 = 21084860;
        half_x03 = 19734611;
        break;
    case 2918:
        thalf_x0 = 21081248;
        half_x03 = 19724470;
        break;
    case 2919:
        thalf_x0 = 21077636;
        half_x03 = 19714333;
        break;
    case 2920:
        thalf_x0 = 21074027;
        half_x03 = 19704208;
        break;
    case 2921:
        thalf_x0 = 21070421;
        half_x03 = 19694095;
        break;
    case 2922:
        thalf_x0 = 21066815;
        half_x03 = 19683986;
        break;
    case 2923:
        thalf_x0 = 21063213;
        half_x03 = 19673892;
        break;
    case 2924:
        thalf_x0 = 21059609;
        half_x03 = 19663793;
        break;
    case 2925:
        thalf_x0 = 21056012;
        half_x03 = 19653720;
        break;
    case 2926:
        thalf_x0 = 21052413;
        half_x03 = 19643645;
        break;
    case 2927:
        thalf_x0 = 21048816;
        half_x03 = 19633577;
        break;
    case 2928:
        thalf_x0 = 21045224;
        half_x03 = 19623526;
        break;
    case 2929:
        thalf_x0 = 21041630;
        half_x03 = 19613474;
        break;
    case 2930:
        thalf_x0 = 21038040;
        half_x03 = 19603439;
        break;
    case 2931:
        thalf_x0 = 21034452;
        half_x03 = 19593410;
        break;
    case 2932:
        thalf_x0 = 21030864;
        half_x03 = 19583385;
        break;
    case 2933:
        thalf_x0 = 21027279;
        half_x03 = 19573372;
        break;
    case 2934:
        thalf_x0 = 21023697;
        half_x03 = 19563371;
        break;
    case 2935:
        thalf_x0 = 21020115;
        half_x03 = 19553373;
        break;
    case 2936:
        thalf_x0 = 21016535;
        half_x03 = 19543383;
        break;
    case 2937:
        thalf_x0 = 21012959;
        half_x03 = 19533409;
        break;
    case 2938:
        thalf_x0 = 21009383;
        half_x03 = 19523438;
        break;
    case 2939:
        thalf_x0 = 21005808;
        half_x03 = 19513474;
        break;
    case 2940:
        thalf_x0 = 21002237;
        half_x03 = 19503523;
        break;
    case 2941:
        thalf_x0 = 20998665;
        half_x03 = 19493574;
        break;
    case 2942:
        thalf_x0 = 20995097;
        half_x03 = 19483638;
        break;
    case 2943:
        thalf_x0 = 20991531;
        half_x03 = 19473713;
        break;
    case 2944:
        thalf_x0 = 20987967;
        half_x03 = 19463796;
        break;
    case 2945:
        thalf_x0 = 20984403;
        half_x03 = 19453882;
        break;
    case 2946:
        thalf_x0 = 20980841;
        half_x03 = 19443976;
        break;
    case 2947:
        thalf_x0 = 20977284;
        half_x03 = 19434090;
        break;
    case 2948:
        thalf_x0 = 20973723;
        half_x03 = 19424194;
        break;
    case 2949:
        thalf_x0 = 20970170;
        half_x03 = 19414323;
        break;
    case 2950:
        thalf_x0 = 20966616;
        half_x03 = 19404455;
        break;
    case 2951:
        thalf_x0 = 20963063;
        half_x03 = 19394590;
        break;
    case 2952:
        thalf_x0 = 20959512;
        half_x03 = 19384738;
        break;
    case 2953:
        thalf_x0 = 20955963;
        half_x03 = 19374892;
        break;
    case 2954:
        thalf_x0 = 20952419;
        half_x03 = 19365063;
        break;
    case 2955:
        thalf_x0 = 20948873;
        half_x03 = 19355232;
        break;
    case 2956:
        thalf_x0 = 20945328;
        half_x03 = 19345409;
        break;
    case 2957:
        thalf_x0 = 20941787;
        half_x03 = 19335598;
        break;
    case 2958:
        thalf_x0 = 20938247;
        half_x03 = 19325794;
        break;
    case 2959:
        thalf_x0 = 20934711;
        half_x03 = 19316006;
        break;
    case 2960:
        thalf_x0 = 20931176;
        half_x03 = 19306221;
        break;
    case 2961:
        thalf_x0 = 20927640;
        half_x03 = 19296440;
        break;
    case 2962:
        thalf_x0 = 20924108;
        half_x03 = 19286670;
        break;
    case 2963:
        thalf_x0 = 20920577;
        half_x03 = 19276908;
        break;
    case 2964:
        thalf_x0 = 20917049;
        half_x03 = 19267157;
        break;
    case 2965:
        thalf_x0 = 20913521;
        half_x03 = 19257409;
        break;
    case 2966:
        thalf_x0 = 20909997;
        half_x03 = 19247678;
        break;
    case 2967:
        thalf_x0 = 20906474;
        half_x03 = 19237949;
        break;
    case 2968:
        thalf_x0 = 20902952;
        half_x03 = 19228228;
        break;
    case 2969:
        thalf_x0 = 20899431;
        half_x03 = 19218514;
        break;
    case 2970:
        thalf_x0 = 20895912;
        half_x03 = 19208808;
        break;
    case 2971:
        thalf_x0 = 20892396;
        half_x03 = 19199113;
        break;
    case 2972:
        thalf_x0 = 20888882;
        half_x03 = 19189426;
        break;
    case 2973:
        thalf_x0 = 20885369;
        half_x03 = 19179746;
        break;
    case 2974:
        thalf_x0 = 20881859;
        half_x03 = 19170078;
        break;
    case 2975:
        thalf_x0 = 20878349;
        half_x03 = 19160412;
        break;
    case 2976:
        thalf_x0 = 20874842;
        half_x03 = 19150759;
        break;
    case 2977:
        thalf_x0 = 20871335;
        half_x03 = 19141108;
        break;
    case 2978:
        thalf_x0 = 20867832;
        half_x03 = 19131473;
        break;
    case 2979:
        thalf_x0 = 20864330;
        half_x03 = 19121842;
        break;
    case 2980:
        thalf_x0 = 20860829;
        half_x03 = 19112218;
        break;
    case 2981:
        thalf_x0 = 20857332;
        half_x03 = 19102609;
        break;
    case 2982:
        thalf_x0 = 20853836;
        half_x03 = 19093004;
        break;
    case 2983:
        thalf_x0 = 20850338;
        half_x03 = 19083397;
        break;
    case 2984:
        thalf_x0 = 20846844;
        half_x03 = 19073807;
        break;
    case 2985:
        thalf_x0 = 20843352;
        half_x03 = 19064223;
        break;
    case 2986:
        thalf_x0 = 20839863;
        half_x03 = 19054651;
        break;
    case 2987:
        thalf_x0 = 20836377;
        half_x03 = 19045091;
        break;
    case 2988:
        thalf_x0 = 20832888;
        half_x03 = 19035525;
        break;
    case 2989:
        thalf_x0 = 20829405;
        half_x03 = 19025979;
        break;
    case 2990:
        thalf_x0 = 20825924;
        half_x03 = 19016441;
        break;
    case 2991:
        thalf_x0 = 20822441;
        half_x03 = 19006901;
        break;
    case 2992:
        thalf_x0 = 20818961;
        half_x03 = 18997373;
        break;
    case 2993:
        thalf_x0 = 20815484;
        half_x03 = 18987856;
        break;
    case 2994:
        thalf_x0 = 20812008;
        half_x03 = 18978347;
        break;
    case 2995:
        thalf_x0 = 20808533;
        half_x03 = 18968841;
        break;
    case 2996:
        thalf_x0 = 20805062;
        half_x03 = 18959350;
        break;
    case 2997:
        thalf_x0 = 20801591;
        half_x03 = 18949862;
        break;
    case 2998:
        thalf_x0 = 20798123;
        half_x03 = 18940386;
        break;
    case 2999:
        thalf_x0 = 20794656;
        half_x03 = 18930917;
        break;
    case 3000:
        thalf_x0 = 20791188;
        half_x03 = 18921447;
        break;
    case 3001:
        thalf_x0 = 20787723;
        half_x03 = 18911988;
        break;
    case 3002:
        thalf_x0 = 20784264;
        half_x03 = 18902549;
        break;
    case 3003:
        thalf_x0 = 20780801;
        half_x03 = 18893101;
        break;
    case 3004:
        thalf_x0 = 20777343;
        half_x03 = 18883672;
        break;
    case 3005:
        thalf_x0 = 20773887;
        half_x03 = 18874251;
        break;
    case 3006:
        thalf_x0 = 20770431;
        half_x03 = 18864832;
        break;
    case 3007:
        thalf_x0 = 20766981;
        half_x03 = 18855434;
        break;
    case 3008:
        thalf_x0 = 20763527;
        half_x03 = 18846026;
        break;
    case 3009:
        thalf_x0 = 20760080;
        half_x03 = 18836641;
        break;
    case 3010:
        thalf_x0 = 20756628;
        half_x03 = 18827247;
        break;
    case 3011:
        thalf_x0 = 20753183;
        half_x03 = 18817873;
        break;
    case 3012:
        thalf_x0 = 20749737;
        half_x03 = 18808502;
        break;
    case 3013:
        thalf_x0 = 20746293;
        half_x03 = 18799138;
        break;
    case 3014:
        thalf_x0 = 20742854;
        half_x03 = 18789790;
        break;
    case 3015:
        thalf_x0 = 20739416;
        half_x03 = 18780449;
        break;
    case 3016:
        thalf_x0 = 20735976;
        half_x03 = 18771106;
        break;
    case 3017:
        thalf_x0 = 20732540;
        half_x03 = 18761775;
        break;
    case 3018:
        thalf_x0 = 20729105;
        half_x03 = 18752451;
        break;
    case 3019:
        thalf_x0 = 20725673;
        half_x03 = 18743139;
        break;
    case 3020:
        thalf_x0 = 20722241;
        half_x03 = 18733829;
        break;
    case 3021:
        thalf_x0 = 20718809;
        half_x03 = 18724523;
        break;
    case 3022:
        thalf_x0 = 20715384;
        half_x03 = 18715240;
        break;
    case 3023:
        thalf_x0 = 20711957;
        half_x03 = 18705951;
        break;
    case 3024:
        thalf_x0 = 20708534;
        half_x03 = 18696679;
        break;
    case 3025:
        thalf_x0 = 20705112;
        half_x03 = 18687413;
        break;
    case 3026:
        thalf_x0 = 20701691;
        half_x03 = 18678150;
        break;
    case 3027:
        thalf_x0 = 20698271;
        half_x03 = 18668894;
        break;
    case 3028:
        thalf_x0 = 20694852;
        half_x03 = 18659646;
        break;
    case 3029:
        thalf_x0 = 20691437;
        half_x03 = 18650409;
        break;
    case 3030:
        thalf_x0 = 20688023;
        half_x03 = 18641179;
        break;
    case 3031:
        thalf_x0 = 20684609;
        half_x03 = 18631951;
        break;
    case 3032:
        thalf_x0 = 20681199;
        half_x03 = 18622739;
        break;
    case 3033:
        thalf_x0 = 20677790;
        half_x03 = 18613530;
        break;
    case 3034:
        thalf_x0 = 20674383;
        half_x03 = 18604333;
        break;
    case 3035:
        thalf_x0 = 20670977;
        half_x03 = 18595138;
        break;
    case 3036:
        thalf_x0 = 20667573;
        half_x03 = 18585954;
        break;
    case 3037:
        thalf_x0 = 20664170;
        half_x03 = 18576774;
        break;
    case 3038:
        thalf_x0 = 20660771;
        half_x03 = 18567608;
        break;
    case 3039:
        thalf_x0 = 20657372;
        half_x03 = 18558446;
        break;
    case 3040:
        thalf_x0 = 20653976;
        half_x03 = 18549295;
        break;
    case 3041:
        thalf_x0 = 20650580;
        half_x03 = 18540146;
        break;
    case 3042:
        thalf_x0 = 20647185;
        half_x03 = 18531005;
        break;
    case 3043:
        thalf_x0 = 20643792;
        half_x03 = 18521871;
        break;
    case 3044:
        thalf_x0 = 20640404;
        half_x03 = 18512752;
        break;
    case 3045:
        thalf_x0 = 20637012;
        half_x03 = 18503627;
        break;
    case 3046:
        thalf_x0 = 20633627;
        half_x03 = 18494522;
        break;
    case 3047:
        thalf_x0 = 20630240;
        half_x03 = 18485416;
        break;
    case 3048:
        thalf_x0 = 20626856;
        half_x03 = 18476321;
        break;
    case 3049:
        thalf_x0 = 20623475;
        half_x03 = 18467237;
        break;
    case 3050:
        thalf_x0 = 20620092;
        half_x03 = 18458152;
        break;
    case 3051:
        thalf_x0 = 20616713;
        half_x03 = 18449078;
        break;
    case 3052:
        thalf_x0 = 20613338;
        half_x03 = 18440019;
        break;
    case 3053:
        thalf_x0 = 20609960;
        half_x03 = 18430955;
        break;
    case 3054:
        thalf_x0 = 20606585;
        half_x03 = 18421902;
        break;
    case 3055:
        thalf_x0 = 20603213;
        half_x03 = 18412860;
        break;
    case 3056:
        thalf_x0 = 20599844;
        half_x03 = 18403829;
        break;
    case 3057:
        thalf_x0 = 20596476;
        half_x03 = 18394805;
        break;
    case 3058:
        thalf_x0 = 20593107;
        half_x03 = 18385780;
        break;
    case 3059:
        thalf_x0 = 20589744;
        half_x03 = 18376774;
        break;
    case 3060:
        thalf_x0 = 20586377;
        half_x03 = 18367758;
        break;
    case 3061:
        thalf_x0 = 20583015;
        half_x03 = 18358762;
        break;
    case 3062:
        thalf_x0 = 20579654;
        half_x03 = 18349769;
        break;
    case 3063:
        thalf_x0 = 20576295;
        half_x03 = 18340787;
        break;
    case 3064:
        thalf_x0 = 20572940;
        half_x03 = 18331815;
        break;
    case 3065:
        thalf_x0 = 20569583;
        half_x03 = 18322843;
        break;
    case 3066:
        thalf_x0 = 20566227;
        half_x03 = 18313877;
        break;
    case 3067:
        thalf_x0 = 20562876;
        half_x03 = 18304927;
        break;
    case 3068:
        thalf_x0 = 20559525;
        half_x03 = 18295979;
        break;
    case 3069:
        thalf_x0 = 20556176;
        half_x03 = 18287038;
        break;
    case 3070:
        thalf_x0 = 20552828;
        half_x03 = 18278105;
        break;
    case 3071:
        thalf_x0 = 20549481;
        half_x03 = 18269178;
        break;
    case 3072:
        thalf_x0 = 20546138;
        half_x03 = 18260262;
        break;
    case 3073:
        thalf_x0 = 20542796;
        half_x03 = 18251353;
        break;
    case 3074:
        thalf_x0 = 20539454;
        half_x03 = 18242446;
        break;
    case 3075:
        thalf_x0 = 20536115;
        half_x03 = 18233551;
        break;
    case 3076:
        thalf_x0 = 20532776;
        half_x03 = 18224659;
        break;
    case 3077:
        thalf_x0 = 20529440;
        half_x03 = 18215777;
        break;
    case 3078:
        thalf_x0 = 20526107;
        half_x03 = 18206906;
        break;
    case 3079:
        thalf_x0 = 20522772;
        half_x03 = 18198035;
        break;
    case 3080:
        thalf_x0 = 20519441;
        half_x03 = 18189174;
        break;
    case 3081:
        thalf_x0 = 20516112;
        half_x03 = 18180324;
        break;
    case 3082:
        thalf_x0 = 20512784;
        half_x03 = 18171476;
        break;
    case 3083:
        thalf_x0 = 20509455;
        half_x03 = 18162632;
        break;
    case 3084:
        thalf_x0 = 20506131;
        half_x03 = 18153803;
        break;
    case 3085:
        thalf_x0 = 20502809;
        half_x03 = 18144980;
        break;
    case 3086:
        thalf_x0 = 20499488;
        half_x03 = 18136164;
        break;
    case 3087:
        thalf_x0 = 20496167;
        half_x03 = 18127351;
        break;
    case 3088:
        thalf_x0 = 20492849;
        half_x03 = 18118549;
        break;
    case 3089:
        thalf_x0 = 20489532;
        half_x03 = 18109754;
        break;
    case 3090:
        thalf_x0 = 20486217;
        half_x03 = 18100965;
        break;
    case 3091:
        thalf_x0 = 20482905;
        half_x03 = 18092187;
        break;
    case 3092:
        thalf_x0 = 20479592;
        half_x03 = 18083409;
        break;
    case 3093:
        thalf_x0 = 20476281;
        half_x03 = 18074640;
        break;
    case 3094:
        thalf_x0 = 20472972;
        half_x03 = 18065879;
        break;
    case 3095:
        thalf_x0 = 20469665;
        half_x03 = 18057125;
        break;
    case 3096:
        thalf_x0 = 20466360;
        half_x03 = 18048381;
        break;
    case 3097:
        thalf_x0 = 20463056;
        half_x03 = 18039640;
        break;
    case 3098:
        thalf_x0 = 20459753;
        half_x03 = 18030906;
        break;
    case 3099:
        thalf_x0 = 20456451;
        half_x03 = 18022179;
        break;
    case 3100:
        thalf_x0 = 20453153;
        half_x03 = 18013462;
        break;
    case 3101:
        thalf_x0 = 20449857;
        half_x03 = 18004756;
        break;
    case 3102:
        thalf_x0 = 20446560;
        half_x03 = 17996050;
        break;
    case 3103:
        thalf_x0 = 20443265;
        half_x03 = 17987349;
        break;
    case 3104:
        thalf_x0 = 20439972;
        half_x03 = 17978660;
        break;
    case 3105:
        thalf_x0 = 20436681;
        half_x03 = 17969977;
        break;
    case 3106:
        thalf_x0 = 20433392;
        half_x03 = 17961301;
        break;
    case 3107:
        thalf_x0 = 20430104;
        half_x03 = 17952632;
        break;
    case 3108:
        thalf_x0 = 20426817;
        half_x03 = 17943969;
        break;
    case 3109:
        thalf_x0 = 20423532;
        half_x03 = 17935314;
        break;
    case 3110:
        thalf_x0 = 20420249;
        half_x03 = 17926665;
        break;
    case 3111:
        thalf_x0 = 20416968;
        half_x03 = 17918026;
        break;
    case 3112:
        thalf_x0 = 20413685;
        half_x03 = 17909383;
        break;
    case 3113:
        thalf_x0 = 20410409;
        half_x03 = 17900762;
        break;
    case 3114:
        thalf_x0 = 20407131;
        half_x03 = 17892140;
        break;
    case 3115:
        thalf_x0 = 20403855;
        half_x03 = 17883524;
        break;
    case 3116:
        thalf_x0 = 20400581;
        half_x03 = 17874916;
        break;
    case 3117:
        thalf_x0 = 20397312;
        half_x03 = 17866326;
        break;
    case 3118:
        thalf_x0 = 20394039;
        half_x03 = 17857726;
        break;
    case 3119:
        thalf_x0 = 20390772;
        half_x03 = 17849146;
        break;
    case 3120:
        thalf_x0 = 20387505;
        half_x03 = 17840568;
        break;
    case 3121:
        thalf_x0 = 20384235;
        half_x03 = 17831985;
        break;
    case 3122:
        thalf_x0 = 20380971;
        half_x03 = 17823420;
        break;
    case 3123:
        thalf_x0 = 20377713;
        half_x03 = 17814874;
        break;
    case 3124:
        thalf_x0 = 20374449;
        half_x03 = 17806315;
        break;
    case 3125:
        thalf_x0 = 20371188;
        half_x03 = 17797766;
        break;
    case 3126:
        thalf_x0 = 20367933;
        half_x03 = 17789236;
        break;
    case 3127:
        thalf_x0 = 20364672;
        half_x03 = 17780693;
        break;
    case 3128:
        thalf_x0 = 20361420;
        half_x03 = 17772176;
        break;
    case 3129:
        thalf_x0 = 20358165;
        half_x03 = 17763654;
        break;
    case 3130:
        thalf_x0 = 20354913;
        half_x03 = 17755143;
        break;
    case 3131:
        thalf_x0 = 20351663;
        half_x03 = 17746638;
        break;
    case 3132:
        thalf_x0 = 20348417;
        half_x03 = 17738148;
        break;
    case 3133:
        thalf_x0 = 20345168;
        half_x03 = 17729653;
        break;
    case 3134:
        thalf_x0 = 20341923;
        half_x03 = 17721172;
        break;
    case 3135:
        thalf_x0 = 20338680;
        half_x03 = 17712698;
        break;
    case 3136:
        thalf_x0 = 20335436;
        half_x03 = 17704222;
        break;
    case 3137:
        thalf_x0 = 20332196;
        half_x03 = 17695762;
        break;
    case 3138:
        thalf_x0 = 20328956;
        half_x03 = 17687303;
        break;
    case 3139:
        thalf_x0 = 20325719;
        half_x03 = 17678855;
        break;
    case 3140:
        thalf_x0 = 20322482;
        half_x03 = 17670410;
        break;
    case 3141:
        thalf_x0 = 20319245;
        half_x03 = 17661968;
        break;
    case 3142:
        thalf_x0 = 20316014;
        half_x03 = 17653544;
        break;
    case 3143:
        thalf_x0 = 20312781;
        half_x03 = 17645119;
        break;
    case 3144:
        thalf_x0 = 20309552;
        half_x03 = 17636704;
        break;
    case 3145:
        thalf_x0 = 20306324;
        half_x03 = 17628296;
        break;
    case 3146:
        thalf_x0 = 20303096;
        half_x03 = 17619890;
        break;
    case 3147:
        thalf_x0 = 20299871;
        half_x03 = 17611495;
        break;
    case 3148:
        thalf_x0 = 20296646;
        half_x03 = 17603103;
        break;
    case 3149:
        thalf_x0 = 20293425;
        half_x03 = 17594725;
        break;
    case 3150:
        thalf_x0 = 20290203;
        half_x03 = 17586346;
        break;
    case 3151:
        thalf_x0 = 20286983;
        half_x03 = 17577973;
        break;
    case 3152:
        thalf_x0 = 20283767;
        half_x03 = 17569614;
        break;
    case 3153:
        thalf_x0 = 20280551;
        half_x03 = 17561259;
        break;
    case 3154:
        thalf_x0 = 20277335;
        half_x03 = 17552906;
        break;
    case 3155:
        thalf_x0 = 20274122;
        half_x03 = 17544563;
        break;
    case 3156:
        thalf_x0 = 20270912;
        half_x03 = 17536231;
        break;
    case 3157:
        thalf_x0 = 20267700;
        half_x03 = 17527898;
        break;
    case 3158:
        thalf_x0 = 20264492;
        half_x03 = 17519575;
        break;
    case 3159:
        thalf_x0 = 20261282;
        half_x03 = 17511250;
        break;
    case 3160:
        thalf_x0 = 20258078;
        half_x03 = 17502944;
        break;
    case 3161:
        thalf_x0 = 20254874;
        half_x03 = 17494641;
        break;
    case 3162:
        thalf_x0 = 20251671;
        half_x03 = 17486344;
        break;
    case 3163:
        thalf_x0 = 20248469;
        half_x03 = 17478050;
        break;
    case 3164:
        thalf_x0 = 20245271;
        half_x03 = 17469770;
        break;
    case 3165:
        thalf_x0 = 20242073;
        half_x03 = 17461492;
        break;
    case 3166:
        thalf_x0 = 20238876;
        half_x03 = 17453221;
        break;
    case 3167:
        thalf_x0 = 20235681;
        half_x03 = 17444957;
        break;
    case 3168:
        thalf_x0 = 20232488;
        half_x03 = 17436699;
        break;
    case 3169:
        thalf_x0 = 20229296;
        half_x03 = 17428447;
        break;
    case 3170:
        thalf_x0 = 20226105;
        half_x03 = 17420202;
        break;
    case 3171:
        thalf_x0 = 20222916;
        half_x03 = 17411964;
        break;
    case 3172:
        thalf_x0 = 20219729;
        half_x03 = 17403732;
        break;
    case 3173:
        thalf_x0 = 20216543;
        half_x03 = 17395506;
        break;
    case 3174:
        thalf_x0 = 20213357;
        half_x03 = 17387283;
        break;
    case 3175:
        thalf_x0 = 20210175;
        half_x03 = 17379075;
        break;
    case 3176:
        thalf_x0 = 20206994;
        half_x03 = 17370868;
        break;
    case 3177:
        thalf_x0 = 20203814;
        half_x03 = 17362669;
        break;
    case 3178:
        thalf_x0 = 20200635;
        half_x03 = 17354475;
        break;
    case 3179:
        thalf_x0 = 20197457;
        half_x03 = 17346285;
        break;
    case 3180:
        thalf_x0 = 20194284;
        half_x03 = 17338112;
        break;
    case 3181:
        thalf_x0 = 20191107;
        half_x03 = 17329930;
        break;
    case 3182:
        thalf_x0 = 20187936;
        half_x03 = 17321767;
        break;
    case 3183:
        thalf_x0 = 20184767;
        half_x03 = 17313609;
        break;
    case 3184:
        thalf_x0 = 20181597;
        half_x03 = 17305455;
        break;
    case 3185:
        thalf_x0 = 20178429;
        half_x03 = 17297306;
        break;
    case 3186:
        thalf_x0 = 20175263;
        half_x03 = 17289165;
        break;
    case 3187:
        thalf_x0 = 20172096;
        half_x03 = 17281025;
        break;
    case 3188:
        thalf_x0 = 20168936;
        half_x03 = 17272904;
        break;
    case 3189:
        thalf_x0 = 20165771;
        half_x03 = 17264774;
        break;
    case 3190:
        thalf_x0 = 20162612;
        half_x03 = 17256661;
        break;
    case 3191:
        thalf_x0 = 20159451;
        half_x03 = 17248547;
        break;
    case 3192:
        thalf_x0 = 20156294;
        half_x03 = 17240444;
        break;
    case 3193:
        thalf_x0 = 20153138;
        half_x03 = 17232347;
        break;
    case 3194:
        thalf_x0 = 20149985;
        half_x03 = 17224260;
        break;
    case 3195:
        thalf_x0 = 20146832;
        half_x03 = 17216176;
        break;
    case 3196:
        thalf_x0 = 20143679;
        half_x03 = 17208094;
        break;
    case 3197:
        thalf_x0 = 20140529;
        half_x03 = 17200022;
        break;
    case 3198:
        thalf_x0 = 20137380;
        half_x03 = 17191957;
        break;
    case 3199:
        thalf_x0 = 20134232;
        half_x03 = 17183895;
        break;
    case 3200:
        thalf_x0 = 20131088;
        half_x03 = 17175846;
        break;
    case 3201:
        thalf_x0 = 20127944;
        half_x03 = 17167800;
        break;
    case 3202:
        thalf_x0 = 20124800;
        half_x03 = 17159756;
        break;
    case 3203:
        thalf_x0 = 20121659;
        half_x03 = 17151723;
        break;
    case 3204:
        thalf_x0 = 20118518;
        half_x03 = 17143692;
        break;
    case 3205:
        thalf_x0 = 20115381;
        half_x03 = 17135675;
        break;
    case 3206:
        thalf_x0 = 20112242;
        half_x03 = 17127653;
        break;
    case 3207:
        thalf_x0 = 20109108;
        half_x03 = 17119649;
        break;
    case 3208:
        thalf_x0 = 20105975;
        half_x03 = 17111647;
        break;
    case 3209:
        thalf_x0 = 20102843;
        half_x03 = 17103651;
        break;
    case 3210:
        thalf_x0 = 20099711;
        half_x03 = 17095658;
        break;
    case 3211:
        thalf_x0 = 20096580;
        half_x03 = 17087672;
        break;
    case 3212:
        thalf_x0 = 20093453;
        half_x03 = 17079695;
        break;
    case 3213:
        thalf_x0 = 20090327;
        half_x03 = 17071725;
        break;
    case 3214:
        thalf_x0 = 20087201;
        half_x03 = 17063757;
        break;
    case 3215:
        thalf_x0 = 20084076;
        half_x03 = 17055796;
        break;
    case 3216:
        thalf_x0 = 20080955;
        half_x03 = 17047845;
        break;
    case 3217:
        thalf_x0 = 20077835;
        half_x03 = 17039900;
        break;
    case 3218:
        thalf_x0 = 20074715;
        half_x03 = 17031957;
        break;
    case 3219:
        thalf_x0 = 20071598;
        half_x03 = 17024025;
        break;
    case 3220:
        thalf_x0 = 20068481;
        half_x03 = 17016095;
        break;
    case 3221:
        thalf_x0 = 20065365;
        half_x03 = 17008171;
        break;
    case 3222:
        thalf_x0 = 20062251;
        half_x03 = 17000254;
        break;
    case 3223:
        thalf_x0 = 20059140;
        half_x03 = 16992346;
        break;
    case 3224:
        thalf_x0 = 20056029;
        half_x03 = 16984442;
        break;
    case 3225:
        thalf_x0 = 20052917;
        half_x03 = 16976535;
        break;
    case 3226:
        thalf_x0 = 20049813;
        half_x03 = 16968654;
        break;
    case 3227:
        thalf_x0 = 20046707;
        half_x03 = 16960768;
        break;
    case 3228:
        thalf_x0 = 20043600;
        half_x03 = 16952885;
        break;
    case 3229:
        thalf_x0 = 20040495;
        half_x03 = 16945007;
        break;
    case 3230:
        thalf_x0 = 20037395;
        half_x03 = 16937144;
        break;
    case 3231:
        thalf_x0 = 20034296;
        half_x03 = 16929286;
        break;
    case 3232:
        thalf_x0 = 20031195;
        half_x03 = 16921428;
        break;
    case 3233:
        thalf_x0 = 20028098;
        half_x03 = 16913579;
        break;
    case 3234:
        thalf_x0 = 20025002;
        half_x03 = 16905737;
        break;
    case 3235:
        thalf_x0 = 20021907;
        half_x03 = 16897900;
        break;
    case 3236:
        thalf_x0 = 20018813;
        half_x03 = 16890067;
        break;
    case 3237:
        thalf_x0 = 20015721;
        half_x03 = 16882243;
        break;
    case 3238:
        thalf_x0 = 20012630;
        half_x03 = 16874421;
        break;
    case 3239:
        thalf_x0 = 20009541;
        half_x03 = 16866610;
        break;
    case 3240:
        thalf_x0 = 20006456;
        half_x03 = 16858809;
        break;
    case 3241:
        thalf_x0 = 20003367;
        half_x03 = 16851002;
        break;
    case 3242:
        thalf_x0 = 20000282;
        half_x03 = 16843206;
        break;
    case 3243:
        thalf_x0 = 19997199;
        half_x03 = 16835419;
        break;
    case 3244:
        thalf_x0 = 19994117;
        half_x03 = 16827635;
        break;
    case 3245:
        thalf_x0 = 19991039;
        half_x03 = 16819864;
        break;
    case 3246:
        thalf_x0 = 19987958;
        half_x03 = 16812089;
        break;
    case 3247:
        thalf_x0 = 19984881;
        half_x03 = 16804327;
        break;
    case 3248:
        thalf_x0 = 19981805;
        half_x03 = 16796568;
        break;
    case 3249:
        thalf_x0 = 19978730;
        half_x03 = 16788814;
        break;
    case 3250:
        thalf_x0 = 19975656;
        half_x03 = 16781067;
        break;
    case 3251:
        thalf_x0 = 19972584;
        half_x03 = 16773326;
        break;
    case 3252:
        thalf_x0 = 19969512;
        half_x03 = 16765588;
        break;
    case 3253:
        thalf_x0 = 19966443;
        half_x03 = 16757859;
        break;
    case 3254:
        thalf_x0 = 19963376;
        half_x03 = 16750137;
        break;
    case 3255:
        thalf_x0 = 19960308;
        half_x03 = 16742416;
        break;
    case 3256:
        thalf_x0 = 19957245;
        half_x03 = 16734710;
        break;
    case 3257:
        thalf_x0 = 19954184;
        half_x03 = 16727010;
        break;
    case 3258:
        thalf_x0 = 19951121;
        half_x03 = 16719308;
        break;
    case 3259:
        thalf_x0 = 19948059;
        half_x03 = 16711613;
        break;
    case 3260:
        thalf_x0 = 19945001;
        half_x03 = 16703927;
        break;
    case 3261:
        thalf_x0 = 19941941;
        half_x03 = 16696240;
        break;
    case 3262:
        thalf_x0 = 19938887;
        half_x03 = 16688570;
        break;
    case 3263:
        thalf_x0 = 19935831;
        half_x03 = 16680899;
        break;
    case 3264:
        thalf_x0 = 19932777;
        half_x03 = 16673234;
        break;
    case 3265:
        thalf_x0 = 19929725;
        half_x03 = 16665575;
        break;
    case 3266:
        thalf_x0 = 19926674;
        half_x03 = 16657923;
        break;
    case 3267:
        thalf_x0 = 19923624;
        half_x03 = 16650276;
        break;
    case 3268:
        thalf_x0 = 19920576;
        half_x03 = 16642635;
        break;
    case 3269:
        thalf_x0 = 19917530;
        half_x03 = 16635001;
        break;
    case 3270:
        thalf_x0 = 19914483;
        half_x03 = 16627369;
        break;
    case 3271:
        thalf_x0 = 19911441;
        half_x03 = 16619750;
        break;
    case 3272:
        thalf_x0 = 19908398;
        half_x03 = 16612131;
        break;
    case 3273:
        thalf_x0 = 19905357;
        half_x03 = 16604520;
        break;
    case 3274:
        thalf_x0 = 19902315;
        half_x03 = 16596909;
        break;
    case 3275:
        thalf_x0 = 19899278;
        half_x03 = 16589311;
        break;
    case 3276:
        thalf_x0 = 19896242;
        half_x03 = 16581719;
        break;
    case 3277:
        thalf_x0 = 19893206;
        half_x03 = 16574130;
        break;
    case 3278:
        thalf_x0 = 19890173;
        half_x03 = 16566550;
        break;
    case 3279:
        thalf_x0 = 19887140;
        half_x03 = 16558972;
        break;
    case 3280:
        thalf_x0 = 19884108;
        half_x03 = 16551401;
        break;
    case 3281:
        thalf_x0 = 19881080;
        half_x03 = 16543840;
        break;
    case 3282:
        thalf_x0 = 19878048;
        half_x03 = 16536273;
        break;
    case 3283:
        thalf_x0 = 19875023;
        half_x03 = 16528723;
        break;
    case 3284:
        thalf_x0 = 19871996;
        half_x03 = 16521173;
        break;
    case 3285:
        thalf_x0 = 19868972;
        half_x03 = 16513631;
        break;
    case 3286:
        thalf_x0 = 19865949;
        half_x03 = 16506096;
        break;
    case 3287:
        thalf_x0 = 19862928;
        half_x03 = 16498567;
        break;
    case 3288:
        thalf_x0 = 19859907;
        half_x03 = 16491040;
        break;
    case 3289:
        thalf_x0 = 19856888;
        half_x03 = 16483520;
        break;
    case 3290:
        thalf_x0 = 19853870;
        half_x03 = 16476005;
        break;
    case 3291:
        thalf_x0 = 19850856;
        half_x03 = 16468504;
        break;
    case 3292:
        thalf_x0 = 19847840;
        half_x03 = 16460997;
        break;
    case 3293:
        thalf_x0 = 19844825;
        half_x03 = 16453497;
        break;
    case 3294:
        thalf_x0 = 19841813;
        half_x03 = 16446006;
        break;
    case 3295:
        thalf_x0 = 19838805;
        half_x03 = 16438529;
        break;
    case 3296:
        thalf_x0 = 19835795;
        half_x03 = 16431047;
        break;
    case 3297:
        thalf_x0 = 19832786;
        half_x03 = 16423570;
        break;
    case 3298:
        thalf_x0 = 19829781;
        half_x03 = 16416107;
        break;
    case 3299:
        thalf_x0 = 19826774;
        half_x03 = 16408639;
        break;
    case 3300:
        thalf_x0 = 19823771;
        half_x03 = 16401184;
        break;
    case 3301:
        thalf_x0 = 19820769;
        half_x03 = 16393736;
        break;
    case 3302:
        thalf_x0 = 19817769;
        half_x03 = 16386293;
        break;
    case 3303:
        thalf_x0 = 19814769;
        half_x03 = 16378852;
        break;
    case 3304:
        thalf_x0 = 19811769;
        half_x03 = 16371414;
        break;
    case 3305:
        thalf_x0 = 19808772;
        half_x03 = 16363985;
        break;
    case 3306:
        thalf_x0 = 19805777;
        half_x03 = 16356563;
        break;
    case 3307:
        thalf_x0 = 19802781;
        half_x03 = 16349143;
        break;
    case 3308:
        thalf_x0 = 19799789;
        half_x03 = 16341732;
        break;
    case 3309:
        thalf_x0 = 19796798;
        half_x03 = 16334327;
        break;
    case 3310:
        thalf_x0 = 19793808;
        half_x03 = 16326928;
        break;
    case 3311:
        thalf_x0 = 19790817;
        half_x03 = 16319528;
        break;
    case 3312:
        thalf_x0 = 19787832;
        half_x03 = 16312145;
        break;
    case 3313:
        thalf_x0 = 19784846;
        half_x03 = 16304760;
        break;
    case 3314:
        thalf_x0 = 19781859;
        half_x03 = 16297378;
        break;
    case 3315:
        thalf_x0 = 19778876;
        half_x03 = 16290005;
        break;
    case 3316:
        thalf_x0 = 19775894;
        half_x03 = 16282638;
        break;
    case 3317:
        thalf_x0 = 19772915;
        half_x03 = 16275281;
        break;
    case 3318:
        thalf_x0 = 19769933;
        half_x03 = 16267918;
        break;
    case 3319:
        thalf_x0 = 19766955;
        half_x03 = 16260569;
        break;
    case 3320:
        thalf_x0 = 19763979;
        half_x03 = 16253226;
        break;
    case 3321:
        thalf_x0 = 19761003;
        half_x03 = 16245885;
        break;
    case 3322:
        thalf_x0 = 19758032;
        half_x03 = 16238557;
        break;
    case 3323:
        thalf_x0 = 19755059;
        half_x03 = 16231228;
        break;
    case 3324:
        thalf_x0 = 19752084;
        half_x03 = 16223898;
        break;
    case 3325:
        thalf_x0 = 19749116;
        half_x03 = 16216584;
        break;
    case 3326:
        thalf_x0 = 19746147;
        half_x03 = 16209272;
        break;
    case 3327:
        thalf_x0 = 19743180;
        half_x03 = 16201967;
        break;
    case 3328:
        thalf_x0 = 19740215;
        half_x03 = 16194667;
        break;
    case 3329:
        thalf_x0 = 19737251;
        half_x03 = 16187373;
        break;
    case 3330:
        thalf_x0 = 19734287;
        half_x03 = 16180082;
        break;
    case 3331:
        thalf_x0 = 19731323;
        half_x03 = 16172792;
        break;
    case 3332:
        thalf_x0 = 19728365;
        half_x03 = 16165520;
        break;
    case 3333:
        thalf_x0 = 19725405;
        half_x03 = 16158246;
        break;
    case 3334:
        thalf_x0 = 19722447;
        half_x03 = 16150978;
        break;
    case 3335:
        thalf_x0 = 19719489;
        half_x03 = 16143712;
        break;
    case 3336:
        thalf_x0 = 19716533;
        half_x03 = 16136452;
        break;
    case 3337:
        thalf_x0 = 19713579;
        half_x03 = 16129201;
        break;
    case 3338:
        thalf_x0 = 19710627;
        half_x03 = 16121956;
        break;
    case 3339:
        thalf_x0 = 19707675;
        half_x03 = 16114714;
        break;
    case 3340:
        thalf_x0 = 19704725;
        half_x03 = 16107477;
        break;
    case 3341:
        thalf_x0 = 19701777;
        half_x03 = 16100250;
        break;
    case 3342:
        thalf_x0 = 19698830;
        half_x03 = 16093025;
        break;
    case 3343:
        thalf_x0 = 19695885;
        half_x03 = 16085810;
        break;
    case 3344:
        thalf_x0 = 19692938;
        half_x03 = 16078589;
        break;
    case 3345:
        thalf_x0 = 19689996;
        half_x03 = 16071385;
        break;
    case 3346:
        thalf_x0 = 19687053;
        half_x03 = 16064180;
        break;
    case 3347:
        thalf_x0 = 19684113;
        half_x03 = 16056984;
        break;
    case 3348:
        thalf_x0 = 19681175;
        half_x03 = 16049794;
        break;
    case 3349:
        thalf_x0 = 19678236;
        half_x03 = 16042606;
        break;
    case 3350:
        thalf_x0 = 19675298;
        half_x03 = 16035420;
        break;
    case 3351:
        thalf_x0 = 19672364;
        half_x03 = 16028248;
        break;
    case 3352:
        thalf_x0 = 19669428;
        half_x03 = 16021074;
        break;
    case 3353:
        thalf_x0 = 19666496;
        half_x03 = 16013909;
        break;
    case 3354:
        thalf_x0 = 19663565;
        half_x03 = 16006750;
        break;
    case 3355:
        thalf_x0 = 19660634;
        half_x03 = 15999594;
        break;
    case 3356:
        thalf_x0 = 19657706;
        half_x03 = 15992446;
        break;
    case 3357:
        thalf_x0 = 19654778;
        half_x03 = 15985301;
        break;
    case 3358:
        thalf_x0 = 19651850;
        half_x03 = 15978158;
        break;
    case 3359:
        thalf_x0 = 19648925;
        half_x03 = 15971025;
        break;
    case 3360:
        thalf_x0 = 19646001;
        half_x03 = 15963897;
        break;
    case 3361:
        thalf_x0 = 19643079;
        half_x03 = 15956775;
        break;
    case 3362:
        thalf_x0 = 19640160;
        half_x03 = 15949662;
        break;
    case 3363:
        thalf_x0 = 19637237;
        half_x03 = 15942541;
        break;
    case 3364:
        thalf_x0 = 19634321;
        half_x03 = 15935440;
        break;
    case 3365:
        thalf_x0 = 19631402;
        half_x03 = 15928334;
        break;
    case 3366:
        thalf_x0 = 19628487;
        half_x03 = 15921240;
        break;
    case 3367:
        thalf_x0 = 19625571;
        half_x03 = 15914146;
        break;
    case 3368:
        thalf_x0 = 19622660;
        half_x03 = 15907064;
        break;
    case 3369:
        thalf_x0 = 19619747;
        half_x03 = 15899981;
        break;
    case 3370:
        thalf_x0 = 19616835;
        half_x03 = 15892903;
        break;
    case 3371:
        thalf_x0 = 19613927;
        half_x03 = 15885835;
        break;
    case 3372:
        thalf_x0 = 19611020;
        half_x03 = 15878773;
        break;
    case 3373:
        thalf_x0 = 19608113;
        half_x03 = 15871713;
        break;
    case 3374:
        thalf_x0 = 19605206;
        half_x03 = 15864655;
        break;
    case 3375:
        thalf_x0 = 19602302;
        half_x03 = 15857606;
        break;
    case 3376:
        thalf_x0 = 19599399;
        half_x03 = 15850563;
        break;
    case 3377:
        thalf_x0 = 19596497;
        half_x03 = 15843522;
        break;
    case 3378:
        thalf_x0 = 19593597;
        half_x03 = 15836490;
        break;
    case 3379:
        thalf_x0 = 19590698;
        half_x03 = 15829461;
        break;
    case 3380:
        thalf_x0 = 19587800;
        half_x03 = 15822437;
        break;
    case 3381:
        thalf_x0 = 19584903;
        half_x03 = 15815419;
        break;
    case 3382:
        thalf_x0 = 19582010;
        half_x03 = 15808410;
        break;
    case 3383:
        thalf_x0 = 19579115;
        half_x03 = 15801400;
        break;
    case 3384:
        thalf_x0 = 19576221;
        half_x03 = 15794395;
        break;
    case 3385:
        thalf_x0 = 19573331;
        half_x03 = 15787400;
        break;
    case 3386:
        thalf_x0 = 19570440;
        half_x03 = 15780407;
        break;
    case 3387:
        thalf_x0 = 19567551;
        half_x03 = 15773419;
        break;
    case 3388:
        thalf_x0 = 19564664;
        half_x03 = 15766438;
        break;
    case 3389:
        thalf_x0 = 19561778;
        half_x03 = 15759461;
        break;
    case 3390:
        thalf_x0 = 19558893;
        half_x03 = 15752491;
        break;
    case 3391:
        thalf_x0 = 19556009;
        half_x03 = 15745523;
        break;
    case 3392:
        thalf_x0 = 19553126;
        half_x03 = 15738560;
        break;
    case 3393:
        thalf_x0 = 19550246;
        half_x03 = 15731606;
        break;
    case 3394:
        thalf_x0 = 19547366;
        half_x03 = 15724655;
        break;
    case 3395:
        thalf_x0 = 19544486;
        half_x03 = 15717706;
        break;
    case 3396:
        thalf_x0 = 19541609;
        half_x03 = 15710766;
        break;
    case 3397:
        thalf_x0 = 19538735;
        half_x03 = 15703835;
        break;
    case 3398:
        thalf_x0 = 19535856;
        half_x03 = 15696895;
        break;
    case 3399:
        thalf_x0 = 19532985;
        half_x03 = 15689976;
        break;
    case 3400:
        thalf_x0 = 19530113;
        half_x03 = 15683055;
        break;
    case 3401:
        thalf_x0 = 19527240;
        half_x03 = 15676136;
        break;
    case 3402:
        thalf_x0 = 19524371;
        half_x03 = 15669226;
        break;
    case 3403:
        thalf_x0 = 19521503;
        half_x03 = 15662322;
        break;
    case 3404:
        thalf_x0 = 19518635;
        half_x03 = 15655420;
        break;
    case 3405:
        thalf_x0 = 19515770;
        half_x03 = 15648527;
        break;
    case 3406:
        thalf_x0 = 19512905;
        half_x03 = 15641636;
        break;
    case 3407:
        thalf_x0 = 19510043;
        half_x03 = 15634755;
        break;
    case 3408:
        thalf_x0 = 19507181;
        half_x03 = 15627875;
        break;
    case 3409:
        thalf_x0 = 19504320;
        half_x03 = 15621001;
        break;
    case 3410:
        thalf_x0 = 19501460;
        half_x03 = 15614129;
        break;
    case 3411:
        thalf_x0 = 19498601;
        half_x03 = 15607263;
        break;
    case 3412:
        thalf_x0 = 19495743;
        half_x03 = 15600402;
        break;
    case 3413:
        thalf_x0 = 19492887;
        half_x03 = 15593547;
        break;
    case 3414:
        thalf_x0 = 19490031;
        half_x03 = 15586694;
        break;
    case 3415:
        thalf_x0 = 19487180;
        half_x03 = 15579854;
        break;
    case 3416:
        thalf_x0 = 19484328;
        half_x03 = 15573016;
        break;
    case 3417:
        thalf_x0 = 19481477;
        half_x03 = 15566179;
        break;
    case 3418:
        thalf_x0 = 19478628;
        half_x03 = 15559352;
        break;
    case 3419:
        thalf_x0 = 19475780;
        half_x03 = 15552527;
        break;
    case 3420:
        thalf_x0 = 19472930;
        half_x03 = 15545701;
        break;
    case 3421:
        thalf_x0 = 19470086;
        half_x03 = 15538890;
        break;
    case 3422:
        thalf_x0 = 19467240;
        half_x03 = 15532078;
        break;
    case 3423:
        thalf_x0 = 19464396;
        half_x03 = 15525272;
        break;
    case 3424:
        thalf_x0 = 19461555;
        half_x03 = 15518475;
        break;
    case 3425:
        thalf_x0 = 19458716;
        half_x03 = 15511683;
        break;
    case 3426:
        thalf_x0 = 19455875;
        half_x03 = 15504890;
        break;
    case 3427:
        thalf_x0 = 19453037;
        half_x03 = 15498106;
        break;
    case 3428:
        thalf_x0 = 19450199;
        half_x03 = 15491324;
        break;
    case 3429:
        thalf_x0 = 19447364;
        half_x03 = 15484551;
        break;
    case 3430:
        thalf_x0 = 19444529;
        half_x03 = 15477780;
        break;
    case 3431:
        thalf_x0 = 19441697;
        half_x03 = 15471018;
        break;
    case 3432:
        thalf_x0 = 19438863;
        half_x03 = 15464255;
        break;
    case 3433:
        thalf_x0 = 19436033;
        half_x03 = 15457501;
        break;
    case 3434:
        thalf_x0 = 19433204;
        half_x03 = 15450752;
        break;
    case 3435:
        thalf_x0 = 19430375;
        half_x03 = 15444005;
        break;
    case 3436:
        thalf_x0 = 19427546;
        half_x03 = 15437260;
        break;
    case 3437:
        thalf_x0 = 19424720;
        half_x03 = 15430525;
        break;
    case 3438:
        thalf_x0 = 19421895;
        half_x03 = 15423794;
        break;
    case 3439:
        thalf_x0 = 19419072;
        half_x03 = 15417070;
        break;
    case 3440:
        thalf_x0 = 19416251;
        half_x03 = 15410351;
        break;
    case 3441:
        thalf_x0 = 19413429;
        half_x03 = 15403634;
        break;
    case 3442:
        thalf_x0 = 19410611;
        half_x03 = 15396926;
        break;
    case 3443:
        thalf_x0 = 19407791;
        half_x03 = 15390216;
        break;
    case 3444:
        thalf_x0 = 19404972;
        half_x03 = 15383512;
        break;
    case 3445:
        thalf_x0 = 19402155;
        half_x03 = 15376813;
        break;
    case 3446:
        thalf_x0 = 19399343;
        half_x03 = 15370127;
        break;
    case 3447:
        thalf_x0 = 19396527;
        half_x03 = 15363436;
        break;
    case 3448:
        thalf_x0 = 19393715;
        half_x03 = 15356754;
        break;
    case 3449:
        thalf_x0 = 19390905;
        half_x03 = 15350081;
        break;
    case 3450:
        thalf_x0 = 19388093;
        half_x03 = 15343402;
        break;
    case 3451:
        thalf_x0 = 19385285;
        half_x03 = 15336737;
        break;
    case 3452:
        thalf_x0 = 19382477;
        half_x03 = 15330073;
        break;
    case 3453:
        thalf_x0 = 19379672;
        half_x03 = 15323418;
        break;
    case 3454:
        thalf_x0 = 19376867;
        half_x03 = 15316766;
        break;
    case 3455:
        thalf_x0 = 19374062;
        half_x03 = 15310115;
        break;
    case 3456:
        thalf_x0 = 19371260;
        half_x03 = 15303473;
        break;
    case 3457:
        thalf_x0 = 19368458;
        half_x03 = 15296833;
        break;
    case 3458:
        thalf_x0 = 19365657;
        half_x03 = 15290199;
        break;
    case 3459:
        thalf_x0 = 19362860;
        half_x03 = 15283573;
        break;
    case 3460:
        thalf_x0 = 19360061;
        half_x03 = 15276946;
        break;
    case 3461:
        thalf_x0 = 19357263;
        half_x03 = 15270325;
        break;
    case 3462:
        thalf_x0 = 19354467;
        half_x03 = 15263709;
        break;
    case 3463:
        thalf_x0 = 19351673;
        half_x03 = 15257098;
        break;
    case 3464:
        thalf_x0 = 19348881;
        half_x03 = 15250497;
        break;
    case 3465:
        thalf_x0 = 19346088;
        half_x03 = 15243893;
        break;
    case 3466:
        thalf_x0 = 19343297;
        half_x03 = 15237296;
        break;
    case 3467:
        thalf_x0 = 19340508;
        half_x03 = 15230707;
        break;
    case 3468:
        thalf_x0 = 19337721;
        half_x03 = 15224123;
        break;
    case 3469:
        thalf_x0 = 19334933;
        half_x03 = 15217538;
        break;
    case 3470:
        thalf_x0 = 19332147;
        half_x03 = 15210962;
        break;
    case 3471:
        thalf_x0 = 19329363;
        half_x03 = 15204392;
        break;
    case 3472:
        thalf_x0 = 19326579;
        half_x03 = 15197823;
        break;
    case 3473:
        thalf_x0 = 19323800;
        half_x03 = 15191267;
        break;
    case 3474:
        thalf_x0 = 19321017;
        half_x03 = 15184706;
        break;
    case 3475:
        thalf_x0 = 19318236;
        half_x03 = 15178150;
        break;
    case 3476:
        thalf_x0 = 19315460;
        half_x03 = 15171606;
        break;
    case 3477:
        thalf_x0 = 19312680;
        half_x03 = 15165057;
        break;
    case 3478:
        thalf_x0 = 19309905;
        half_x03 = 15158521;
        break;
    case 3479:
        thalf_x0 = 19307132;
        half_x03 = 15151990;
        break;
    case 3480:
        thalf_x0 = 19304357;
        half_x03 = 15145458;
        break;
    case 3481:
        thalf_x0 = 19301585;
        half_x03 = 15138935;
        break;
    case 3482:
        thalf_x0 = 19298813;
        half_x03 = 15132413;
        break;
    case 3483:
        thalf_x0 = 19296041;
        half_x03 = 15125893;
        break;
    case 3484:
        thalf_x0 = 19293273;
        half_x03 = 15119386;
        break;
    case 3485:
        thalf_x0 = 19290504;
        half_x03 = 15112877;
        break;
    case 3486:
        thalf_x0 = 19287737;
        half_x03 = 15106373;
        break;
    case 3487:
        thalf_x0 = 19284972;
        half_x03 = 15099879;
        break;
    case 3488:
        thalf_x0 = 19282208;
        half_x03 = 15093386;
        break;
    case 3489:
        thalf_x0 = 19279445;
        half_x03 = 15086899;
        break;
    case 3490:
        thalf_x0 = 19276683;
        half_x03 = 15080417;
        break;
    case 3491:
        thalf_x0 = 19273922;
        half_x03 = 15073937;
        break;
    case 3492:
        thalf_x0 = 19271162;
        half_x03 = 15067462;
        break;
    case 3493:
        thalf_x0 = 19268403;
        half_x03 = 15060992;
        break;
    case 3494:
        thalf_x0 = 19265648;
        half_x03 = 15054532;
        break;
    case 3495:
        thalf_x0 = 19262892;
        half_x03 = 15048073;
        break;
    case 3496:
        thalf_x0 = 19260137;
        half_x03 = 15041616;
        break;
    case 3497:
        thalf_x0 = 19257384;
        half_x03 = 15035168;
        break;
    case 3498:
        thalf_x0 = 19254632;
        half_x03 = 15028722;
        break;
    case 3499:
        thalf_x0 = 19251878;
        half_x03 = 15022275;
        break;
    case 3500:
        thalf_x0 = 19249130;
        half_x03 = 15015843;
        break;
    case 3501:
        thalf_x0 = 19246380;
        half_x03 = 15009409;
        break;
    case 3502:
        thalf_x0 = 19243632;
        half_x03 = 15002981;
        break;
    case 3503:
        thalf_x0 = 19240886;
        half_x03 = 14996558;
        break;
    case 3504:
        thalf_x0 = 19238141;
        half_x03 = 14990140;
        break;
    case 3505:
        thalf_x0 = 19235397;
        half_x03 = 14983728;
        break;
    case 3506:
        thalf_x0 = 19232654;
        half_x03 = 14977318;
        break;
    case 3507:
        thalf_x0 = 19229913;
        half_x03 = 14970916;
        break;
    case 3508:
        thalf_x0 = 19227171;
        half_x03 = 14964513;
        break;
    case 3509:
        thalf_x0 = 19224431;
        half_x03 = 14958115;
        break;
    case 3510:
        thalf_x0 = 19221695;
        half_x03 = 14951730;
        break;
    case 3511:
        thalf_x0 = 19218956;
        half_x03 = 14945339;
        break;
    case 3512:
        thalf_x0 = 19216220;
        half_x03 = 14938957;
        break;
    case 3513:
        thalf_x0 = 19213487;
        half_x03 = 14932584;
        break;
    case 3514:
        thalf_x0 = 19210752;
        half_x03 = 14926209;
        break;
    case 3515:
        thalf_x0 = 19208019;
        half_x03 = 14919840;
        break;
    case 3516:
        thalf_x0 = 19205288;
        half_x03 = 14913475;
        break;
    case 3517:
        thalf_x0 = 19202558;
        half_x03 = 14907117;
        break;
    case 3518:
        thalf_x0 = 19199828;
        half_x03 = 14900760;
        break;
    case 3519:
        thalf_x0 = 19197101;
        half_x03 = 14894411;
        break;
    case 3520:
        thalf_x0 = 19194374;
        half_x03 = 14888065;
        break;
    case 3521:
        thalf_x0 = 19191648;
        half_x03 = 14881724;
        break;
    case 3522:
        thalf_x0 = 19188924;
        half_x03 = 14875388;
        break;
    case 3523:
        thalf_x0 = 19186200;
        half_x03 = 14869054;
        break;
    case 3524:
        thalf_x0 = 19183479;
        half_x03 = 14862728;
        break;
    case 3525:
        thalf_x0 = 19180760;
        half_x03 = 14856408;
        break;
    case 3526:
        thalf_x0 = 19178039;
        half_x03 = 14850087;
        break;
    case 3527:
        thalf_x0 = 19175319;
        half_x03 = 14843770;
        break;
    case 3528:
        thalf_x0 = 19172603;
        half_x03 = 14837462;
        break;
    case 3529:
        thalf_x0 = 19169888;
        half_x03 = 14831160;
        break;
    case 3530:
        thalf_x0 = 19167171;
        half_x03 = 14824856;
        break;
    case 3531:
        thalf_x0 = 19164458;
        half_x03 = 14818560;
        break;
    case 3532:
        thalf_x0 = 19161744;
        half_x03 = 14812267;
        break;
    case 3533:
        thalf_x0 = 19159032;
        half_x03 = 14805978;
        break;
    case 3534:
        thalf_x0 = 19156323;
        half_x03 = 14799699;
        break;
    case 3535:
        thalf_x0 = 19153613;
        half_x03 = 14793418;
        break;
    case 3536:
        thalf_x0 = 19150905;
        half_x03 = 14787145;
        break;
    case 3537:
        thalf_x0 = 19148198;
        half_x03 = 14780874;
        break;
    case 3538:
        thalf_x0 = 19145492;
        half_x03 = 14774609;
        break;
    case 3539:
        thalf_x0 = 19142787;
        half_x03 = 14768348;
        break;
    case 3540:
        thalf_x0 = 19140086;
        half_x03 = 14762097;
        break;
    case 3541:
        thalf_x0 = 19137381;
        half_x03 = 14755840;
        break;
    case 3542:
        thalf_x0 = 19134680;
        half_x03 = 14749592;
        break;
    case 3543:
        thalf_x0 = 19131980;
        half_x03 = 14743349;
        break;
    case 3544:
        thalf_x0 = 19129281;
        half_x03 = 14737111;
        break;
    case 3545:
        thalf_x0 = 19126584;
        half_x03 = 14730879;
        break;
    case 3546:
        thalf_x0 = 19123886;
        half_x03 = 14724645;
        break;
    case 3547:
        thalf_x0 = 19121189;
        half_x03 = 14718416;
        break;
    case 3548:
        thalf_x0 = 19118496;
        half_x03 = 14712199;
        break;
    case 3549:
        thalf_x0 = 19115801;
        half_x03 = 14705977;
        break;
    case 3550:
        thalf_x0 = 19113110;
        half_x03 = 14699768;
        break;
    case 3551:
        thalf_x0 = 19110420;
        half_x03 = 14693563;
        break;
    case 3552:
        thalf_x0 = 19107731;
        half_x03 = 14687360;
        break;
    case 3553:
        thalf_x0 = 19105041;
        half_x03 = 14681159;
        break;
    case 3554:
        thalf_x0 = 19102355;
        half_x03 = 14674967;
        break;
    case 3555:
        thalf_x0 = 19099667;
        half_x03 = 14668773;
        break;
    case 3556:
        thalf_x0 = 19096980;
        half_x03 = 14662584;
        break;
    case 3557:
        thalf_x0 = 19094300;
        half_x03 = 14656410;
        break;
    case 3558:
        thalf_x0 = 19091615;
        half_x03 = 14650228;
        break;
    case 3559:
        thalf_x0 = 19088933;
        half_x03 = 14644055;
        break;
    case 3560:
        thalf_x0 = 19086252;
        half_x03 = 14637887;
        break;
    case 3561:
        thalf_x0 = 19083572;
        half_x03 = 14631720;
        break;
    case 3562:
        thalf_x0 = 19080893;
        half_x03 = 14625559;
        break;
    case 3563:
        thalf_x0 = 19078217;
        half_x03 = 14619407;
        break;
    case 3564:
        thalf_x0 = 19075541;
        half_x03 = 14613256;
        break;
    case 3565:
        thalf_x0 = 19072865;
        half_x03 = 14607107;
        break;
    case 3566:
        thalf_x0 = 19070189;
        half_x03 = 14600959;
        break;
    case 3567:
        thalf_x0 = 19067517;
        half_x03 = 14594824;
        break;
    case 3568:
        thalf_x0 = 19064846;
        half_x03 = 14588690;
        break;
    case 3569:
        thalf_x0 = 19062173;
        half_x03 = 14582555;
        break;
    case 3570:
        thalf_x0 = 19059506;
        half_x03 = 14576435;
        break;
    case 3571:
        thalf_x0 = 19056837;
        half_x03 = 14570313;
        break;
    case 3572:
        thalf_x0 = 19054169;
        half_x03 = 14564193;
        break;
    case 3573:
        thalf_x0 = 19051502;
        half_x03 = 14558078;
        break;
    case 3574:
        thalf_x0 = 19048838;
        half_x03 = 14551972;
        break;
    case 3575:
        thalf_x0 = 19046174;
        half_x03 = 14545868;
        break;
    case 3576:
        thalf_x0 = 19043510;
        half_x03 = 14539765;
        break;
    case 3577:
        thalf_x0 = 19040847;
        half_x03 = 14533667;
        break;
    case 3578:
        thalf_x0 = 19038189;
        half_x03 = 14527582;
        break;
    case 3579:
        thalf_x0 = 19035530;
        half_x03 = 14521494;
        break;
    case 3580:
        thalf_x0 = 19032869;
        half_x03 = 14515405;
        break;
    case 3581:
        thalf_x0 = 19030214;
        half_x03 = 14509332;
        break;
    case 3582:
        thalf_x0 = 19027557;
        half_x03 = 14503256;
        break;
    case 3583:
        thalf_x0 = 19024904;
        half_x03 = 14497189;
        break;
    case 3584:
        thalf_x0 = 19022247;
        half_x03 = 14491117;
        break;
    case 3585:
        thalf_x0 = 19019595;
        half_x03 = 14485057;
        break;
    case 3586:
        thalf_x0 = 19016943;
        half_x03 = 14478999;
        break;
    case 3587:
        thalf_x0 = 19014296;
        half_x03 = 14472953;
        break;
    case 3588:
        thalf_x0 = 19011644;
        half_x03 = 14466898;
        break;
    case 3589:
        thalf_x0 = 19008995;
        half_x03 = 14460851;
        break;
    case 3590:
        thalf_x0 = 19006349;
        half_x03 = 14454813;
        break;
    case 3591:
        thalf_x0 = 19003703;
        half_x03 = 14448777;
        break;
    case 3592:
        thalf_x0 = 19001057;
        half_x03 = 14442743;
        break;
    case 3593:
        thalf_x0 = 18998412;
        half_x03 = 14436713;
        break;
    case 3594:
        thalf_x0 = 18995771;
        half_x03 = 14430692;
        break;
    case 3595:
        thalf_x0 = 18993128;
        half_x03 = 14424670;
        break;
    case 3596:
        thalf_x0 = 18990488;
        half_x03 = 14418656;
        break;
    case 3597:
        thalf_x0 = 18987848;
        half_x03 = 14412643;
        break;
    case 3598:
        thalf_x0 = 18985209;
        half_x03 = 14406636;
        break;
    case 3599:
        thalf_x0 = 18982572;
        half_x03 = 14400633;
        break;
    case 3600:
        thalf_x0 = 18979935;
        half_x03 = 14394633;
        break;
    case 3601:
        thalf_x0 = 18977300;
        half_x03 = 14388637;
        break;
    case 3602:
        thalf_x0 = 18974666;
        half_x03 = 14382647;
        break;
    case 3603:
        thalf_x0 = 18972032;
        half_x03 = 14376658;
        break;
    case 3604:
        thalf_x0 = 18969401;
        half_x03 = 14370677;
        break;
    case 3605:
        thalf_x0 = 18966770;
        half_x03 = 14364699;
        break;
    case 3606:
        thalf_x0 = 18964140;
        half_x03 = 14358725;
        break;
    case 3607:
        thalf_x0 = 18961512;
        half_x03 = 14352757;
        break;
    case 3608:
        thalf_x0 = 18958884;
        half_x03 = 14346790;
        break;
    case 3609:
        thalf_x0 = 18956258;
        half_x03 = 14340828;
        break;
    case 3610:
        thalf_x0 = 18953631;
        half_x03 = 14334868;
        break;
    case 3611:
        thalf_x0 = 18951009;
        half_x03 = 14328919;
        break;
    case 3612:
        thalf_x0 = 18948384;
        half_x03 = 14322966;
        break;
    case 3613:
        thalf_x0 = 18945764;
        half_x03 = 14317024;
        break;
    case 3614:
        thalf_x0 = 18943142;
        half_x03 = 14311081;
        break;
    case 3615:
        thalf_x0 = 18940523;
        half_x03 = 14305146;
        break;
    case 3616:
        thalf_x0 = 18937905;
        half_x03 = 14299216;
        break;
    case 3617:
        thalf_x0 = 18935285;
        half_x03 = 14293281;
        break;
    case 3618:
        thalf_x0 = 18932669;
        half_x03 = 14287358;
        break;
    case 3619:
        thalf_x0 = 18930053;
        half_x03 = 14281436;
        break;
    case 3620:
        thalf_x0 = 18927440;
        half_x03 = 14275523;
        break;
    case 3621:
        thalf_x0 = 18924827;
        half_x03 = 14269611;
        break;
    case 3622:
        thalf_x0 = 18922212;
        half_x03 = 14263698;
        break;
    case 3623:
        thalf_x0 = 18919604;
        half_x03 = 14257800;
        break;
    case 3624:
        thalf_x0 = 18916992;
        half_x03 = 14251897;
        break;
    case 3625:
        thalf_x0 = 18914384;
        half_x03 = 14246002;
        break;
    case 3626:
        thalf_x0 = 18911774;
        half_x03 = 14240105;
        break;
    case 3627:
        thalf_x0 = 18909170;
        half_x03 = 14234224;
        break;
    case 3628:
        thalf_x0 = 18906563;
        half_x03 = 14228337;
        break;
    case 3629:
        thalf_x0 = 18903957;
        half_x03 = 14222456;
        break;
    case 3630:
        thalf_x0 = 18901353;
        half_x03 = 14216579;
        break;
    case 3631:
        thalf_x0 = 18898752;
        half_x03 = 14210711;
        break;
    case 3632:
        thalf_x0 = 18896150;
        half_x03 = 14204841;
        break;
    case 3633:
        thalf_x0 = 18893549;
        half_x03 = 14198976;
        break;
    case 3634:
        thalf_x0 = 18890951;
        half_x03 = 14193119;
        break;
    case 3635:
        thalf_x0 = 18888351;
        half_x03 = 14187261;
        break;
    case 3636:
        thalf_x0 = 18885756;
        half_x03 = 14181414;
        break;
    case 3637:
        thalf_x0 = 18883157;
        half_x03 = 14175559;
        break;
    case 3638:
        thalf_x0 = 18880563;
        half_x03 = 14169719;
        break;
    case 3639:
        thalf_x0 = 18877970;
        half_x03 = 14163881;
        break;
    case 3640:
        thalf_x0 = 18875376;
        half_x03 = 14158044;
        break;
    case 3641:
        thalf_x0 = 18872784;
        half_x03 = 14152212;
        break;
    case 3642:
        thalf_x0 = 18870194;
        half_x03 = 14146385;
        break;
    case 3643:
        thalf_x0 = 18867603;
        half_x03 = 14140560;
        break;
    case 3644:
        thalf_x0 = 18865016;
        half_x03 = 14134743;
        break;
    case 3645:
        thalf_x0 = 18862428;
        half_x03 = 14128928;
        break;
    case 3646:
        thalf_x0 = 18859844;
        half_x03 = 14123121;
        break;
    case 3647:
        thalf_x0 = 18857256;
        half_x03 = 14117309;
        break;
    case 3648:
        thalf_x0 = 18854672;
        half_x03 = 14111505;
        break;
    case 3649:
        thalf_x0 = 18852087;
        half_x03 = 14105703;
        break;
    case 3650:
        thalf_x0 = 18849504;
        half_x03 = 14099906;
        break;
    case 3651:
        thalf_x0 = 18846924;
        half_x03 = 14094117;
        break;
    case 3652:
        thalf_x0 = 18844343;
        half_x03 = 14088326;
        break;
    case 3653:
        thalf_x0 = 18841764;
        half_x03 = 14082544;
        break;
    case 3654:
        thalf_x0 = 18839187;
        half_x03 = 14076766;
        break;
    case 3655:
        thalf_x0 = 18836609;
        half_x03 = 14070987;
        break;
    case 3656:
        thalf_x0 = 18834035;
        half_x03 = 14065219;
        break;
    case 3657:
        thalf_x0 = 18831459;
        half_x03 = 14059450;
        break;
    case 3658:
        thalf_x0 = 18828885;
        half_x03 = 14053686;
        break;
    case 3659:
        thalf_x0 = 18826313;
        half_x03 = 14047926;
        break;
    case 3660:
        thalf_x0 = 18823742;
        half_x03 = 14042172;
        break;
    case 3661:
        thalf_x0 = 18821171;
        half_x03 = 14036419;
        break;
    case 3662:
        thalf_x0 = 18818600;
        half_x03 = 14030667;
        break;
    case 3663:
        thalf_x0 = 18816032;
        half_x03 = 14024924;
        break;
    case 3664:
        thalf_x0 = 18813464;
        half_x03 = 14019183;
        break;
    case 3665:
        thalf_x0 = 18810899;
        half_x03 = 14013449;
        break;
    case 3666:
        thalf_x0 = 18808332;
        half_x03 = 14007714;
        break;
    case 3667:
        thalf_x0 = 18805767;
        half_x03 = 14001984;
        break;
    case 3668:
        thalf_x0 = 18803205;
        half_x03 = 13996262;
        break;
    case 3669:
        thalf_x0 = 18800642;
        half_x03 = 13990538;
        break;
    case 3670:
        thalf_x0 = 18798081;
        half_x03 = 13984823;
        break;
    case 3671:
        thalf_x0 = 18795519;
        half_x03 = 13979106;
        break;
    case 3672:
        thalf_x0 = 18792962;
        half_x03 = 13973400;
        break;
    case 3673:
        thalf_x0 = 18790404;
        half_x03 = 13967696;
        break;
    case 3674:
        thalf_x0 = 18787848;
        half_x03 = 13961997;
        break;
    case 3675:
        thalf_x0 = 18785292;
        half_x03 = 13956299;
        break;
    case 3676:
        thalf_x0 = 18782736;
        half_x03 = 13950603;
        break;
    case 3677:
        thalf_x0 = 18780180;
        half_x03 = 13944909;
        break;
    case 3678:
        thalf_x0 = 18777629;
        half_x03 = 13939226;
        break;
    case 3679:
        thalf_x0 = 18775079;
        half_x03 = 13933548;
        break;
    case 3680:
        thalf_x0 = 18772526;
        half_x03 = 13927865;
        break;
    case 3681:
        thalf_x0 = 18769977;
        half_x03 = 13922193;
        break;
    case 3682:
        thalf_x0 = 18767429;
        half_x03 = 13916523;
        break;
    case 3683:
        thalf_x0 = 18764880;
        half_x03 = 13910854;
        break;
    case 3684:
        thalf_x0 = 18762335;
        half_x03 = 13905194;
        break;
    case 3685:
        thalf_x0 = 18759788;
        half_x03 = 13899532;
        break;
    case 3686:
        thalf_x0 = 18757244;
        half_x03 = 13893878;
        break;
    case 3687:
        thalf_x0 = 18754700;
        half_x03 = 13888225;
        break;
    case 3688:
        thalf_x0 = 18752159;
        half_x03 = 13882581;
        break;
    case 3689:
        thalf_x0 = 18749616;
        half_x03 = 13876935;
        break;
    case 3690:
        thalf_x0 = 18747075;
        half_x03 = 13871294;
        break;
    case 3691:
        thalf_x0 = 18744536;
        half_x03 = 13865658;
        break;
    case 3692:
        thalf_x0 = 18741998;
        half_x03 = 13860026;
        break;
    case 3693:
        thalf_x0 = 18739460;
        half_x03 = 13854396;
        break;
    case 3694:
        thalf_x0 = 18736925;
        half_x03 = 13848775;
        break;
    case 3695:
        thalf_x0 = 18734388;
        half_x03 = 13843151;
        break;
    case 3696:
        thalf_x0 = 18731856;
        half_x03 = 13837539;
        break;
    case 3697:
        thalf_x0 = 18729323;
        half_x03 = 13831925;
        break;
    case 3698:
        thalf_x0 = 18726791;
        half_x03 = 13826316;
        break;
    case 3699:
        thalf_x0 = 18724259;
        half_x03 = 13820709;
        break;
    case 3700:
        thalf_x0 = 18721728;
        half_x03 = 13815106;
        break;
    case 3701:
        thalf_x0 = 18719199;
        half_x03 = 13809508;
        break;
    case 3702:
        thalf_x0 = 18716672;
        half_x03 = 13803915;
        break;
    case 3703:
        thalf_x0 = 18714144;
        half_x03 = 13798324;
        break;
    case 3704:
        thalf_x0 = 18711620;
        half_x03 = 13792740;
        break;
    case 3705:
        thalf_x0 = 18709092;
        half_x03 = 13787152;
        break;
    case 3706:
        thalf_x0 = 18706569;
        half_x03 = 13781575;
        break;
    case 3707:
        thalf_x0 = 18704045;
        half_x03 = 13775996;
        break;
    case 3708:
        thalf_x0 = 18701525;
        half_x03 = 13770429;
        break;
    case 3709:
        thalf_x0 = 18699002;
        half_x03 = 13764856;
        break;
    case 3710:
        thalf_x0 = 18696483;
        half_x03 = 13759295;
        break;
    case 3711:
        thalf_x0 = 18693965;
        half_x03 = 13753735;
        break;
    case 3712:
        thalf_x0 = 18691448;
        half_x03 = 13748181;
        break;
    case 3713:
        thalf_x0 = 18688929;
        half_x03 = 13742624;
        break;
    case 3714:
        thalf_x0 = 18686414;
        half_x03 = 13737076;
        break;
    case 3715:
        thalf_x0 = 18683900;
        half_x03 = 13731532;
        break;
    case 3716:
        thalf_x0 = 18681386;
        half_x03 = 13725990;
        break;
    case 3717:
        thalf_x0 = 18678872;
        half_x03 = 13720449;
        break;
    case 3718:
        thalf_x0 = 18676361;
        half_x03 = 13714917;
        break;
    case 3719:
        thalf_x0 = 18673850;
        half_x03 = 13709386;
        break;
    case 3720:
        thalf_x0 = 18671340;
        half_x03 = 13703859;
        break;
    case 3721:
        thalf_x0 = 18668832;
        half_x03 = 13698338;
        break;
    case 3722:
        thalf_x0 = 18666324;
        half_x03 = 13692818;
        break;
    case 3723:
        thalf_x0 = 18663816;
        half_x03 = 13687299;
        break;
    case 3724:
        thalf_x0 = 18661311;
        half_x03 = 13681789;
        break;
    case 3725:
        thalf_x0 = 18658805;
        half_x03 = 13676276;
        break;
    case 3726:
        thalf_x0 = 18656304;
        half_x03 = 13670779;
        break;
    case 3727:
        thalf_x0 = 18653799;
        half_x03 = 13665273;
        break;
    case 3728:
        thalf_x0 = 18651300;
        half_x03 = 13659781;
        break;
    case 3729:
        thalf_x0 = 18648797;
        half_x03 = 13654282;
        break;
    case 3730:
        thalf_x0 = 18646298;
        half_x03 = 13648793;
        break;
    case 3731:
        thalf_x0 = 18643800;
        half_x03 = 13643309;
        break;
    case 3732:
        thalf_x0 = 18641303;
        half_x03 = 13637827;
        break;
    case 3733:
        thalf_x0 = 18638805;
        half_x03 = 13632347;
        break;
    case 3734:
        thalf_x0 = 18636309;
        half_x03 = 13626871;
        break;
    case 3735:
        thalf_x0 = 18633815;
        half_x03 = 13621399;
        break;
    case 3736:
        thalf_x0 = 18631320;
        half_x03 = 13615930;
        break;
    case 3737:
        thalf_x0 = 18628827;
        half_x03 = 13610465;
        break;
    case 3738:
        thalf_x0 = 18626336;
        half_x03 = 13605004;
        break;
    case 3739:
        thalf_x0 = 18623844;
        half_x03 = 13599546;
        break;
    case 3740:
        thalf_x0 = 18621356;
        half_x03 = 13594095;
        break;
    case 3741:
        thalf_x0 = 18618867;
        half_x03 = 13588646;
        break;
    case 3742:
        thalf_x0 = 18616380;
        half_x03 = 13583201;
        break;
    case 3743:
        thalf_x0 = 18613893;
        half_x03 = 13577758;
        break;
    case 3744:
        thalf_x0 = 18611408;
        half_x03 = 13572320;
        break;
    case 3745:
        thalf_x0 = 18608924;
        half_x03 = 13566886;
        break;
    case 3746:
        thalf_x0 = 18606440;
        half_x03 = 13561454;
        break;
    case 3747:
        thalf_x0 = 18603957;
        half_x03 = 13556026;
        break;
    case 3748:
        thalf_x0 = 18601475;
        half_x03 = 13550600;
        break;
    case 3749:
        thalf_x0 = 18598994;
        half_x03 = 13545179;
        break;
    case 3750:
        thalf_x0 = 18596513;
        half_x03 = 13539759;
        break;
    case 3751:
        thalf_x0 = 18594036;
        half_x03 = 13534351;
        break;
    case 3752:
        thalf_x0 = 18591557;
        half_x03 = 13528937;
        break;
    case 3753:
        thalf_x0 = 18589082;
        half_x03 = 13523535;
        break;
    case 3754:
        thalf_x0 = 18586605;
        half_x03 = 13518130;
        break;
    case 3755:
        thalf_x0 = 18584132;
        half_x03 = 13512734;
        break;
    case 3756:
        thalf_x0 = 18581657;
        half_x03 = 13507336;
        break;
    case 3757:
        thalf_x0 = 18579183;
        half_x03 = 13501943;
        break;
    case 3758:
        thalf_x0 = 18576711;
        half_x03 = 13496554;
        break;
    case 3759:
        thalf_x0 = 18574239;
        half_x03 = 13491167;
        break;
    case 3760:
        thalf_x0 = 18571772;
        half_x03 = 13485791;
        break;
    case 3761:
        thalf_x0 = 18569303;
        half_x03 = 13480413;
        break;
    case 3762:
        thalf_x0 = 18566834;
        half_x03 = 13475037;
        break;
    case 3763:
        thalf_x0 = 18564369;
        half_x03 = 13469671;
        break;
    case 3764:
        thalf_x0 = 18561902;
        half_x03 = 13464301;
        break;
    case 3765:
        thalf_x0 = 18559437;
        half_x03 = 13458939;
        break;
    case 3766:
        thalf_x0 = 18556973;
        half_x03 = 13453578;
        break;
    case 3767:
        thalf_x0 = 18554510;
        half_x03 = 13448222;
        break;
    case 3768:
        thalf_x0 = 18552048;
        half_x03 = 13442870;
        break;
    case 3769:
        thalf_x0 = 18549588;
        half_x03 = 13437523;
        break;
    case 3770:
        thalf_x0 = 18547128;
        half_x03 = 13432178;
        break;
    case 3771:
        thalf_x0 = 18544668;
        half_x03 = 13426834;
        break;
    case 3772:
        thalf_x0 = 18542210;
        half_x03 = 13421494;
        break;
    case 3773:
        thalf_x0 = 18539756;
        half_x03 = 13416166;
        break;
    case 3774:
        thalf_x0 = 18537299;
        half_x03 = 13410833;
        break;
    case 3775:
        thalf_x0 = 18534842;
        half_x03 = 13405501;
        break;
    case 3776:
        thalf_x0 = 18532389;
        half_x03 = 13400180;
        break;
    case 3777:
        thalf_x0 = 18529935;
        half_x03 = 13394858;
        break;
    case 3778:
        thalf_x0 = 18527483;
        half_x03 = 13389540;
        break;
    case 3779:
        thalf_x0 = 18525032;
        half_x03 = 13384227;
        break;
    case 3780:
        thalf_x0 = 18522581;
        half_x03 = 13378915;
        break;
    case 3781:
        thalf_x0 = 18520133;
        half_x03 = 13373611;
        break;
    case 3782:
        thalf_x0 = 18517685;
        half_x03 = 13368309;
        break;
    case 3783:
        thalf_x0 = 18515237;
        half_x03 = 13363008;
        break;
    case 3784:
        thalf_x0 = 18512792;
        half_x03 = 13357714;
        break;
    case 3785:
        thalf_x0 = 18510345;
        half_x03 = 13352419;
        break;
    case 3786:
        thalf_x0 = 18507900;
        half_x03 = 13347129;
        break;
    case 3787:
        thalf_x0 = 18505457;
        half_x03 = 13341843;
        break;
    case 3788:
        thalf_x0 = 18503015;
        half_x03 = 13336562;
        break;
    case 3789:
        thalf_x0 = 18500573;
        half_x03 = 13331282;
        break;
    case 3790:
        thalf_x0 = 18498132;
        half_x03 = 13326007;
        break;
    case 3791:
        thalf_x0 = 18495693;
        half_x03 = 13320737;
        break;
    case 3792:
        thalf_x0 = 18493253;
        half_x03 = 13315465;
        break;
    case 3793:
        thalf_x0 = 18490817;
        half_x03 = 13310203;
        break;
    case 3794:
        thalf_x0 = 18488379;
        half_x03 = 13304940;
        break;
    case 3795:
        thalf_x0 = 18485943;
        half_x03 = 13299682;
        break;
    case 3796:
        thalf_x0 = 18483509;
        half_x03 = 13294428;
        break;
    case 3797:
        thalf_x0 = 18481077;
        half_x03 = 13289182;
        break;
    case 3798:
        thalf_x0 = 18478643;
        half_x03 = 13283931;
        break;
    case 3799:
        thalf_x0 = 18476211;
        half_x03 = 13278688;
        break;
    case 3800:
        thalf_x0 = 18473781;
        half_x03 = 13273449;
        break;
    case 3801:
        thalf_x0 = 18471350;
        half_x03 = 13268209;
        break;
    case 3802:
        thalf_x0 = 18468921;
        half_x03 = 13262976;
        break;
    case 3803:
        thalf_x0 = 18466493;
        half_x03 = 13257745;
        break;
    case 3804:
        thalf_x0 = 18464066;
        half_x03 = 13252519;
        break;
    case 3805:
        thalf_x0 = 18461639;
        half_x03 = 13247293;
        break;
    case 3806:
        thalf_x0 = 18459215;
        half_x03 = 13242076;
        break;
    case 3807:
        thalf_x0 = 18456791;
        half_x03 = 13236860;
        break;
    case 3808:
        thalf_x0 = 18454367;
        half_x03 = 13231645;
        break;
    case 3809:
        thalf_x0 = 18451944;
        half_x03 = 13226435;
        break;
    case 3810:
        thalf_x0 = 18449523;
        half_x03 = 13221230;
        break;
    case 3811:
        thalf_x0 = 18447104;
        half_x03 = 13216029;
        break;
    case 3812:
        thalf_x0 = 18444684;
        half_x03 = 13210829;
        break;
    case 3813:
        thalf_x0 = 18442265;
        half_x03 = 13205631;
        break;
    case 3814:
        thalf_x0 = 18439848;
        half_x03 = 13200441;
        break;
    case 3815:
        thalf_x0 = 18437432;
        half_x03 = 13195252;
        break;
    case 3816:
        thalf_x0 = 18435015;
        half_x03 = 13190064;
        break;
    case 3817:
        thalf_x0 = 18432602;
        half_x03 = 13184884;
        break;
    case 3818:
        thalf_x0 = 18430187;
        half_x03 = 13179703;
        break;
    case 3819:
        thalf_x0 = 18427773;
        half_x03 = 13174526;
        break;
    case 3820:
        thalf_x0 = 18425361;
        half_x03 = 13169353;
        break;
    case 3821:
        thalf_x0 = 18422952;
        half_x03 = 13164188;
        break;
    case 3822:
        thalf_x0 = 18420542;
        half_x03 = 13159022;
        break;
    case 3823:
        thalf_x0 = 18418133;
        half_x03 = 13153860;
        break;
    case 3824:
        thalf_x0 = 18415724;
        half_x03 = 13148699;
        break;
    case 3825:
        thalf_x0 = 18413316;
        half_x03 = 13143543;
        break;
    case 3826:
        thalf_x0 = 18410909;
        half_x03 = 13138388;
        break;
    case 3827:
        thalf_x0 = 18408506;
        half_x03 = 13133244;
        break;
    case 3828:
        thalf_x0 = 18406103;
        half_x03 = 13128102;
        break;
    case 3829:
        thalf_x0 = 18403697;
        half_x03 = 13122954;
        break;
    case 3830:
        thalf_x0 = 18401295;
        half_x03 = 13117818;
        break;
    case 3831:
        thalf_x0 = 18398894;
        half_x03 = 13112682;
        break;
    case 3832:
        thalf_x0 = 18396494;
        half_x03 = 13107552;
        break;
    case 3833:
        thalf_x0 = 18394094;
        half_x03 = 13102422;
        break;
    case 3834:
        thalf_x0 = 18391695;
        half_x03 = 13097297;
        break;
    case 3835:
        thalf_x0 = 18389300;
        half_x03 = 13092180;
        break;
    case 3836:
        thalf_x0 = 18386901;
        half_x03 = 13087058;
        break;
    case 3837:
        thalf_x0 = 18384504;
        half_x03 = 13081941;
        break;
    case 3838:
        thalf_x0 = 18382112;
        half_x03 = 13076834;
        break;
    case 3839:
        thalf_x0 = 18379716;
        half_x03 = 13071722;
        break;
    case 3840:
        thalf_x0 = 18377324;
        half_x03 = 13066618;
        break;
    case 3841:
        thalf_x0 = 18374931;
        half_x03 = 13061516;
        break;
    case 3842:
        thalf_x0 = 18372540;
        half_x03 = 13056418;
        break;
    case 3843:
        thalf_x0 = 18370149;
        half_x03 = 13051321;
        break;
    case 3844:
        thalf_x0 = 18367761;
        half_x03 = 13046232;
        break;
    case 3845:
        thalf_x0 = 18365373;
        half_x03 = 13041144;
        break;
    case 3846:
        thalf_x0 = 18362985;
        half_x03 = 13036057;
        break;
    case 3847:
        thalf_x0 = 18360599;
        half_x03 = 13030975;
        break;
    case 3848:
        thalf_x0 = 18358211;
        half_x03 = 13025892;
        break;
    case 3849:
        thalf_x0 = 18355829;
        half_x03 = 13020822;
        break;
    case 3850:
        thalf_x0 = 18353445;
        half_x03 = 13015750;
        break;
    case 3851:
        thalf_x0 = 18351062;
        half_x03 = 13010680;
        break;
    case 3852:
        thalf_x0 = 18348680;
        half_x03 = 13005614;
        break;
    case 3853:
        thalf_x0 = 18346299;
        half_x03 = 13000553;
        break;
    case 3854:
        thalf_x0 = 18343919;
        half_x03 = 12995493;
        break;
    case 3855:
        thalf_x0 = 18341540;
        half_x03 = 12990438;
        break;
    case 3856:
        thalf_x0 = 18339161;
        half_x03 = 12985384;
        break;
    case 3857:
        thalf_x0 = 18336783;
        half_x03 = 12980334;
        break;
    case 3858:
        thalf_x0 = 18334407;
        half_x03 = 12975289;
        break;
    case 3859:
        thalf_x0 = 18332031;
        half_x03 = 12970245;
        break;
    case 3860:
        thalf_x0 = 18329657;
        half_x03 = 12965205;
        break;
    case 3861:
        thalf_x0 = 18327285;
        half_x03 = 12960174;
        break;
    case 3862:
        thalf_x0 = 18324912;
        half_x03 = 12955140;
        break;
    case 3863:
        thalf_x0 = 18322539;
        half_x03 = 12950108;
        break;
    case 3864:
        thalf_x0 = 18320169;
        half_x03 = 12945083;
        break;
    case 3865:
        thalf_x0 = 18317799;
        half_x03 = 12940060;
        break;
    case 3866:
        thalf_x0 = 18315431;
        half_x03 = 12935041;
        break;
    case 3867:
        thalf_x0 = 18313064;
        half_x03 = 12930027;
        break;
    case 3868:
        thalf_x0 = 18310694;
        half_x03 = 12925008;
        break;
    case 3869:
        thalf_x0 = 18308328;
        half_x03 = 12919999;
        break;
    case 3870:
        thalf_x0 = 18305964;
        half_x03 = 12914995;
        break;
    case 3871:
        thalf_x0 = 18303600;
        half_x03 = 12909992;
        break;
    case 3872:
        thalf_x0 = 18301236;
        half_x03 = 12904991;
        break;
    case 3873:
        thalf_x0 = 18298872;
        half_x03 = 12899990;
        break;
    case 3874:
        thalf_x0 = 18296513;
        half_x03 = 12895001;
        break;
    case 3875:
        thalf_x0 = 18294152;
        half_x03 = 12890010;
        break;
    case 3876:
        thalf_x0 = 18291792;
        half_x03 = 12885023;
        break;
    case 3877:
        thalf_x0 = 18289433;
        half_x03 = 12880037;
        break;
    case 3878:
        thalf_x0 = 18287075;
        half_x03 = 12875056;
        break;
    case 3879:
        thalf_x0 = 18284720;
        half_x03 = 12870083;
        break;
    case 3880:
        thalf_x0 = 18282360;
        half_x03 = 12865101;
        break;
    case 3881:
        thalf_x0 = 18280007;
        half_x03 = 12860133;
        break;
    case 3882:
        thalf_x0 = 18277652;
        half_x03 = 12855163;
        break;
    case 3883:
        thalf_x0 = 18275300;
        half_x03 = 12850201;
        break;
    case 3884:
        thalf_x0 = 18272945;
        half_x03 = 12845234;
        break;
    case 3885:
        thalf_x0 = 18270596;
        half_x03 = 12840281;
        break;
    case 3886:
        thalf_x0 = 18268244;
        half_x03 = 12835323;
        break;
    case 3887:
        thalf_x0 = 18265895;
        half_x03 = 12830372;
        break;
    case 3888:
        thalf_x0 = 18263546;
        half_x03 = 12825423;
        break;
    case 3889:
        thalf_x0 = 18261197;
        half_x03 = 12820475;
        break;
    case 3890:
        thalf_x0 = 18258851;
        half_x03 = 12815534;
        break;
    case 3891:
        thalf_x0 = 18256503;
        half_x03 = 12810592;
        break;
    case 3892:
        thalf_x0 = 18254160;
        half_x03 = 12805661;
        break;
    case 3893:
        thalf_x0 = 18251813;
        half_x03 = 12800721;
        break;
    case 3894:
        thalf_x0 = 18249470;
        half_x03 = 12795792;
        break;
    case 3895:
        thalf_x0 = 18247128;
        half_x03 = 12790867;
        break;
    case 3896:
        thalf_x0 = 18244788;
        half_x03 = 12785947;
        break;
    case 3897:
        thalf_x0 = 18242447;
        half_x03 = 12781025;
        break;
    case 3898:
        thalf_x0 = 18240107;
        half_x03 = 12776107;
        break;
    case 3899:
        thalf_x0 = 18237768;
        half_x03 = 12771194;
        break;
    case 3900:
        thalf_x0 = 18235430;
        half_x03 = 12766281;
        break;
    case 3901:
        thalf_x0 = 18233091;
        half_x03 = 12761371;
        break;
    case 3902:
        thalf_x0 = 18230757;
        half_x03 = 12756471;
        break;
    case 3903:
        thalf_x0 = 18228420;
        half_x03 = 12751566;
        break;
    case 3904:
        thalf_x0 = 18226088;
        half_x03 = 12746671;
        break;
    case 3905:
        thalf_x0 = 18223752;
        half_x03 = 12741772;
        break;
    case 3906:
        thalf_x0 = 18221421;
        half_x03 = 12736883;
        break;
    case 3907:
        thalf_x0 = 18219089;
        half_x03 = 12731992;
        break;
    case 3908:
        thalf_x0 = 18216758;
        half_x03 = 12727106;
        break;
    case 3909:
        thalf_x0 = 18214427;
        half_x03 = 12722221;
        break;
    case 3910:
        thalf_x0 = 18212099;
        half_x03 = 12717343;
        break;
    case 3911:
        thalf_x0 = 18209771;
        half_x03 = 12712467;
        break;
    case 3912:
        thalf_x0 = 18207443;
        half_x03 = 12707592;
        break;
    case 3913:
        thalf_x0 = 18205116;
        half_x03 = 12702722;
        break;
    case 3914:
        thalf_x0 = 18202791;
        half_x03 = 12697855;
        break;
    case 3915:
        thalf_x0 = 18200468;
        half_x03 = 12692993;
        break;
    case 3916:
        thalf_x0 = 18198143;
        half_x03 = 12688130;
        break;
    case 3917:
        thalf_x0 = 18195819;
        half_x03 = 12683270;
        break;
    case 3918:
        thalf_x0 = 18193497;
        half_x03 = 12678415;
        break;
    case 3919:
        thalf_x0 = 18191177;
        half_x03 = 12673565;
        break;
    case 3920:
        thalf_x0 = 18188858;
        half_x03 = 12668719;
        break;
    case 3921:
        thalf_x0 = 18186537;
        half_x03 = 12663870;
        break;
    case 3922:
        thalf_x0 = 18184220;
        half_x03 = 12659030;
        break;
    case 3923:
        thalf_x0 = 18181901;
        half_x03 = 12654187;
        break;
    case 3924:
        thalf_x0 = 18179585;
        half_x03 = 12649352;
        break;
    case 3925:
        thalf_x0 = 18177269;
        half_x03 = 12644518;
        break;
    case 3926:
        thalf_x0 = 18174956;
        half_x03 = 12639692;
        break;
    case 3927:
        thalf_x0 = 18172641;
        half_x03 = 12634864;
        break;
    case 3928:
        thalf_x0 = 18170328;
        half_x03 = 12630040;
        break;
    case 3929:
        thalf_x0 = 18168015;
        half_x03 = 12625217;
        break;
    case 3930:
        thalf_x0 = 18165704;
        half_x03 = 12620399;
        break;
    case 3931:
        thalf_x0 = 18163394;
        half_x03 = 12615585;
        break;
    case 3932:
        thalf_x0 = 18161085;
        half_x03 = 12610776;
        break;
    case 3933:
        thalf_x0 = 18158775;
        half_x03 = 12605964;
        break;
    case 3934:
        thalf_x0 = 18156468;
        half_x03 = 12601160;
        break;
    case 3935:
        thalf_x0 = 18154161;
        half_x03 = 12596357;
        break;
    case 3936:
        thalf_x0 = 18151857;
        half_x03 = 12591562;
        break;
    case 3937:
        thalf_x0 = 18149549;
        half_x03 = 12586759;
        break;
    case 3938:
        thalf_x0 = 18147243;
        half_x03 = 12581963;
        break;
    case 3939:
        thalf_x0 = 18144944;
        half_x03 = 12577180;
        break;
    case 3940:
        thalf_x0 = 18142640;
        half_x03 = 12572390;
        break;
    case 3941:
        thalf_x0 = 18140339;
        half_x03 = 12567607;
        break;
    case 3942:
        thalf_x0 = 18138036;
        half_x03 = 12562822;
        break;
    case 3943:
        thalf_x0 = 18135740;
        half_x03 = 12558051;
        break;
    case 3944:
        thalf_x0 = 18133439;
        half_x03 = 12553271;
        break;
    case 3945:
        thalf_x0 = 18131141;
        half_x03 = 12548499;
        break;
    case 3946:
        thalf_x0 = 18128843;
        half_x03 = 12543729;
        break;
    case 3947:
        thalf_x0 = 18126548;
        half_x03 = 12538965;
        break;
    case 3948:
        thalf_x0 = 18124251;
        half_x03 = 12534200;
        break;
    case 3949:
        thalf_x0 = 18121956;
        half_x03 = 12529439;
        break;
    case 3950:
        thalf_x0 = 18119663;
        half_x03 = 12524683;
        break;
    case 3951:
        thalf_x0 = 18117371;
        half_x03 = 12519931;
        break;
    case 3952:
        thalf_x0 = 18115079;
        half_x03 = 12515180;
        break;
    case 3953:
        thalf_x0 = 18112787;
        half_x03 = 12510430;
        break;
    case 3954:
        thalf_x0 = 18110495;
        half_x03 = 12505681;
        break;
    case 3955:
        thalf_x0 = 18108207;
        half_x03 = 12500943;
        break;
    case 3956:
        thalf_x0 = 18105917;
        half_x03 = 12496200;
        break;
    case 3957:
        thalf_x0 = 18103631;
        half_x03 = 12491467;
        break;
    case 3958:
        thalf_x0 = 18101345;
        half_x03 = 12486736;
        break;
    case 3959:
        thalf_x0 = 18099059;
        half_x03 = 12482006;
        break;
    case 3960:
        thalf_x0 = 18096773;
        half_x03 = 12477277;
        break;
    case 3961:
        thalf_x0 = 18094488;
        half_x03 = 12472552;
        break;
    case 3962:
        thalf_x0 = 18092205;
        half_x03 = 12467832;
        break;
    case 3963:
        thalf_x0 = 18089921;
        half_x03 = 12463109;
        break;
    case 3964:
        thalf_x0 = 18087639;
        half_x03 = 12458394;
        break;
    case 3965:
        thalf_x0 = 18085359;
        half_x03 = 12453684;
        break;
    case 3966:
        thalf_x0 = 18083079;
        half_x03 = 12448974;
        break;
    case 3967:
        thalf_x0 = 18080799;
        half_x03 = 12444266;
        break;
    case 3968:
        thalf_x0 = 18078524;
        half_x03 = 12439568;
        break;
    case 3969:
        thalf_x0 = 18076247;
        half_x03 = 12434868;
        break;
    case 3970:
        thalf_x0 = 18073970;
        half_x03 = 12430170;
        break;
    case 3971:
        thalf_x0 = 18071693;
        half_x03 = 12425472;
        break;
    case 3972:
        thalf_x0 = 18069420;
        half_x03 = 12420786;
        break;
    case 3973:
        thalf_x0 = 18067145;
        half_x03 = 12416094;
        break;
    case 3974:
        thalf_x0 = 18064872;
        half_x03 = 12411409;
        break;
    case 3975:
        thalf_x0 = 18062601;
        half_x03 = 12406729;
        break;
    case 3976:
        thalf_x0 = 18060327;
        half_x03 = 12402044;
        break;
    case 3977:
        thalf_x0 = 18058058;
        half_x03 = 12397369;
        break;
    case 3978:
        thalf_x0 = 18055788;
        half_x03 = 12392695;
        break;
    case 3979:
        thalf_x0 = 18053520;
        half_x03 = 12388026;
        break;
    case 3980:
        thalf_x0 = 18051252;
        half_x03 = 12383358;
        break;
    case 3981:
        thalf_x0 = 18048984;
        half_x03 = 12378691;
        break;
    case 3982:
        thalf_x0 = 18046718;
        half_x03 = 12374028;
        break;
    case 3983:
        thalf_x0 = 18044456;
        half_x03 = 12369375;
        break;
    case 3984:
        thalf_x0 = 18042189;
        half_x03 = 12364715;
        break;
    case 3985:
        thalf_x0 = 18039924;
        half_x03 = 12360059;
        break;
    case 3986:
        thalf_x0 = 18037664;
        half_x03 = 12355413;
        break;
    case 3987:
        thalf_x0 = 18035400;
        half_x03 = 12350762;
        break;
    case 3988:
        thalf_x0 = 18033140;
        half_x03 = 12346119;
        break;
    case 3989:
        thalf_x0 = 18030879;
        half_x03 = 12341477;
        break;
    case 3990:
        thalf_x0 = 18028619;
        half_x03 = 12336835;
        break;
    case 3991:
        thalf_x0 = 18026361;
        half_x03 = 12332202;
        break;
    case 3992:
        thalf_x0 = 18024104;
        half_x03 = 12327569;
        break;
    case 3993:
        thalf_x0 = 18021848;
        half_x03 = 12322941;
        break;
    case 3994:
        thalf_x0 = 18019592;
        half_x03 = 12318313;
        break;
    case 3995:
        thalf_x0 = 18017336;
        half_x03 = 12313687;
        break;
    case 3996:
        thalf_x0 = 18015081;
        half_x03 = 12309065;
        break;
    case 3997:
        thalf_x0 = 18012828;
        half_x03 = 12304448;
        break;
    case 3998:
        thalf_x0 = 18010575;
        half_x03 = 12299831;
        break;
    case 3999:
        thalf_x0 = 18008324;
        half_x03 = 12295219;
        break;
    case 4000:
        thalf_x0 = 18006072;
        half_x03 = 12290608;
        break;
    case 4001:
        thalf_x0 = 18003821;
        half_x03 = 12285998;
        break;
    case 4002:
        thalf_x0 = 18001574;
        half_x03 = 12281399;
        break;
    case 4003:
        thalf_x0 = 17999324;
        half_x03 = 12276794;
        break;
    case 4004:
        thalf_x0 = 17997077;
        half_x03 = 12272197;
        break;
    case 4005:
        thalf_x0 = 17994830;
        half_x03 = 12267601;
        break;
    case 4006:
        thalf_x0 = 17992584;
        half_x03 = 12263009;
        break;
    case 4007:
        thalf_x0 = 17990340;
        half_x03 = 12258421;
        break;
    case 4008:
        thalf_x0 = 17988096;
        half_x03 = 12253835;
        break;
    case 4009:
        thalf_x0 = 17985852;
        half_x03 = 12249249;
        break;
    case 4010:
        thalf_x0 = 17983610;
        half_x03 = 12244668;
        break;
    case 4011:
        thalf_x0 = 17981367;
        half_x03 = 12240088;
        break;
    case 4012:
        thalf_x0 = 17979129;
        half_x03 = 12235518;
        break;
    case 4013:
        thalf_x0 = 17976888;
        half_x03 = 12230944;
        break;
    case 4014:
        thalf_x0 = 17974647;
        half_x03 = 12226370;
        break;
    case 4015:
        thalf_x0 = 17972411;
        half_x03 = 12221807;
        break;
    case 4016:
        thalf_x0 = 17970171;
        half_x03 = 12217239;
        break;
    case 4017:
        thalf_x0 = 17967936;
        half_x03 = 12212681;
        break;
    case 4018:
        thalf_x0 = 17965701;
        half_x03 = 12208124;
        break;
    case 4019:
        thalf_x0 = 17963465;
        half_x03 = 12203565;
        break;
    case 4020:
        thalf_x0 = 17961230;
        half_x03 = 12199011;
        break;
    case 4021:
        thalf_x0 = 17958998;
        half_x03 = 12194463;
        break;
    case 4022:
        thalf_x0 = 17956766;
        half_x03 = 12189917;
        break;
    case 4023:
        thalf_x0 = 17954534;
        half_x03 = 12185372;
        break;
    case 4024:
        thalf_x0 = 17952303;
        half_x03 = 12180831;
        break;
    case 4025:
        thalf_x0 = 17950073;
        half_x03 = 12176292;
        break;
    case 4026:
        thalf_x0 = 17947844;
        half_x03 = 12171756;
        break;
    case 4027:
        thalf_x0 = 17945615;
        half_x03 = 12167222;
        break;
    case 4028:
        thalf_x0 = 17943387;
        half_x03 = 12162692;
        break;
    case 4029:
        thalf_x0 = 17941161;
        half_x03 = 12158166;
        break;
    case 4030:
        thalf_x0 = 17938935;
        half_x03 = 12153641;
        break;
    case 4031:
        thalf_x0 = 17936711;
        half_x03 = 12149120;
        break;
    case 4032:
        thalf_x0 = 17934488;
        half_x03 = 12144603;
        break;
    case 4033:
        thalf_x0 = 17932263;
        half_x03 = 12140085;
        break;
    case 4034:
        thalf_x0 = 17930042;
        half_x03 = 12135574;
        break;
    case 4035:
        thalf_x0 = 17927819;
        half_x03 = 12131060;
        break;
    case 4036:
        thalf_x0 = 17925597;
        half_x03 = 12126551;
        break;
    case 4037:
        thalf_x0 = 17923377;
        half_x03 = 12122046;
        break;
    case 4038:
        thalf_x0 = 17921160;
        half_x03 = 12117549;
        break;
    case 4039:
        thalf_x0 = 17918940;
        half_x03 = 12113046;
        break;
    case 4040:
        thalf_x0 = 17916723;
        half_x03 = 12108551;
        break;
    case 4041:
        thalf_x0 = 17914505;
        half_x03 = 12104053;
        break;
    case 4042:
        thalf_x0 = 17912292;
        half_x03 = 12099569;
        break;
    case 4043:
        thalf_x0 = 17910075;
        half_x03 = 12095077;
        break;
    case 4044:
        thalf_x0 = 17907861;
        half_x03 = 12090592;
        break;
    case 4045:
        thalf_x0 = 17905647;
        half_x03 = 12086108;
        break;
    case 4046:
        thalf_x0 = 17903436;
        half_x03 = 12081632;
        break;
    case 4047:
        thalf_x0 = 17901224;
        half_x03 = 12077153;
        break;
    case 4048:
        thalf_x0 = 17899011;
        half_x03 = 12072676;
        break;
    case 4049:
        thalf_x0 = 17896802;
        half_x03 = 12068205;
        break;
    case 4050:
        thalf_x0 = 17894594;
        half_x03 = 12063739;
        break;
    case 4051:
        thalf_x0 = 17892384;
        half_x03 = 12059271;
        break;
    case 4052:
        thalf_x0 = 17890176;
        half_x03 = 12054807;
        break;
    case 4053:
        thalf_x0 = 17887970;
        half_x03 = 12050347;
        break;
    case 4054:
        thalf_x0 = 17885763;
        half_x03 = 12045889;
        break;
    case 4055:
        thalf_x0 = 17883560;
        half_x03 = 12041437;
        break;
    case 4056:
        thalf_x0 = 17881355;
        half_x03 = 12036983;
        break;
    case 4057:
        thalf_x0 = 17879148;
        half_x03 = 12032528;
        break;
    case 4058:
        thalf_x0 = 17876948;
        half_x03 = 12028086;
        break;
    case 4059:
        thalf_x0 = 17874744;
        half_x03 = 12023639;
        break;
    case 4060:
        thalf_x0 = 17872544;
        half_x03 = 12019199;
        break;
    case 4061:
        thalf_x0 = 17870345;
        half_x03 = 12014763;
        break;
    case 4062:
        thalf_x0 = 17868144;
        half_x03 = 12010325;
        break;
    case 4063:
        thalf_x0 = 17865945;
        half_x03 = 12005891;
        break;
    case 4064:
        thalf_x0 = 17863748;
        half_x03 = 12001462;
        break;
    case 4065:
        thalf_x0 = 17861552;
        half_x03 = 11997036;
        break;
    case 4066:
        thalf_x0 = 17859353;
        half_x03 = 11992606;
        break;
    case 4067:
        thalf_x0 = 17857160;
        half_x03 = 11988188;
        break;
    case 4068:
        thalf_x0 = 17854964;
        half_x03 = 11983766;
        break;
    case 4069:
        thalf_x0 = 17852771;
        half_x03 = 11979351;
        break;
    case 4070:
        thalf_x0 = 17850576;
        half_x03 = 11974934;
        break;
    case 4071:
        thalf_x0 = 17848385;
        half_x03 = 11970524;
        break;
    case 4072:
        thalf_x0 = 17846193;
        half_x03 = 11966115;
        break;
    case 4073:
        thalf_x0 = 17844003;
        half_x03 = 11961710;
        break;
    case 4074:
        thalf_x0 = 17841813;
        half_x03 = 11957307;
        break;
    case 4075:
        thalf_x0 = 17839623;
        half_x03 = 11952904;
        break;
    case 4076:
        thalf_x0 = 17837436;
        half_x03 = 11948509;
        break;
    case 4077:
        thalf_x0 = 17835248;
        half_x03 = 11944111;
        break;
    case 4078:
        thalf_x0 = 17833061;
        half_x03 = 11939718;
        break;
    case 4079:
        thalf_x0 = 17830875;
        half_x03 = 11935329;
        break;
    case 4080:
        thalf_x0 = 17828690;
        half_x03 = 11930941;
        break;
    case 4081:
        thalf_x0 = 17826506;
        half_x03 = 11926557;
        break;
    case 4082:
        thalf_x0 = 17824322;
        half_x03 = 11922174;
        break;
    case 4083:
        thalf_x0 = 17822139;
        half_x03 = 11917795;
        break;
    case 4084:
        thalf_x0 = 17819960;
        half_x03 = 11913423;
        break;
    case 4085:
        thalf_x0 = 17817779;
        half_x03 = 11909049;
        break;
    case 4086:
        thalf_x0 = 17815598;
        half_x03 = 11904677;
        break;
    case 4087:
        thalf_x0 = 17813417;
        half_x03 = 11900305;
        break;
    case 4088:
        thalf_x0 = 17811240;
        half_x03 = 11895943;
        break;
    case 4089:
        thalf_x0 = 17809061;
        half_x03 = 11891577;
        break;
    case 4090:
        thalf_x0 = 17806884;
        half_x03 = 11887218;
        break;
    case 4091:
        thalf_x0 = 17804709;
        half_x03 = 11882862;
        break;
    case 4092:
        thalf_x0 = 17802531;
        half_x03 = 11878502;
        break;
    case 4093:
        thalf_x0 = 17800358;
        half_x03 = 11874152;
        break;
    case 4094:
        thalf_x0 = 17798184;
        half_x03 = 11869803;
        break;
    case 4095:
        thalf_x0 = 17796012;
        half_x03 = 11865458;
        break;
    }
           
    long half_ax03,mya;
    unsigned int mrb,mra,mr,ey,my,flag1,flag2,mya2,y;
    float r;
    half_ax03 = (long)((1 << 23) | mx) * (long)half_x03;
    half_ax03 = half_ax03 >> 25;
    mrb = (unsigned int)half_ax03;
    mra = thalf_x0 - mrb;
    mr = mra & 0x7fffff;
    mya = (long)((1 << 23) | mr) * (long)((1 << 23) | mx);
    if((x & 0xffffff) == 0x7fffff) flag1 = 1;
    else flag1 = 0;
    if(ex == 0) ey = 0;
    else ey = 63 + (ex >> 1) + odd_flag + flag1;
    mya = mya >> 20;
    mya2 = (unsigned int)mya;
    flag2 = (mya2 >> 27) & 1;
    if(flag2 == 1) my = (mya2 & 0x7ffffff) >> 4;
    else my = (mya2 & 0x3ffffff) >> 3;
    y = (ey << 23) | my;
    r = *((float *)&y);

    return r;

}

float fneg(float f){

    return -f;

}

int feq(float a, float b){

    return ( a == b ? 1 : 0);

}

int flt(float a, float b){

    return ( a < b ? 1 : 0);

}

int fle(float a, float b){

    return ( a <= b ? 1 : 0);

}

float itof(int x){
    unsigned int xbit,sx,se,mxa,mxb;
    unsigned int eya,sy,ey,my,mya,y;
    unsigned int flag1;
    unsigned int i,bit;
    float r;
    
    xbit = *((unsigned int *)&x);
    sx = xbit >> 31;
    mxa = xbit & 0x7fffffff;
    if(sx == 1){
	mxb = ((~mxa) + 1) & 0x7fffffff;
    }
    else mxb = mxa;
    for(i = 0;i < 31;i++){
	bit = (mxb >> (30-i)) & 1;
 	if(bit == 1) break;
    }
    se = i;
    sy = sx;
    if(se < 32) mya = mxb << se;
    else mya = 0;
    my = ((mya & 0x3fffffff) >> 7) + ((mya >> 6) & 1);
    if(((mya & 0x3fffffff) >> 6) == 0xffffff) flag1 = 1;
    else flag1 = 0;
    eya = 157 + flag1;
    if(xbit == 0x80000000) ey = 158;
    else if (se == 31) ey = 0;
    else ey = eya - se;
    y = (sy << 31) | (ey << 23) | my;
    r = *((float *)&y);
    
    return r;

}

int ftoi(float f){
    unsigned int x,sx,ex,mx,se;
    unsigned int mya,myb,myc,my;
    unsigned int sy,y;
    x = *((unsigned int *)&f);
    sx = x >> 31;
    ex = (x & 0x7fffffff) >> 23;
    mx = x & 0x7fffff;
    mya = (1 << 31) | (mx << 8);
    if(ex <= 157) se = 157 - ex;
    else se = 255;
    if(se < 32) myb = (mya >> se) + 1;
    else myb = 1;
    myc = myb >> 1;
    sy = sx;
    if(sy == 1) my = ((~myc) + 1) & 0x7fffffff;
    else my = myc;
    if(my == 0) y = 0;
    else y = (sy << 31) | my;
    return y;

}
