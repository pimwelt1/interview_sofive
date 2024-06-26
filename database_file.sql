--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metadata (
    title text NOT NULL,
    duration double precision NOT NULL
);


ALTER TABLE public.metadata OWNER TO postgres;

--
-- Name: words; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.words (
    word_id integer NOT NULL,
    start_time integer NOT NULL,
    end_time integer NOT NULL,
    word text NOT NULL,
    title text NOT NULL
);


ALTER TABLE public.words OWNER TO postgres;

--
-- Name: words_word_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.words_word_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.words_word_id_seq OWNER TO postgres;

--
-- Name: words_word_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.words_word_id_seq OWNED BY public.words.word_id;


--
-- Data for Name: metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.metadata (title, duration) FROM stdin;
sound of silence	245
Can you fell the love tonight	246
The man who sold the world	217
\.


--
-- Data for Name: words; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.words (word_id, start_time, end_time, word, title) FROM stdin;
0	20160	20568	hello	sound of silence
1	20598	21358	darkness	sound of silence
2	21446	21718	my	sound of silence
3	21766	22046	old	sound of silence
4	22110	22714	friend	sound of silence
5	24934	25318	i	sound of silence
6	25366	25670	come	sound of silence
7	25742	25974	to	sound of silence
8	26014	26286	talk	sound of silence
9	26350	26622	with	sound of silence
10	26678	26966	you	sound of silence
11	27030	27634	again	sound of silence
12	30214	30886	because	sound of silence
13	31030	31310	the	sound of silence
14	31342	31902	visions	sound of silence
15	31998	32326	of	sound of silence
16	32390	33046	me	sound of silence
17	33230	34314	creeping	sound of silence
18	35734	36166	left	sound of silence
19	36230	36478	its	sound of silence
20	36526	37014	seas	sound of silence
21	37094	37526	while	sound of silence
22	37630	37780	i	sound of silence
23	37782	38346	was	sound of silence
24	38520	39554	sleeping	sound of silence
25	41014	41446	and	sound of silence
26	41510	41950	the	sound of silence
27	42062	42874	shine	sound of silence
28	43614	44046	that	sound of silence
29	44110	44358	was	sound of silence
30	44406	45274	planted	sound of silence
31	48974	49646	still	sound of silence
32	49790	50874	remains	sound of silence
33	52614	53166	within	sound of silence
34	53270	53606	the	sound of silence
35	53670	54394	sound	sound of silence
36	55794	56202	of	sound of silence
37	56258	57254	silence	sound of silence
38	59114	59546	in	sound of silence
39	59610	60106	restless	sound of silence
40	60170	60634	dreams	sound of silence
41	60674	60898	i	sound of silence
42	60946	61370	walked	sound of silence
43	61402	62134	alone	sound of silence
44	64714	65298	narrow	sound of silence
45	65346	65786	streets	sound of silence
46	65810	66042	of	sound of silence
47	66098	67374	cobblestone	sound of silence
48	69994	70498	neath	sound of silence
49	70546	70802	a	sound of silence
50	70858	71210	hill	sound of silence
51	71282	71586	of	sound of silence
52	71650	71898	our	sound of silence
53	71946	72770	race	sound of silence
54	72842	73194	street	sound of silence
55	73274	74054	lamp	sound of silence
56	75074	75482	i	sound of silence
57	75538	75890	turned	sound of silence
58	75922	76162	my	sound of silence
59	76218	76818	color	sound of silence
60	76906	77202	to	sound of silence
61	77258	77546	the	sound of silence
62	77610	78554	golden	sound of silence
63	78634	79254	dam	sound of silence
64	80834	81266	when	sound of silence
65	81330	81698	my	sound of silence
66	81786	82258	eyes	sound of silence
67	82346	82594	were	sound of silence
68	82634	83506	stabbed	sound of silence
69	83650	84026	by	sound of silence
70	84090	84338	the	sound of silence
71	84386	84994	flash	sound of silence
72	85114	85774	of	sound of silence
73	86714	87454	light	sound of silence
74	88744	89128	that	sound of silence
75	89176	89528	split	sound of silence
76	89576	89880	the	sound of silence
77	89952	90564	night	sound of silence
78	92704	93088	and	sound of silence
79	93136	93488	touch	sound of silence
80	93536	93792	the	sound of silence
81	93848	94604	sound	sound of silence
82	96064	96520	of	sound of silence
83	96592	97564	silence	sound of silence
84	99504	99912	and	sound of silence
85	99968	100160	in	sound of silence
86	100192	100504	the	sound of silence
87	100584	101176	naked	sound of silence
88	101240	101656	light	sound of silence
89	101760	102120	i	sound of silence
90	102192	102804	saw	sound of silence
91	104584	105544	10000	sound of silence
92	105664	106208	people	sound of silence
93	106336	106744	made	sound of silence
94	106824	107040	it	sound of silence
95	107072	107644	more	sound of silence
96	110104	110728	people	sound of silence
97	110856	111584	talking	sound of silence
98	111664	112284	without	sound of silence
99	112744	113564	speaking	sound of silence
100	115304	115928	people	sound of silence
101	116056	116680	hearing	sound of silence
102	116752	117364	without	sound of silence
103	117824	118208	the	sound of silence
104	118256	118844	same	sound of silence
105	120454	121078	people	sound of silence
106	121206	121894	writing	sound of silence
107	122054	123874	songs	sound of silence
108	124254	124830	their	sound of silence
109	124942	126166	voices	sound of silence
110	126350	127030	never	sound of silence
111	127182	127874	share	sound of silence
112	129414	129918	no	sound of silence
113	130006	130470	one	sound of silence
114	130582	131314	dare	sound of silence
115	132974	133830	disturb	sound of silence
116	133902	134134	the	sound of silence
117	134174	134874	sound	sound of silence
118	136054	136486	of	sound of silence
119	136550	137594	silence	sound of silence
120	139734	140350	fools	sound of silence
121	140382	140574	that	sound of silence
122	140614	141030	i	sound of silence
123	141142	141438	do	sound of silence
124	141486	141886	not	sound of silence
125	141990	142634	know	sound of silence
126	144694	145574	silence	sound of silence
127	145654	145918	like	sound of silence
128	145966	146174	a	sound of silence
129	146214	146766	cancer	sound of silence
130	146830	147794	grows	sound of silence
131	149814	150270	hear	sound of silence
132	150342	150622	my	sound of silence
133	150678	151434	words	sound of silence
134	154564	155188	take	sound of silence
135	155316	155700	my	sound of silence
136	155772	156196	arms	sound of silence
137	156260	156484	that	sound of silence
138	156524	156700	i	sound of silence
139	156732	157092	might	sound of silence
140	157188	157540	reach	sound of silence
141	157612	157892	out	sound of silence
142	157948	158188	to	sound of silence
143	158236	158824	you	sound of silence
144	159884	160340	but	sound of silence
145	160412	160884	my	sound of silence
146	161004	161864	words	sound of silence
147	162484	163012	like	sound of silence
148	163108	164076	silent	sound of silence
149	164180	165428	raindrops	sound of silence
150	165476	166064	fail	sound of silence
151	170364	170700	and	sound of silence
152	170732	171464	echo	sound of silence
153	174844	175132	in	sound of silence
154	175148	175276	the	sound of silence
155	175300	175748	wells	sound of silence
156	175796	176004	of	sound of silence
157	176044	176984	silence	sound of silence
158	179224	179680	and	sound of silence
159	179752	179984	the	sound of silence
160	180024	180536	people	sound of silence
161	180680	181304	bowed	sound of silence
162	181344	181616	and	sound of silence
163	181680	182604	prayed	sound of silence
164	184464	184872	to	sound of silence
165	184928	185216	the	sound of silence
166	185280	185856	neon	sound of silence
167	185960	186352	god	sound of silence
168	186408	186696	they	sound of silence
169	186760	187364	made	sound of silence
170	189664	190072	and	sound of silence
171	190128	190368	the	sound of silence
172	190416	190936	sign	sound of silence
173	191080	191768	flashed	sound of silence
174	191816	192336	its	sound of silence
175	192480	193364	warning	sound of silence
176	194984	195368	in	sound of silence
177	195416	195600	the	sound of silence
178	195632	196176	words	sound of silence
179	196280	196496	that	sound of silence
180	196520	196752	it	sound of silence
181	196808	197480	was	sound of silence
182	197672	198120	for	sound of silence
183	198192	198804	name	sound of silence
184	200264	200648	and	sound of silence
185	200696	200952	the	sound of silence
186	201008	201512	sign	sound of silence
187	201648	202040	said	sound of silence
188	202112	202440	the	sound of silence
189	202512	203096	words	sound of silence
190	203200	203488	of	sound of silence
191	203536	203792	the	sound of silence
192	203848	204448	prophets	sound of silence
193	204536	205048	are	sound of silence
194	205176	205624	written	sound of silence
195	205664	206080	on	sound of silence
196	206192	206488	the	sound of silence
197	206536	207356	subway	sound of silence
198	207520	208904	walls	sound of silence
199	209484	209916	and	sound of silence
200	209980	210836	timid	sound of silence
201	210980	212584	pause	sound of silence
202	213204	213612	and	sound of silence
203	213668	214384	whisper	sound of silence
204	216004	216316	in	sound of silence
205	216340	216548	the	sound of silence
206	216596	217344	sound	sound of silence
207	220404	221028	of	sound of silence
208	221156	222384	silence	sound of silence
209	238954	239194	it	sound of silence
0	16920	17392	theres	Can you fell the love tonight
1	17392	17552	a	Can you fell the love tonight
2	17552	18184	calm	Can you fell the love tonight
3	18294	19314	surrender	Can you fell the love tonight
4	20694	21198	to	Can you fell the love tonight
5	21286	21558	the	Can you fell the love tonight
6	21606	21998	rush	Can you fell the love tonight
7	22086	22478	of	Can you fell the love tonight
8	22566	23194	day	Can you fell the love tonight
9	24734	25238	when	Can you fell the love tonight
10	25326	25598	the	Can you fell the love tonight
11	25646	26206	heat	Can you fell the love tonight
12	26310	26550	of	Can you fell the love tonight
13	26582	26798	a	Can you fell the love tonight
14	26846	27422	rolling	Can you fell the love tonight
15	27518	28154	wind	Can you fell the love tonight
16	28594	29290	cant	Can you fell the love tonight
17	29322	29562	be	Can you fell the love tonight
18	29618	30458	turned	Can you fell the love tonight
19	30506	31094	away	Can you fell the love tonight
20	32794	33298	an	Can you fell the love tonight
21	33386	34454	enchanted	Can you fell the love tonight
22	34754	35694	moment	Can you fell the love tonight
23	36754	37234	and	Can you fell the love tonight
24	37314	37530	it	Can you fell the love tonight
25	37562	38082	sees	Can you fell the love tonight
26	38138	38450	me	Can you fell the love tonight
27	38522	39134	through	Can you fell the love tonight
28	40794	41330	its	Can you fell the love tonight
29	41402	41874	enough	Can you fell the love tonight
30	41994	42322	for	Can you fell the love tonight
31	42378	42762	this	Can you fell the love tonight
32	42858	43650	restless	Can you fell the love tonight
33	43802	44682	warrior	Can you fell the love tonight
34	44818	45258	just	Can you fell the love tonight
35	45346	45618	to	Can you fell the love tonight
36	45666	46162	be	Can you fell the love tonight
37	46298	46642	with	Can you fell the love tonight
38	46698	47294	you	Can you fell the love tonight
39	48474	48858	and	Can you fell the love tonight
40	48906	49494	can	Can you fell the love tonight
41	50114	50570	you	Can you fell the love tonight
42	50642	51254	feel	Can you fell the love tonight
43	51634	52090	the	Can you fell the love tonight
44	52162	52774	love	Can you fell the love tonight
45	53514	54534	tonight	Can you fell the love tonight
46	57314	57626	it	Can you fell the love tonight
47	57650	57882	is	Can you fell the love tonight
48	57938	58534	where	Can you fell the love tonight
49	59034	59610	we	Can you fell the love tonight
50	59722	60374	are	Can you fell the love tonight
51	64784	65240	its	Can you fell the love tonight
52	65272	65844	enough	Can you fell the love tonight
53	66904	67240	for	Can you fell the love tonight
54	67272	67632	this	Can you fell the love tonight
55	67728	68520	wide	Can you fell the love tonight
56	68672	69440	eyed	Can you fell the love tonight
57	69592	70644	wanderer	Can you fell the love tonight
58	71424	72240	that	Can you fell the love tonight
59	72432	73168	we	Can you fell the love tonight
60	73336	74096	got	Can you fell the love tonight
61	74280	74648	this	Can you fell the love tonight
62	74696	75284	far	Can you fell the love tonight
63	78664	79024	and	Can you fell the love tonight
64	79064	79644	can	Can you fell the love tonight
65	80344	80752	you	Can you fell the love tonight
66	80808	81404	feel	Can you fell the love tonight
67	81824	82232	the	Can you fell the love tonight
68	82288	82884	love	Can you fell the love tonight
69	83744	84764	tonight	Can you fell the love tonight
70	85664	86804	tonight	Can you fell the love tonight
71	87504	87816	i	Can you fell the love tonight
72	87840	88120	was	Can you fell the love tonight
73	88192	88804	led	Can you fell the love tonight
74	89104	89844	to	Can you fell the love tonight
75	90144	90884	rest	Can you fell the love tonight
76	95054	95454	its	Can you fell the love tonight
77	95494	96074	enough	Can you fell the love tonight
78	97134	97518	to	Can you fell the love tonight
79	97566	97870	make	Can you fell the love tonight
80	97942	98726	kings	Can you fell the love tonight
81	98910	99614	and	Can you fell the love tonight
82	99774	101478	vagabonds	Can you fell the love tonight
83	101646	102454	leave	Can you fell the love tonight
84	102614	103314	the	Can you fell the love tonight
85	124604	125180	theres	Can you fell the love tonight
86	125212	125380	a	Can you fell the love tonight
87	125412	125796	time	Can you fell the love tonight
88	125900	126476	for	Can you fell the love tonight
89	126620	127304	everyone	Can you fell the love tonight
90	128604	129084	if	Can you fell the love tonight
91	129164	129452	they	Can you fell the love tonight
92	129508	130132	only	Can you fell the love tonight
93	130308	131224	learn	Can you fell the love tonight
94	132564	133044	that	Can you fell the love tonight
95	133124	133388	the	Can you fell the love tonight
96	133436	134268	twisting	Can you fell the love tonight
97	134356	136144	kaleidoscope	Can you fell the love tonight
98	136484	137196	moves	Can you fell the love tonight
99	137220	137428	us	Can you fell the love tonight
100	137476	137876	all	Can you fell the love tonight
101	137980	138316	in	Can you fell the love tonight
102	138380	138984	turn	Can you fell the love tonight
103	140604	141180	theres	Can you fell the love tonight
104	141212	141404	a	Can you fell the love tonight
105	141444	141940	rhyme	Can you fell the love tonight
106	142012	142364	and	Can you fell the love tonight
107	142444	143064	reason	Can you fell the love tonight
108	144524	145052	to	Can you fell the love tonight
109	145148	145404	the	Can you fell the love tonight
110	145444	145892	wild	Can you fell the love tonight
111	145988	147224	outdoors	Can you fell the love tonight
112	148564	149092	when	Can you fell the love tonight
113	149188	149468	the	Can you fell the love tonight
114	149516	149868	heart	Can you fell the love tonight
115	149956	150180	of	Can you fell the love tonight
116	150212	150476	the	Can you fell the love tonight
117	150540	150932	star	Can you fell the love tonight
118	151028	151604	crossed	Can you fell the love tonight
119	151644	152492	voyager	Can you fell the love tonight
120	152628	153140	beats	Can you fell the love tonight
121	153212	153444	in	Can you fell the love tonight
122	153484	153900	time	Can you fell the love tonight
123	154012	154332	with	Can you fell the love tonight
124	154388	155304	yours	Can you fell the love tonight
125	158074	158530	and	Can you fell the love tonight
126	158602	159214	can	Can you fell the love tonight
127	159954	160386	you	Can you fell the love tonight
128	160450	161054	feel	Can you fell the love tonight
129	161434	161842	the	Can you fell the love tonight
130	161898	162494	love	Can you fell the love tonight
131	163314	164334	tonight	Can you fell the love tonight
132	167114	167426	it	Can you fell the love tonight
133	167450	167682	is	Can you fell the love tonight
134	167738	168334	where	Can you fell the love tonight
135	168794	169298	we	Can you fell the love tonight
136	169386	170014	are	Can you fell the love tonight
137	174634	175050	its	Can you fell the love tonight
138	175082	175654	enough	Can you fell the love tonight
139	176674	177058	for	Can you fell the love tonight
140	177106	177434	this	Can you fell the love tonight
141	177514	178298	wide	Can you fell the love tonight
142	178466	179186	eyed	Can you fell the love tonight
143	179330	180134	wonder	Can you fell the love tonight
144	181194	182010	that	Can you fell the love tonight
145	182202	182938	we	Can you fell the love tonight
146	183106	183818	got	Can you fell the love tonight
147	183986	184386	this	Can you fell the love tonight
148	184450	185054	far	Can you fell the love tonight
149	188424	188736	and	Can you fell the love tonight
150	188760	189324	can	Can you fell the love tonight
151	189984	190392	you	Can you fell the love tonight
152	190448	191044	feel	Can you fell the love tonight
153	191504	191936	the	Can you fell the love tonight
154	192000	192604	love	Can you fell the love tonight
155	193304	194324	tonight	Can you fell the love tonight
156	197024	197336	i	Can you fell the love tonight
157	197360	197640	was	Can you fell the love tonight
158	197712	198400	led	Can you fell the love tonight
159	198592	199400	to	Can you fell the love tonight
160	199592	200324	rest	Can you fell the love tonight
161	204464	204880	its	Can you fell the love tonight
162	204912	205484	enough	Can you fell the love tonight
163	206544	206880	to	Can you fell the love tonight
164	206912	207248	make	Can you fell the love tonight
165	207336	208072	kings	Can you fell the love tonight
166	208248	208992	and	Can you fell the love tonight
167	209168	210800	vagabonds	Can you fell the love tonight
168	210912	211564	believe	Can you fell the love tonight
169	211904	212644	the	Can you fell the love tonight
170	213744	214964	revenge	Can you fell the love tonight
171	219364	219804	its	Can you fell the love tonight
172	219844	220424	enough	Can you fell the love tonight
173	221444	221804	to	Can you fell the love tonight
174	221844	222140	make	Can you fell the love tonight
175	222212	222972	kings	Can you fell the love tonight
176	223148	223868	and	Can you fell the love tonight
177	224036	225224	vagabond	Can you fell the love tonight
178	225764	226504	believe	Can you fell the love tonight
179	226924	227164	the	Can you fell the love tonight
0	15880	16184	we	The man who sold the world
1	16206	16966	passed	The man who sold the world
2	17030	17806	upon	The man who sold the world
3	17910	18150	the	The man who sold the world
4	18182	18914	stair	The man who sold the world
5	20454	21390	spoken	The man who sold the world
6	21462	22030	walls	The man who sold the world
7	22062	22254	and	The man who sold the world
8	22294	22874	well	The man who sold the world
9	24294	25286	although	The man who sold the world
10	25390	25822	i	The man who sold the world
11	25918	26582	wasnt	The man who sold the world
12	26638	27234	there	The man who sold the world
13	28814	29414	said	The man who sold the world
14	29534	29838	i	The man who sold the world
15	29886	30262	was	The man who sold the world
16	30358	30566	a	The man who sold the world
17	30590	31394	strand	The man who sold the world
18	32604	33164	words	The man who sold the world
19	33244	33700	came	The man who sold the world
20	33812	34228	as	The man who sold the world
21	34316	34708	a	The man who sold the world
22	34796	35744	surprise	The man who sold the world
23	36884	37340	i	The man who sold the world
24	37412	38084	spoke	The man who sold the world
25	38164	38836	into	The man who sold the world
26	39020	39508	his	The man who sold the world
27	39596	40132	eyes	The man who sold the world
28	40228	40556	i	The man who sold the world
29	40620	41084	found	The man who sold the world
30	41204	41652	you	The man who sold the world
31	41748	42292	died	The man who sold the world
32	42388	43424	alone	The man who sold the world
33	44284	45024	long	The man who sold the world
34	45924	46452	time	The man who sold the world
35	46548	47184	ago	The man who sold the world
36	50524	50940	oh	The man who sold the world
37	50972	51544	no	The man who sold the world
38	52604	53036	not	The man who sold the world
39	53100	53704	me	The man who sold the world
40	54724	55276	we	The man who sold the world
41	55380	56100	never	The man who sold the world
42	56292	56812	lost	The man who sold the world
43	56908	57544	control	The man who sold the world
44	58804	59188	of	The man who sold the world
45	59236	59824	face	The man who sold the world
46	60844	61228	to	The man who sold the world
47	61276	61864	face	The man who sold the world
48	79874	80378	i	The man who sold the world
49	80466	81034	laughed	The man who sold the world
50	81074	81418	and	The man who sold the world
51	81506	82002	shook	The man who sold the world
52	82098	82378	his	The man who sold the world
53	82426	83014	hand	The man who sold the world
54	84434	84818	and	The man who sold the world
55	84866	85242	made	The man who sold the world
56	85338	85666	my	The man who sold the world
57	85730	86050	way	The man who sold the world
58	86122	86402	back	The man who sold the world
59	86458	87054	home	The man who sold the world
60	88554	89034	i	The man who sold the world
61	89114	89650	searched	The man who sold the world
62	89682	90018	for	The man who sold the world
63	90106	90890	falling	The man who sold the world
64	90962	91574	land	The man who sold the world
65	93234	93762	years	The man who sold the world
66	93858	94138	and	The man who sold the world
67	94186	94562	years	The man who sold the world
68	94658	94890	i	The man who sold the world
69	94922	95614	wrong	The man who sold the world
70	96984	97464	i	The man who sold the world
71	97544	98168	gazed	The man who sold the world
72	98216	98592	up	The man who sold the world
73	98688	100044	aside	The man who sold the world
74	101144	101648	we	The man who sold the world
75	101736	102400	marked	The man who sold the world
76	102432	102792	a	The man who sold the world
77	102888	103524	million	The man who sold the world
78	103824	104448	years	The man who sold the world
79	104576	104936	i	The man who sold the world
80	105000	105464	must	The man who sold the world
81	105584	106008	have	The man who sold the world
82	106096	106600	died	The man who sold the world
83	106712	107724	alone	The man who sold the world
84	108704	109184	a	The man who sold the world
85	109264	109696	long	The man who sold the world
86	109800	110256	long	The man who sold the world
87	110360	110768	time	The man who sold the world
88	110856	111484	ago	The man who sold the world
89	114864	115272	who	The man who sold the world
90	115328	116204	knows	The man who sold the world
91	116944	117352	not	The man who sold the world
92	117408	118004	me	The man who sold the world
93	119104	119584	i	The man who sold the world
94	119664	120284	never	The man who sold the world
95	120584	121112	lost	The man who sold the world
96	121208	121844	control	The man who sold the world
97	123104	123512	your	The man who sold the world
98	123568	124164	face	The man who sold the world
99	125184	125592	to	The man who sold the world
100	125648	126244	face	The man who sold the world
101	127264	127720	with	The man who sold the world
102	127792	127904	me	The man who sold the world
\.


--
-- Name: words_word_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.words_word_id_seq', 1, false);


--
-- Name: metadata title_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metadata
    ADD CONSTRAINT title_pkey PRIMARY KEY (title);


--
-- Name: words title_word_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT title_word_id_pkey PRIMARY KEY (title, word_id);


--
-- Name: words title_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.words
    ADD CONSTRAINT title_fkey FOREIGN KEY (title) REFERENCES public.metadata(title);


--
-- Name: TABLE metadata; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.metadata TO plm2136;


--
-- Name: TABLE words; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.words TO plm2136;


--
-- PostgreSQL database dump complete
--

