# CharFreq - for extended ascii encoded files.
# Author: Andrew Morgan
# License: GPLv3
# run using this command on a nix command line:
#     od -cb testdata.tab | gawk -f charfreq.awk | sort -n

BEGIN {
ref["000"]=" NUL  000 0x00 00000000 Null char "
ref["001"]=" SOH  001 0x01 00000001 Start of Heading "
ref["002"]=" STX  002 0x02 00000010 Start of Text "
ref["003"]=" ETX  003 0x03 00000011 End of Text "
ref["004"]=" EOT  004 0x04 00000100 End of Transmission "
ref["005"]=" ENQ  005 0x05 00000101 Enquiry "
ref["006"]=" ACK  006 0x06 00000110 Acknowledgment "
ref["007"]=" BEL  007 0x07 00000111 Bell "
ref["010"]=" BS   008 0x08 00001000 Back Space "
ref["011"]=" HT   009 0x09 00001001 Horizontal Tab "
ref["012"]=" LF   010 0x0A 00001010 Line Feed "
ref["013"]=" VT   011 0x0B 00001011 Vertical Tab "
ref["014"]=" FF   012 0x0C 00001100 Form Feed "
ref["015"]=" CR   013 0x0D 00001101 Carriage Return "
ref["016"]=" SO   014 0x0E 00001110 Shift Out / X-On "
ref["017"]=" SI   015 0x0F 00001111 Shift In / X-Off "
ref["020"]=" DLE  016 0x10 00010000 Data Line Escape "
ref["021"]=" DC1  017 0x11 00010001 Device Control 1 (oft. XON) "
ref["022"]=" DC2  018 0x12 00010010 Device Control 2 "
ref["023"]=" DC3  019 0x13 00010011 Device Control 3 (oft. XOFF) "
ref["024"]=" DC4  020 0x14 00010100 Device Control 4 "
ref["025"]=" NAK  021 0x15 00010101 Negative Acknowledgement "
ref["026"]=" SYN  022 0x16 00010110 Synchronous Idle "
ref["027"]=" ETB  023 0x17 00010111 End of Transmit Block "
ref["030"]=" CAN  024 0x18 00011000 Cancel "
ref["031"]=" EM   025 0x19 00011001 End of Medium "
ref["032"]=" SUB  026 0x1A 00011010 Substitute "
ref["033"]=" ESC  027 0x1B 00011011 Escape "
ref["034"]=" FS   028 0x1C 00011100 File Separator "
ref["035"]=" GS   029 0x1D 00011101 Group Separator "
ref["036"]=" RS   030 0x1E 00011110 Record Separator "
ref["037"]=" US   031 0x1F 00011111 Unit Separator "
ref["040"]="      032 0x20 00100000 Space "
ref["041"]=" !    033 0x21 00100001 Exclamation mark "
ref["042"]=" \"   034 0x22 00100010 Double quotes (or speech marks) "
ref["043"]=" #    035 0x23 00100011 Number "
ref["044"]=" $    036 0x24 00100100 Dollar "
ref["045"]=" %    037 0x25 00100101 Procenttecken "
ref["046"]=" &    038 0x26 00100110 Ampersand "
ref["047"]=" '    039 0x27 00100111 Single quote "
ref["050"]=" (    040 0x28 00101000 Open parenthesis (or open bracket) "
ref["051"]=" )    041 0x29 00101001 Close parenthesis (or close bracket) "
ref["052"]=" *    042 0x2A 00101010 Asterisk "
ref["053"]=" +    043 0x2B 00101011 Plus "
ref["054"]=" ,    044 0x2C 00101100 Comma "
ref["055"]=" -    045 0x2D 00101101 Hyphen "
ref["056"]=" .    046 0x2E 00101110 Period, dot or full stop "
ref["057"]=" /    047 0x2F 00101111 Slash or divide "
ref["060"]=" 0    048 0x30 00110000 Zero "
ref["061"]=" 1    049 0x31 00110001 One "
ref["062"]=" 2    050 0x32 00110010 Two "
ref["063"]=" 3    051 0x33 00110011 Three "
ref["064"]=" 4    052 0x34 00110100 Four "
ref["065"]=" 5    053 0x35 00110101 Five "
ref["066"]=" 6    054 0x36 00110110 Six "
ref["067"]=" 7    055 0x37 00110111 Seven "
ref["070"]=" 8    056 0x38 00111000 Eight "
ref["071"]=" 9    057 0x39 00111001 Nine "
ref["072"]=" :    058 0x3A 00111010 Colon "
ref["073"]=" ;    059 0x3B 00111011 Semicolon "
ref["074"]=" <    060 0x3C 00111100 Less than (or open angled bracket) "
ref["075"]=" =    061 0x3D 00111101 Equals "
ref["076"]=" >    062 0x3E 00111110 Greater than (or close angled bracket) "
ref["077"]=" ?    063 0x3F 00111111 Question mark "
ref["100"]=" @    064 0x40 01000000 At symbol "
ref["101"]=" A    065 0x41 01000001 Uppercase A "
ref["102"]=" B    066 0x42 01000010 Uppercase B "
ref["103"]=" C    067 0x43 01000011 Uppercase C "
ref["104"]=" D    068 0x44 01000100 Uppercase D "
ref["105"]=" E    069 0x45 01000101 Uppercase E "
ref["106"]=" F    070 0x46 01000110 Uppercase F "
ref["107"]=" G    071 0x47 01000111 Uppercase G "
ref["110"]=" H    072 0x48 01001000 Uppercase H "
ref["111"]=" I    073 0x49 01001001 Uppercase I "
ref["112"]=" J    074 0x4A 01001010 Uppercase J "
ref["113"]=" K    075 0x4B 01001011 Uppercase K "
ref["114"]=" L    076 0x4C 01001100 Uppercase L "
ref["115"]=" M    077 0x4D 01001101 Uppercase M "
ref["116"]=" N    078 0x4E 01001110 Uppercase N "
ref["117"]=" O    079 0x4F 01001111 Uppercase O "
ref["120"]=" P    080 0x50 01010000 Uppercase P "
ref["121"]=" Q    081 0x51 01010001 Uppercase Q "
ref["122"]=" R    082 0x52 01010010 Uppercase R "
ref["123"]=" S    083 0x53 01010011 Uppercase S "
ref["124"]=" T    084 0x54 01010100 Uppercase T "
ref["125"]=" U    085 0x55 01010101 Uppercase U "
ref["126"]=" V    086 0x56 01010110 Uppercase V "
ref["127"]=" W    087 0x57 01010111 Uppercase W "
ref["130"]=" X    088 0x58 01011000 Uppercase X "
ref["131"]=" Y    089 0x59 01011001 Uppercase Y "
ref["132"]=" Z    090 0x5A 01011010 Uppercase Z "
ref["133"]=" [    091 0x5B 01011011 Opening bracket "
ref["134"]=" \\   092 0x5C 01011100 Backslash "
ref["135"]=" ]    093 0x5D 01011101 Closing bracket "
ref["136"]=" ^    094 0x5E 01011110 Caret - circumflex "
ref["137"]=" _    095 0x5F 01011111 Underscore "
ref["140"]=" `    096 0x60 01100000 Grave accent "
ref["141"]=" a    097 0x61 01100001 Lowercase a "
ref["142"]=" b    098 0x62 01100010 Lowercase b "
ref["143"]=" c    099 0x63 01100011 Lowercase c "
ref["144"]=" d    100 0x64 01100100 Lowercase d "
ref["145"]=" e    101 0x65 01100101 Lowercase e "
ref["146"]=" f    102 0x66 01100110 Lowercase f "
ref["147"]=" g    103 0x67 01100111 Lowercase g "
ref["150"]=" h    104 0x68 01101000 Lowercase h "
ref["151"]=" i    105 0x69 01101001 Lowercase i "
ref["152"]=" j    106 0x6A 01101010 Lowercase j "
ref["153"]=" k    107 0x6B 01101011 Lowercase k "
ref["154"]=" l    108 0x6C 01101100 Lowercase l "
ref["155"]=" m    109 0x6D 01101101 Lowercase m "
ref["156"]=" n    110 0x6E 01101110 Lowercase n "
ref["157"]=" o    111 0x6F 01101111 Lowercase o "
ref["160"]=" p    112 0x70 01110000 Lowercase p "
ref["161"]=" q    113 0x71 01110001 Lowercase q "
ref["162"]=" r    114 0x72 01110010 Lowercase r "
ref["163"]=" s    115 0x73 01110011 Lowercase s "
ref["164"]=" t    116 0x74 01110100 Lowercase t "
ref["165"]=" u    117 0x75 01110101 Lowercase u "
ref["166"]=" v    118 0x76 01110110 Lowercase v "
ref["167"]=" w    119 0x77 01110111 Lowercase w "
ref["170"]=" x    120 0x78 01111000 Lowercase x "
ref["171"]=" y    121 0x79 01111001 Lowercase y "
ref["172"]=" z    122 0x7A 01111010 Lowercase z "
ref["173"]=" {    123 0x7B 01111011 Opening brace "
ref["174"]=" |    124 0x7C 01111100 Vertical bar "
ref["175"]=" }    125 0x7D 01111101 Closing brace "
ref["176"]=" ~    126 0x7E 01111110 Equivalency sign - tilde "
ref["177"]="      127 0x7F 01111111 Delete "
ref["200"]=" €    128 0x80 10000000 Euro sign "
ref["201"]="      129 0x81 10000001  "
ref["202"]=" ‚    130 0x82 10000010 Single low-9 quotation mark "
ref["203"]=" ƒ    131 0x83 10000011 Latin small letter f with hook "
ref["204"]=" „    132 0x84 10000100 Double low-9 quotation mark "
ref["205"]=" …    133 0x85 10000101 Horizontal ellipsis "
ref["206"]=" †    134 0x86 10000110 Dagger "
ref["207"]=" ‡    135 0x87 10000111 Double dagger "
ref["210"]=" ˆ    136 0x88 10001000 Modifier letter circumflex accent "
ref["211"]=" ‰    137 0x89 10001001 Per mille sign "
ref["212"]=" Š    138 0x8A 10001010 Latin capital letter S with caron "
ref["213"]=" ‹    139 0x8B 10001011 Single left-pointing angle quotation "
ref["214"]=" Œ    140 0x8C 10001100 Latin capital ligature OE "
ref["215"]="      141 0x8D 10001101  "
ref["216"]=" Ž    142 0x8E 10001110 Latin captial letter Z with caron "
ref["217"]="      143 0x8F 10001111  "
ref["220"]="      144 0x90 10010000  "
ref["221"]=" ‘    145 0x91 10010001 Left single quotation mark "
ref["222"]=" ’    146 0x92 10010010 Right single quotation mark "
ref["223"]=" “    147 0x93 10010011 Left double quotation mark "
ref["224"]=" ”    148 0x94 10010100 Right double quotation mark "
ref["225"]=" •    149 0x95 10010101 Bullet "
ref["226"]=" –    150 0x96 10010110 En dash "
ref["227"]=" —    151 0x97 10010111 Em dash "
ref["230"]=" ˜     152 0x98 10011000 Small tilde "
ref["231"]=" ™    153 0x99 10011001 Trade mark sign "
ref["232"]=" š    154 0x9A 10011010 Latin small letter S with caron "
ref["233"]=" ›    155 0x9B 10011011 Single right-pointing angle quotation mark "
ref["234"]=" œ    156 0x9C 10011100 Latin small ligature oe "
ref["235"]="      157 0x9D 10011101  "
ref["236"]=" ž    158 0x9E 10011110 Latin small letter z with caron "
ref["237"]=" Ÿ    159 0x9F 10011111 Latin capital letter Y with diaeresis "
ref["240"]="      160 0xA0 10100000 Non-breaking space "
ref["241"]=" ¡    161 0xA1 10100001 Inverted exclamation mark "
ref["242"]=" ¢    162 0xA2 10100010 Cent sign "
ref["243"]=" £    163 0xA3 10100011 Pound sign "
ref["244"]=" ¤    164 0xA4 10100100 Currency sign "
ref["245"]=" ¥    165 0xA5 10100101 Yen sign "
ref["246"]=" ¦    166 0xA6 10100110 Pipe, Broken vertical bar "
ref["247"]=" §    167 0xA7 10100111 Section sign "
ref["250"]=" ¨    168 0xA8 10101000 Spacing diaeresis - umlaut "
ref["251"]=" ©    169 0xA9 10101001 Copyright sign "
ref["252"]=" ª    170 0xAA 10101010 Feminine ordinal indicator "
ref["253"]=" «    171 0xAB 10101011 Left double angle quotes "
ref["254"]=" ¬    172 0xAC 10101100 Not sign "
ref["255"]=" ­    173 0xAD 10101101 Soft hyphen "
ref["256"]=" ®    174 0xAE 10101110 Registered trade mark sign "
ref["257"]=" ¯    175 0xAF 10101111 Spacing macron - overline "
ref["260"]=" °    176 0xB0 10110000 Degree sign "
ref["261"]=" ±    177 0xB1 10110001 Plus-or-minus sign "
ref["262"]=" ²    178 0xB2 10110010 Superscript two - squared "
ref["263"]=" ³    179 0xB3 10110011 Superscript three - cubed "
ref["264"]=" ´    180 0xB4 10110100 Acute accent - spacing acute "
ref["265"]=" µ    181 0xB5 10110101 Micro sign "
ref["266"]=" ¶    182 0xB6 10110110 Pilcrow sign - paragraph sign "
ref["267"]=" ·    183 0xB7 10110111 Middle dot - Georgian comma "
ref["270"]=" ¸    184 0xB8 10111000 Spacing cedilla "
ref["271"]=" ¹    185 0xB9 10111001 Superscript one "
ref["272"]=" º    186 0xBA 10111010 Masculine ordinal indicator "
ref["273"]=" »    187 0xBB 10111011 Right double angle quotes "
ref["274"]=" ¼    188 0xBC 10111100 Fraction one quarter "
ref["275"]=" ½    189 0xBD 10111101 Fraction one half "
ref["276"]=" ¾    190 0xBE 10111110 Fraction three quarters "
ref["277"]=" ¿    191 0xBF 10111111 Inverted question mark "
ref["300"]=" À    192 0xC0 11000000 Latin capital letter A with grave "
ref["301"]=" Á    193 0xC1 11000001 Latin capital letter A with acute "
ref["302"]=" Â    194 0xC2 11000010 Latin capital letter A with circumflex "
ref["303"]=" Ã    195 0xC3 11000011 Latin capital letter A with tilde "
ref["304"]=" Ä    196 0xC4 11000100 Latin capital letter A with diaeresis "
ref["305"]=" Å    197 0xC5 11000101 Latin capital letter A with ring above "
ref["306"]=" Æ    198 0xC6 11000110 Latin capital letter AE "
ref["307"]=" Ç    199 0xC7 11000111 Latin capital letter C with cedilla "
ref["310"]=" È    200 0xC8 11001000 Latin capital letter E with grave "
ref["311"]=" É    201 0xC9 11001001 Latin capital letter E with acute "
ref["312"]=" Ê    202 0xCA 11001010 Latin capital letter E with circumflex "
ref["313"]=" Ë    203 0xCB 11001011 Latin capital letter E with diaeresis "
ref["314"]=" Ì    204 0xCC 11001100 Latin capital letter I with grave "
ref["315"]=" Í    205 0xCD 11001101 Latin capital letter I with acute "
ref["316"]=" Î    206 0xCE 11001110 Latin capital letter I with circumflex "
ref["317"]=" Ï    207 0xCF 11001111 Latin capital letter I with diaeresis "
ref["320"]=" Ð    208 0xD0 11010000 Latin capital letter ETH "
ref["321"]=" Ñ    209 0xD1 11010001 Latin capital letter N with tilde "
ref["322"]=" Ò    210 0xD2 11010010 Latin capital letter O with grave "
ref["323"]=" Ó    211 0xD3 11010011 Latin capital letter O with acute "
ref["324"]=" Ô    212 0xD4 11010100 Latin capital letter O with circumflex "
ref["325"]=" Õ    213 0xD5 11010101 Latin capital letter O with tilde "
ref["326"]=" Ö    214 0xD6 11010110 Latin capital letter O with diaeresis "
ref["327"]=" ×    215 0xD7 11010111 Multiplication sign "
ref["330"]=" Ø    216 0xD8 11011000 Latin capital letter O with slash "
ref["331"]=" Ù    217 0xD9 11011001 Latin capital letter U with grave "
ref["332"]=" Ú    218 0xDA 11011010 Latin capital letter U with acute "
ref["333"]=" Û    219 0xDB 11011011 Latin capital letter U with circumflex "
ref["334"]=" Ü    220 0xDC 11011100 Latin capital letter U with diaeresis "
ref["335"]=" Ý    221 0xDD 11011101 Latin capital letter Y with acute "
ref["336"]=" Þ    222 0xDE 11011110 Latin capital letter THORN "
ref["337"]=" ß    223 0xDF 11011111 Latin small letter sharp s - ess-zed "
ref["340"]=" à    224 0xE0 11100000 Latin small letter a with grave "
ref["341"]=" á    225 0xE1 11100001 Latin small letter a with acute "
ref["342"]=" â    226 0xE2 11100010 Latin small letter a with circumflex "
ref["343"]=" ã    227 0xE3 11100011 Latin small letter a with tilde "
ref["344"]=" ä    228 0xE4 11100100 Latin small letter a with diaeresis "
ref["345"]=" å    229 0xE5 11100101 Latin small letter a with ring above "
ref["346"]=" æ    230 0xE6 11100110 Latin small letter ae "
ref["347"]=" ç    231 0xE7 11100111 Latin small letter c with cedilla "
ref["350"]=" è    232 0xE8 11101000 Latin small letter e with grave "
ref["351"]=" é    233 0xE9 11101001 Latin small letter e with acute "
ref["352"]=" ê    234 0xEA 11101010 Latin small letter e with circumflex "
ref["353"]=" ë    235 0xEB 11101011 Latin small letter e with diaeresis "
ref["354"]=" ì    236 0xEC 11101100 Latin small letter i with grave "
ref["355"]=" í    237 0xED 11101101 Latin small letter i with acute "
ref["356"]=" î    238 0xEE 11101110 Latin small letter i with circumflex "
ref["357"]=" ï    239 0xEF 11101111 Latin small letter i with diaeresis "
ref["360"]=" ð    240 0xF0 11110000 Latin small letter eth "
ref["361"]=" ñ    241 0xF1 11110001 Latin small letter n with tilde "
ref["362"]=" ò    242 0xF2 11110010 Latin small letter o with grave "
ref["363"]=" ó    243 0xF3 11110011 Latin small letter o with acute "
ref["364"]=" ô    244 0xF4 11110100 Latin small letter o with circumflex "
ref["365"]=" õ    245 0xF5 11110101 Latin small letter o with tilde "
ref["366"]=" ö    246 0xF6 11110110 Latin small letter o with diaeresis "
ref["367"]=" ÷    247 0xF7 11110111 Division sign "
ref["370"]=" ø    248 0xF8 11111000 Latin small letter o with slash "
ref["371"]=" ù    249 0xF9 11111001 Latin small letter u with grave "
ref["372"]=" ú    250 0xFA 11111010 Latin small letter u with acute "
ref["373"]=" û    251 0xFB 11111011 Latin small letter u with circumflex "
ref["374"]=" ü    252 0xFC 11111100 Latin small letter u with diaeresis "
ref["375"]=" ý    253 0xFD 11111101 Latin small letter y with acute "
ref["376"]=" þ    254 0xFE 11111110 Latin small letter thorn "
ref["377"]=" ÿ    255 0xFF 11111111 Latin small letter y with diaeresis "


 # define report header
  var1="OCT"
  var2="FREQ"
  var3=" CHAR DEC HEX  BINARY   DESCRIPTION"
  var4=" ____ ___ ____ ________ ___________"
  
 # print formatted header
 
 printf "%-4s %-14s %s\n", var1, var2, var3
 printf "%-4s %-14s %s\n", "___", "____", var4

} # end of begin


# Main program block

length($1) == 3 {
                 for (i = 1; i <= NF; i++)
                  used[$i]++
                }

## Print the Analysis to Screen

END {
 # for the ref table
 
 for (x in ref)
  # print the table with frequency data if any found
  
  printf "%-4s %-14s %s\n", x, used[x], ref[x]
} # end of end
