�
 TDMMAIN 0j>  TPF0TdmMaindmMainOldCreateOrderOnCreateDataModuleCreate	OnDestroyDataModuleDestroyLeftaTop� Height"Width� TSQLConnectionSQLConnection1ConnectionNameDevart InterBase
DriverNameDevartInterBaseGetDriverFuncgetSQLDriverInterBaseLibraryNamedbexpida.dllLoginPromptParams.StringsDriverName=DevartInterBase;DataBase=localhost:c:\dprojects\meljay\data_prod\meljay.erp	RoleName=User_Name=sysdbaPassword=masterkeySQLDialect=3BlobSize=-1ErrorResourceFile=LocaleCode=0000,DevartInterBase TransIsolation=ReadCommittedWaitOnLocks=TrueCharset=CharLength=1EnableBCD=TrueOptimizedNumerics=TrueLongStrings=TrueUseQuoteChar=FalseFetchAll=FalseDeferredBlobRead=FalseDeferredArrayRead=False 	VendorLibfbclient.dllAfterConnectSQLConnection1AfterConnectLeft� Top  	TSQLQuerySQLQrNextIDMaxBlobSize�Params SQLConnectionSQLConnection1Left<Top  TSQLMonitorSQLMonitor1FileName
sqlmon.txtSQLConnectionSQLConnection1Left� Top�   TPngImageListPngImageList1	PngImagesPngImage.Data
�  �PNG

   IHDR         ��a   *tEXtCreation Time Di 4 Mrz 2003 19:18:05 +0100�zh+   tIME       	s�.   	pHYs    ��~�  [IDATxڭ�mHSQ��ww[�ج�#�(4�-��2��(KF�jH�jH&�MS��0?e�(Bk,�����Y	�λ������rC?hu��y{�?�y�y(�c��8��?�RA �
��Ҋ�e�-���R����
�PK����Q"�(L�0��c�i���� w'��~K�Z���u;��S�� �֐�(Q�(�kZ���ub�9.�A,�Q���O@d�q,6�'Qxz5ǚd�`�"	��^c<O��6��v��~�R4H�j�"-�d.�ɏ���B�1�%�2��B�����6�ќ�}�?��!�KJFIbB���
����fT�� �m�;�h߶�ܝ�7���+����	�K��~x}��^�Gu8a��&t�Z_RSP٭h�����_2@`�~�Ĥ &��ˮ��+QA����u/��Z�p蒍$�1� sc���'`�y����0p+Ŧ��j������I��"�f�3�wlӓ���dS�gԚ�]��$m2�@/1%�LEȽC����P2@^r�x.Zή|��xO�U�'�߾���~J�1bX	˞����bzw����؈U�D "'�q��U�R�70u $�$    IEND�B`�Name	PngImage0
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Di 11 Okt 2005 12:16:46 +0100���   tIME       	s�.   	pHYs    ��~�  MIDATxڥ�O�q��8��h���^��K��aeݔۊ'ل�j������K�ăе�F��."i폐冉e�kH���?���hJ��V���7|?�7��~�g�}L$�f�yS�R}�V���`�!�f���xw( �L��<��b���~�0j��:T*�;N��ʁ�T*5[(26�mVE�;!�3�����g� �HD�����v+I�C�$��br�\��r�S��������W�ZArs�[�F��l����;�|Y�8���t�`Yt:��PTC����\.C�պ��x�M �`� �מ�,�3�6J�k��	 �?�5C�;~���d
���QT�0��	b$�5d2��4�L�{�E�
����<�݉��E�R9%���NO�>X�t�|0�vk�"mn���&n�/�/o��Ow�N?�����ss�J(�H�u��J�Fu��M��T����2��E�]��6G���N�r0�����!4���+M����P����ڍ�B(�c���^츊u'I��3����TJ�t4z���Ǵ����(�VIRvN�М�(���W.�b��~�? Cc* Ԓ    IEND�B`�Name	PngImage1
BackgroundclWindow  Left,TopPBitmap
      TSQLDataSetSQLDataSet1CommandTextW  select 'VER_CLIENT' name, gen_id(VER_CLIENT,0) "VERSION" from rdb$database
union all
select 'VER_SALESREP' name, gen_id(VER_SALESREP,0) "VERSION" from rdb$database
union all
select 'VER_TOWN' name, gen_id(VER_TOWN,0) "VERSION" from rdb$database
union all
select 'VER_COLLECTOR' name, gen_id(VER_COLLECTOR,0) "VERSION" from rdb$database
MaxBlobSize�Params SQLConnectionSQLConnection1Left<TopL  TDataSetProviderDataSetProvider1DataSetSQLDataSet1Left<Topx  TClientDataSetClientDataSet1
Aggregates Params ProviderNameDataSetProvider1Left@Top�   TPngImageListPngImageList2	PngImagesPngImage.Data
�  �PNG

   IHDR         ��a   *tEXtCreation Time Di 4 Mrz 2003 19:18:05 +0100�zh+   tIME       	s�.   	pHYs    ��~�  [IDATxڭ�mHSQ��ww[�ج�#�(4�-��2��(KF�jH�jH&�MS��0?e�(Bk,�����Y	�λ������rC?hu��y{�?�y�y(�c��8��?�RA �
��Ҋ�e�-���R����
�PK����Q"�(L�0��c�i���� w'��~K�Z���u;��S�� �֐�(Q�(�kZ���ub�9.�A,�Q���O@d�q,6�'Qxz5ǚd�`�"	��^c<O��6��v��~�R4H�j�"-�d.�ɏ���B�1�%�2��B�����6�ќ�}�?��!�KJFIbB���
����fT�� �m�;�h߶�ܝ�7���+����	�K��~x}��^�Gu8a��&t�Z_RSP٭h�����_2@`�~�Ĥ &��ˮ��+QA����u/��Z�p蒍$�1� sc���'`�y����0p+Ŧ��j������I��"�f�3�wlӓ���dS�gԚ�]��$m2�@/1%�LEȽC����P2@^r�x.Zή|��xO�U�'�߾���~J�1bX	˞����bzw����؈U�D "'�q��U�R�70u $�$    IEND�B`�NameFolder
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Di 11 Okt 2005 12:16:46 +0100���   tIME       	s�.   	pHYs    ��~�  MIDATxڥ�O�q��8��h���^��K��aeݔۊ'ل�j������K�ăе�F��."i폐冉e�kH���?���hJ��V���7|?�7��~�g�}L$�f�yS�R}�V���`�!�f���xw( �L��<��b���~�0j��:T*�;N��ʁ�T*5[(26�mVE�;!�3�����g� �HD�����v+I�C�$��br�\��r�S��������W�ZArs�[�F��l����;�|Y�8���t�`Yt:��PTC����\.C�պ��x�M �`� �מ�,�3�6J�k��	 �?�5C�;~���d
���QT�0��	b$�5d2��4�L�{�E�
����<�݉��E�R9%���NO�>X�t�|0�vk�"mn���&n�/�/o��Ow�N?�����ss�J(�H�u��J�Fu��M��T����2��E�]��6G���N�r0�����!4���+M����P����ڍ�B(�c���^츊u'I��3����TJ�t4z���Ǵ����(�VIRvN�М�(���W.�b��~�? Cc* Ԓ    IEND�B`�NameEraser
BackgroundclWindow PngImage.Data
C  �PNG

   IHDR         ��a   +tEXtCreation Time Fr 15 Nov 2002 10:08:29 +0100��b�   tIME       	s�.   	pHYs  
�  
�B�4�  �IDATxڥ�[HTA�g�n�������@%-3*��)H��G2Z3J��$�Ӳ�b�fDB�Ŗ^���t���Z����e�=����9M+(!ќ�af��;��͌�6i�L#Ɍ�/!.�0���t���|��'�T��πf��ZR�v��9K����7�'�00棽�w\���4 6$��ܑ���:�'�ȐW���{x�׋�P�ګ�,� ��IΈM�Y_�߉_Sz���-w�:��e4޻�OU7v�!cb9�pM��9���jD�L�x7���\C�tZ����D	�x�f�~�"���Ǽ=�i��G�;�姭�$�Dh���Y��ESv�>�&�Ҿs�7/X�,�ͷ�ZUZ��F	)�&M|�,i��j�B6;�sw�Gl�����k3�;s�Yx���l��� ��DXlȿ
5�- ��ܓ�������Ғ�Urrr�R���hX�T(�p5���ӶW���ͥ����8������&<�0���8�����a��������H,|I�Y3�OjYm�|o[`���!��Ll�Y, b�����U"�.�@�O_�S�e�r��%�gfM�	ˮ��Y���t?��y�O`�o:�\kf!W�����^ч>i�帨��c:L*^�h���.j4�-(��4gy������'� ���P    IEND�B`�NameAdd
BackgroundclWindow PngImage.Data
g  �PNG

   IHDR         ��a   +tEXtCreation Time Fr 15 Nov 2002 10:08:29 +0100��b�   tIME       	s�.   	pHYs  
�  
�B�4�  �IDATxڥ�]h�W�o�7��F�K����`��2D�b��+7���͋^8E��8�I�P�Lp�A�J�y#~ �^���vS�Mc�5]��6IӴI���}ߝD�b~���Á�9�����H��%�71�TU�m�J^��U��tR���l�.)Ù������l���Ż�Rv{`<�1HL�y<RR궚	n�0>��d]�5��=2���^d�(�R�Y��X,<��Y�F��H`T�vW<_�CGy�v7��#KM. ��x��ȿ����6�J�
�+�5�U����찓�{�Ю�(����-Ūg�/`qUa��!���?�$G���z{ϒ���Q�CX��c�)�ׅu�km=���;eFf�A���k������"�w�{A�����oc�vc�Z0߹���0�Ps:�qx!�<�����b�fݪ�����M��;�+6
��H�l@�$m�'S�'N���K�����+�?�m=��i+�Ʉ2C�\��p(�D���p�-�B�h���TV=�/o����2t�������pڂ��E���(��~d=�DBI���"��J�U��O]�&�=�#�O�3��*��~
��U.�$��p�)���EX앑�xs�Թ��U���:�E��y�"ːw�����5+?��7.s��������B�LF�Bv<Cԩ�������$�9/jg%3˴��<�T�.a�ί�����_a�$ ��Q�    IEND�B`�NameDelete
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Mo 15 Aug 2005 11:31:14 +0100��z   tIME       	s�.   	pHYs  
�  
�B�4�  ,IDATxڥ��kA��nҼ�|�"bQ���-��%��Pۤ�D����
��Pl�EI����'� x�xh�؋��
6i���9��m��Mg���c�3�����&�7c���-�}����/�F,{���_Կ�KZ�z��5 ���JN�}�`�7� l=����z���{���� e�����߻ƣ���`���A��P��l�'�|O_LY�2��F��607l?2��3Pχ���:P�8 T�=h��u�mC�	��\<�7v��V��g�:�P�XR����&)�"V����~�������
Cmj�J�'gF)1���x�x��6	�O3�5�a��}P���W!����U�RF)9I�ΓP�y��8�qD����E�G1Pܺ���n�ò��g�_ˌGc�����[��<Nr4���h��0c�	��#��7bc�@
!���d���+q��`��.=᥹��xCV��B�1�?�!9lڻ�)�߆����f�������2H�+p��0��X.�PYHs]�,l���
����, ��>�    IEND�B`�NameDocument_plain_new
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Mo 17 Feb 2003 18:18:50 +0100��   tIME       	s�.   	pHYs  
�  
�B�4�  �IDATxڥ�AHTA��o�e���OA�v����IrnDǍ�KuI����[t�ԡC��Q#��CY�.TDI+D�k�dw՝�y��{�_T���������|�ͧ�?���4ꪘTxe�x�Y5>'�������h�L�j��/�i�N���Ù�kg��/=_��o�� ��."P��b�pa-`((�9{��ɝ�����}�eY�m���9B`.�X0�b�j�9k�z�ܑmj��2��).Z��	��Ȗ\<��a�V,�P3�0���.)�R�*���"�)�A-	�{҅>��cG��x�V�Jdoȗ�)�)���f
��Q� %GA>�������O��z#����u�"��;`\&x0ǃ����2;C�����M<�н��K"���-3�LNð��@x��L�9������S�l��r�k��x<����a�&�|�@0��j�%>��ȟ��\�IKOWU��W;��:�BSU��ߎvUXQ��ծ��7����G    IEND�B`�Name	PngImage5
BackgroundclWindow PngImage.Data
k  �PNG

   IHDR         ��a   +tEXtCreation Time Mo 17 Feb 2003 18:18:50 +0100��   tIME       	s�.   	pHYs  
�  
�B�4�  �IDATx�cd�0Ta�����o�`M:}��/q�%ro�2�����/_>��JԆa����.=�)+̔wچ�ﯾ�s`�)t	����>��	�3EXY�XY��̵�����0�1�;x�뉧R���b ��Gr�	�ӷ�8��9�8�q�11|�����?��0'ö��~"��ϵ� ް-?�lu����������������y8X�@���AF��a����}V���)9n O��o
��_~�k�ifce�bgb�fge��be�fg`����������-1n wؖ�J*\@}�@۸9 �s�21p�m�``������?��7�`���5\��c�gd33�����``a������k�<����0[���(��������޾��gϰP�*I�@$�Ї���}z�WӚa��c�k����Yd=�)��&O83�faX���4a  ڔ�9��b    IEND�B`�Name	PngImage6
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Mo 17 Feb 2003 18:18:50 +0100��   tIME       	s�.   	pHYs  
�  
�B�4�  +IDATxڥ�MhQ��$��l��khL�1mc�*�R���*x�7)�'O�؃Ѣ�w�A�?.�'Q�E+�)�b�4�֚j��f�]g�kS�`v����͛%��"�3a\Ѱ�(0�O�	�,f��;���%c��"͠ȩ^�k�W�1Z�^����8`v�)n�����\T�+��?pl��έ���^^pX��G�H�4rO����8B)����|���~���B���n0�A��C}�N��;�&�ҍ����?(�m�)�* 6�Z�prj���x�G��h]��6�����t`���S�9�@���cE|,\�����f�^%����W��nڑ��,>�I��3��3�20����=��ZV ����m֌�dU,o������B]D��3Fd~_�&�>Z�ϡ�;q�	��i=�!����`@4 ����'�v-��xS��G0����+�_�]H&�X>I����/��s>��k �6���R�d�`�����D�A�.8�p

\\�e��C���+4�����n��Ƙ�!rx8
�c��.Po� ::�ˋ�    IEND�B`�Name	PngImage7
BackgroundclWindow PngImage.Data
n  �PNG

   IHDR         ��a   +tEXtCreation Time Do 14 Nov 2002 23:59:24 +0100�]�x   tIME       	s�.   	pHYs    ��~�  �IDATxڥ�kHSa����y���m�����eF�$�]\%Af�
�,�H��Nt��T����6���2�"/y�[E�hu:��t:wt��t4J0�����}�������Sį����{```�պ(�}}|�h&������JS�W�N���GG+��ok�����⒦M�F��9}����6/�v���� /-�}�Z}`S��rTY�g/&����e�\���֊��������Mʌ;�а�S�1dӓz�Z^�t��1!z�����h�Zf���v����wa���VA�p��-� �3����5���1�Fe��Jy��|�%*�ߟ��0��M+q3'|�h^ƈ��"�0�(	�������l�LW�r��׭r�\077>����1)*8��g�4��Ӡ�BLV��ә�8�%n��i�i�U@uu�U�P�V+�AI�}�'d���AQ,v~�<0����}��6bxtx����}��b���r5�L
��ho�Y���]�@�,D����
88`��`���j�O ����X��z||ccc���~������_�sQv4i�v)6�ł��	���_���$H�\_kEE�z=,Nx�q�� פ�`j���I���]��XVV�YH�J��O�L���J���
�k*��E�y�ܧ>��W���K`4/���$�����r�)�ʡ�{�Z��lYr��WciI�ݬ���j9 ��Ѡ    IEND�B`�Name	PngImage8
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Di 18 Feb 2003 22:29:57 +0100���   tIME       	s�.   	pHYs  
�  
�B�4�  $IDATxڥ�_HSaƟmG�vt��E�WQ�]���.�2�0e�_-�n���H�.(B��� (�AA� $�$�!¨��X1��Զ�����t�P"�z���n���|��~&�g�n��;�l]{������Ƿ��Ty��5�F�n���@@�0����� �==�]� �9`�G���XVs^Ļ���5��dW�n�'9$T �3!(�u)"²���² �^��~���e�$S���B�,�Q��UȖk�P��{��@ž'�����Q"�0I���Z,@YP^�R@(4ZՊ���E v�3�|����4�������`��C������*��_ˋ*&$�d��|2LA�w�v8�ރۊ���K���!�z�h��x���4 �@�xQ?Rh铽>���� �y�*� �+�E�b��wwd�4���@���N7�"L�Rê�j4-�#�l.?�SC���l|<1k�8��6�G��.���%i������+ ����%��������R+Ze4��v֬Q8������J�?����<pg    IEND�B`�Name	PngImage9
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time Mo 17 Feb 2003 19:07:03 +0100���2   tIME       	s�.   	pHYs  
�  
�B�4�  �IDATxڵ��kQǿ/�$ZK�RAh�hDі��A���B/�CAW�P/��?@E��"���ѪJUP�m\�ԭ6��ՔD�&]7�d�����<ht�8���3f�� v�v%��.���H��o�O���v��)!oy�.�aNN�"� �N$e��8F����`��Kj�M����8��? �z
���� �s�gG�>��9�.2o�pG���~u)J%�qG��.�c�! �U��t�|���X���W�3�'��m0)͑�M���
���Z����n��{���<���OQ���H/�5��\�Q΍^<�9Q'L����@�/ѓ�$�B�@�uu�+*��l����ù�hcN����Z�)���}��O�u���k;qW�Ֆ8`��D?��U76��׷X����K6o��.\W���ā|w"Vyr�'�1�qC��lu�n\[�;��q�T;W�o�PX��WW��S�ߟ���S ��J�r��E�7�c��E��    IEND�B`�Name
PngImage10
BackgroundclWindow PngImage.Data
L  �PNG

   IHDR         ��a   *tEXtCreation Time Mo 3 Mrz 2003 22:42:10 +0100�&U{   tIME       	s�.   	pHYs  
�  
�B�4�  �IDATxڽ��+Caǿg猼&/�\(J(k������RJ�BR�p�?�(�Jy��[3Z^ʕEK)c�4f�1;{���p�������>�����0��a�W0�b�`UO�$�{0���K�g���h�������3�:������-�F����5P�Y�/��qA�iV�T�<��&���d3�Z�j�n7!�\���(%m���.(�δԥ��DQ`w����,��9b�3���=a1�J�&�����"/��_�
��1��a5����HZzW�B,�'�����땹9��@U)n��p���{�-�(��#�G:5x�����Ƃd�Qd�������$�����{��txa�)24�����r׼ GXҭ����4��(�i�u��!9LI�0�x'��(��I�Q�)#Z�s�U���_^�u�4�"�    IEND�B`�Name
PngImage11
BackgroundclWindow PngImage.Data
g  �PNG

   IHDR         ��a   +tEXtCreation Time Mo 17 Feb 2003 18:18:50 +0100��   tIME       	s�.   	pHYs  
�  
�B�4�  �IDATxڥ��K�Q��of�B*cM9����h(�h!��`�H��$� P��G��D��JQ��IPQQ��'�f`Tg����w��u�B˟x��\>�{��3���l��C0Î�ⷧ�R����(9g��,hm�q���o]͋M�>.�Y���3�M���'q����@�u���>�t	b���[8��m�AI��@G�
!Q������H�]
jpHu���]��ɼ��s��G����Ǉ^ݬ��)�k`0]�)D
�F����"ݾT��_�)h�#9R���@�
�9��p�wBu�@)V��H� ,�6��b������~�O+���R��:Y��#�����c�ʗ��S�1!�8G�G �O������nƗ��끟H�����d}��+j0�� 3�n(x:-oTW �U�j��PƗ6s�v�c�F�UR]�<s��d�yt�p�83p m�_<tK    IEND�B`�Name
PngImage12
BackgroundclWindow PngImage.Data
g  �PNG

   IHDR         ��a   +tEXtCreation Time Mo 17 Feb 2003 14:36:00 +0100�r��   tIME       	s�.   	pHYs    ��~�  �IDATxڥ�OHa��睝mgXw��R4�{� �l�	{H�Cv�KA݂(�P������%-	Rtԋe�V� 
�?�ͪ�˦;�3���o�}t����|��%����3�@
��;q�����1���@���+��\$�7`�	�g�}��t�*��-<��4�S�N�;������m�Ӆ�
V���-�a�N3QJ��� 4�x?V�rRO�\4��?R�%7Y���ލ�ߵ׭)#�9�A����l��(�9"ץ)��y.c�njx�Q�#Q���e��U��hqS��*}�p3��J��t�5��.Ri�q�=��g�.s���+�H�S�Z���e2�Fg��S<9��$��9/R'�sb�����H=M�^!D/`�uk�n�ԅɣrC��x�:�9ce;��lO��+�ʏY)Z���g�3���Ċ�#n��M#��� ���ur��;�q� ��Z�g    IEND�B`�Name
PngImage13
BackgroundclWindow PngImage.Data
�  �PNG

   IHDR         ��a   +tEXtCreation Time So 17 Nov 2002 19:17:46 +0100A���   tIME       	s�.   	pHYs  
�  
�B�4�   IDATxڥ�[HQ������δ���f��v�����[�CQAe���B!҅�J0z�t� z)� ��ED�b�E��Y�[k����;;3����A������������T��8�Ճ'6K��U.�Mk�i�4<���L<�G��tS������xԚi+y�-����Ũ.]���O��aB�L&������xq�AN�~�,0Ի�$ ��bz{'���GMi��l"�X ]�-�T�%�������h�/Dn'�^���ݨ+�C��u��҇`0J�U�2p:��`�r���9y��i�$�Q��i]=��3G�P՘�*c�D�2Je�H�ȷp�χ�nD��'ry�����6���SO?~ZĚB�(2r�3������!������A�"�z�
hF�Pn �&�@�k�I7���rp.B��>��-l�p�L�4G	^I����H*S
2��L����x�$@���ңC0�����'x�M�ȃ������� �)��ަ�`���V��G�3����#<<����d^�4��bZ�KW���D�L8+�XE4)�h��!�koM�.�PU����G�6f�߄{�2.��J�s�������1DM}���N�{�:qx}2���%ye�����=�~�9����`+z�8�/��H��{��^(t�v��&L���b���H���Ei8W�H�>-�'M]5u<
������W��h�{��<P(A���);�Q�\�%"Q���*ϒ��� ��O 0�dM    IEND�B`�Name
PngImage14
BackgroundclWindow PngImage.Data
6  �PNG

   IHDR         ��a   +tEXtCreation Time Di 30 Sep 2003 23:54:26 +0100e���   tIME       	s�.   	pHYs    ��~�  �IDATxڥ�KH�Q���8�����)��d����^�44���D.jQ�	�ڴ��"�Q#[D���͌�pzQd2�<j�y|3�c�M%��"�p�r�=����s%�sI�/����p�l�:ao@�A�q��=�̛���(W��ӱ([�'�k�3�U�'�9����uZ�,�1g����p{p��1�Ⱦ�n>�r}f���vV
�o�;��u��n�}	�gp����#II:�
=��.�'�}���[�[�g�v3���0D���K ��bCM�9��K�(O���jJ%�^t9DW�KW�k��4��hh�:�~)B	%*n�n��ʼ����s��;��/�ۜ_�	�(%�����W����m �	N�������Y�!$��Bl�3@kǐ�(�Bp4@��䦟��[�f�Da(,�Tw�@L��]���ۛ��q� ZaS^U^SA�L���h�P6j*�"�?c1YV�<v�C����4�ʅ�Y-s��
5�������!�xv�iV��
Ѵx.����Y���8�Q����]j���g0Jw��CP��]e%)�9&�5T]��S砺{܈nù�UY��$��y���r��"����3����y�`��Q"��84��MȘb6<�MR�Ү�6B��	݂��`N���z����~. 0��    IEND�B`�Name
PngImage15
BackgroundclWindow  Left(TopBitmap
       