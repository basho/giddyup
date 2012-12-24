--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: projects_tests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects_tests (
    project_id integer,
    test_id integer
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: scorecards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE scorecards (
    id integer NOT NULL,
    name character varying(255),
    project_id integer
);


--
-- Name: scorecards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE scorecards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scorecards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE scorecards_id_seq OWNED BY scorecards.id;


--
-- Name: test_results; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE test_results (
    id integer NOT NULL,
    status boolean,
    author character varying(255),
    test_id integer,
    scorecard_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    log_url character varying(255),
    long_version character varying(255)
);


--
-- Name: test_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE test_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE test_results_id_seq OWNED BY test_results.id;


--
-- Name: tests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tests (
    id integer NOT NULL,
    name character varying(255),
    tags hstore
);


--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tests_id_seq OWNED BY tests.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY scorecards ALTER COLUMN id SET DEFAULT nextval('scorecards_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY test_results ALTER COLUMN id SET DEFAULT nextval('test_results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tests ALTER COLUMN id SET DEFAULT nextval('tests_id_seq'::regclass);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY projects (id, name) FROM stdin;
1	riak
2	riak_ee
3	riak_cs
4	stanchion
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('projects_id_seq', 4, true);


--
-- Data for Name: projects_tests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY projects_tests (project_id, test_id) FROM stdin;
1	1
2	1
1	2
2	2
1	3
2	3
1	4
2	4
1	5
2	5
1	6
2	6
1	7
2	7
1	8
2	8
1	9
2	9
1	10
2	10
1	11
2	11
1	12
2	12
1	13
2	13
1	14
2	14
1	15
2	15
1	16
2	16
1	17
2	17
1	18
2	18
1	19
2	19
1	20
2	20
1	21
2	21
1	22
2	22
1	23
2	23
1	24
2	24
1	25
2	25
1	26
2	26
1	27
2	27
1	28
2	28
1	29
2	29
1	30
2	30
1	31
2	31
1	32
2	32
1	33
2	33
1	34
2	34
1	35
2	35
1	36
2	36
1	37
2	37
1	38
2	38
1	39
2	39
1	40
2	40
1	41
2	41
1	42
2	42
1	43
2	43
1	44
2	44
1	45
2	45
1	46
2	46
1	47
2	47
1	48
2	48
1	49
2	49
1	50
2	50
1	51
2	51
1	52
2	52
1	53
2	53
1	54
2	54
1	55
2	55
1	56
2	56
1	57
2	57
1	58
2	58
1	59
2	59
1	60
2	60
1	61
2	61
1	62
2	62
1	63
2	63
1	64
2	64
1	65
2	65
1	66
2	66
1	67
2	67
1	68
2	68
1	69
2	69
1	70
2	70
1	71
2	71
1	72
2	72
1	73
2	73
1	74
2	74
1	75
2	75
1	76
2	76
1	77
2	77
1	78
2	78
1	79
2	79
1	80
2	80
1	81
2	81
1	82
2	82
1	83
2	83
1	84
2	84
1	85
2	85
1	86
2	86
1	87
2	87
1	88
2	88
1	89
2	89
1	90
2	90
1	91
2	91
1	92
2	92
1	93
2	93
1	94
2	94
1	95
2	95
1	96
2	96
1	97
2	97
1	98
2	98
1	99
2	99
1	100
2	100
1	101
2	101
1	102
2	102
1	103
2	103
1	104
2	104
1	105
2	105
1	106
2	106
1	107
2	107
1	108
2	108
1	109
2	109
1	110
2	110
1	111
2	111
1	112
2	112
1	113
2	113
1	114
2	114
1	115
2	115
1	116
2	116
1	117
2	117
1	118
2	118
1	119
2	119
1	120
2	120
1	121
2	121
1	122
2	122
1	123
2	123
1	124
2	124
1	125
2	125
1	126
2	126
1	127
2	127
1	128
2	128
1	129
2	129
1	130
2	130
1	131
2	131
1	132
2	132
1	133
2	133
1	134
2	134
1	135
2	135
1	136
2	136
1	137
2	137
1	138
2	138
1	139
2	139
1	140
2	140
1	141
2	141
1	142
2	142
1	143
2	143
1	144
2	144
1	145
2	145
1	146
2	146
1	147
2	147
1	148
2	148
1	149
2	149
1	150
2	150
1	151
2	151
1	152
2	152
1	153
2	153
1	154
2	154
1	155
2	155
1	156
2	156
1	157
2	157
1	158
2	158
1	159
2	159
1	160
2	160
1	161
2	161
1	162
2	162
1	163
2	163
1	164
2	164
1	165
2	165
1	166
2	166
1	167
2	167
1	168
2	168
1	169
2	169
1	170
2	170
1	171
1	172
2	171
2	172
1	173
1	174
2	173
2	174
1	175
1	176
2	175
2	176
1	177
1	178
2	177
2	178
1	179
1	180
2	179
2	180
1	181
1	182
2	181
2	182
1	183
1	184
2	183
2	184
1	185
1	186
2	185
2	186
1	187
1	188
2	187
2	188
1	189
1	190
2	189
2	190
3	191
1	192
2	192
1	193
2	193
1	194
2	194
1	195
2	195
1	196
2	196
1	197
2	197
1	198
2	198
1	199
2	199
1	200
2	200
1	201
2	201
1	202
2	202
1	203
2	203
1	204
2	204
1	205
2	205
1	206
2	206
1	207
2	207
1	208
2	208
1	209
2	209
1	210
2	210
1	211
2	211
1	212
2	212
1	213
2	213
1	214
2	214
1	215
2	215
1	216
2	216
1	217
2	217
1	218
2	218
1	219
2	219
1	220
2	220
1	221
2	221
1	222
2	222
1	223
2	223
1	224
2	224
1	225
2	225
1	226
2	226
1	227
2	227
1	228
2	228
1	229
2	229
1	230
2	230
1	231
2	231
1	232
2	232
1	233
2	233
1	234
2	234
1	235
2	235
1	236
2	236
1	237
2	237
1	238
2	238
1	239
2	239
1	240
2	240
1	241
2	241
1	242
2	242
1	243
2	243
1	244
2	244
1	245
2	245
1	246
2	246
1	247
2	247
1	248
2	248
1	249
2	249
1	250
2	250
1	251
2	251
1	252
2	252
1	253
2	253
1	254
2	254
1	255
2	255
1	256
2	256
1	257
2	257
1	258
2	258
1	259
2	259
1	260
2	260
1	261
2	261
1	262
2	262
1	263
2	263
1	264
2	264
1	265
2	265
1	266
2	266
1	267
2	267
1	268
2	268
1	269
2	269
1	270
2	270
1	271
2	271
1	272
2	272
1	273
2	273
1	274
2	274
1	275
2	275
1	276
2	276
1	277
2	277
1	278
2	278
1	279
2	279
1	280
2	280
1	281
2	281
1	282
2	282
1	283
2	283
1	284
2	284
1	285
2	285
1	286
2	286
1	287
2	287
1	288
2	288
1	289
2	289
1	290
2	290
1	291
2	291
1	292
2	292
1	293
2	293
1	294
2	294
1	295
2	295
1	296
2	296
1	297
2	297
1	298
2	298
1	299
2	299
1	300
2	300
1	301
2	301
1	302
2	302
1	303
2	303
1	304
2	304
1	305
2	305
1	306
2	306
1	307
2	307
1	308
2	308
1	309
2	309
1	310
2	310
1	311
2	311
1	312
2	312
1	313
2	313
1	314
2	314
1	315
2	315
1	316
2	316
1	317
2	317
1	318
2	318
1	319
2	319
1	320
2	320
1	321
2	321
1	322
2	322
1	323
2	323
1	324
2	324
1	325
2	325
1	326
2	326
1	327
2	327
1	328
2	328
1	329
2	329
1	330
2	330
1	331
2	331
1	332
2	332
1	333
2	333
1	334
2	334
1	335
2	335
1	336
2	336
1	337
2	337
1	338
2	338
1	339
2	339
1	340
2	340
1	341
2	341
1	342
2	342
1	343
2	343
1	344
2	344
1	345
2	345
1	346
2	346
1	347
2	347
1	348
2	348
1	349
2	349
1	350
2	350
1	351
2	351
1	352
2	352
1	353
2	353
1	354
2	354
1	355
2	355
1	356
2	356
1	357
2	357
1	358
2	358
1	359
2	359
1	360
2	360
1	361
2	361
1	362
2	362
1	363
2	363
1	364
2	364
1	365
2	365
1	366
2	366
1	367
2	367
1	368
2	368
1	369
2	369
1	370
2	370
1	371
2	371
1	372
2	372
1	373
2	373
1	374
2	374
1	375
2	375
1	376
2	376
1	377
2	377
1	378
2	378
1	379
2	379
1	380
2	380
1	381
2	381
1	382
2	382
1	383
2	383
1	384
2	384
1	385
2	385
1	386
2	386
1	387
2	387
1	388
2	388
1	389
2	389
1	390
2	390
1	391
2	391
1	392
2	392
1	393
2	393
1	394
2	394
1	395
2	395
1	396
2	396
1	397
2	397
1	398
2	398
1	399
2	399
1	400
2	400
1	401
2	401
1	402
2	402
1	403
2	403
1	404
2	404
1	405
2	405
1	406
2	406
1	407
2	407
1	408
2	408
1	409
2	409
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY schema_migrations (version) FROM stdin;
2012091317061347570370
2012091409381347629910
2012091411521347637960
2012092011261348154787
2012100511261348154787
2012111316281352842088
2012111418271352935658
2012111613531353092003
2012111614451353095159
2012120414431354653820
\.


--
-- Data for Name: scorecards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY scorecards (id, name, project_id) FROM stdin;
2	unknown	2
1	1.2.1rc2	1
3	1.2.0	1
4	1.2.1	1
7	1.3.0pre1	1
\.


--
-- Name: scorecards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('scorecards_id_seq', 7, true);


--
-- Data for Name: test_results; Type: TABLE DATA; Schema: public; Owner: -
--

COPY test_results (id, status, author, test_id, scorecard_id, created_at, updated_at, log_url, long_version) FROM stdin;
399	t	\N	210	4	2012-11-15 17:42:58.800363	2012-11-15 17:42:58.800363	https://basho-giddyup.s3.amazonaws.com/399.log	riak-1.2.1-71-g37f0b9f-master
400	f	\N	241	4	2012-11-15 17:46:36.642946	2012-11-15 17:46:36.642946	https://basho-giddyup.s3.amazonaws.com/400.log	riak-1.2.1-71-g37f0b9f-master
613	t	\N	305	4	2012-11-20 23:31:08.391042	2012-11-20 23:31:08.391042	https://basho-giddyup.s3.amazonaws.com/613.log	riak-1.2.1-81-gd414744-master
614	t	\N	339	4	2012-11-21 00:07:12.61723	2012-11-21 00:07:12.61723	https://basho-giddyup.s3.amazonaws.com/614.log	riak-1.2.1-81-gd414744-master
615	f	\N	355	4	2012-11-21 00:07:45.428112	2012-11-21 00:07:45.428112	https://basho-giddyup.s3.amazonaws.com/615.log	riak-1.2.1-81-gd414744-master
616	t	\N	4	4	2012-11-21 04:50:03.187329	2012-11-21 04:50:03.187329	https://basho-giddyup.s3.amazonaws.com/616.log	riak-1.2.1-81-ge681ace-master
617	f	\N	14	4	2012-11-21 04:50:29.977371	2012-11-21 04:50:29.977371	https://basho-giddyup.s3.amazonaws.com/617.log	riak-1.2.1-81-ge681ace-master
618	t	\N	24	4	2012-11-21 04:51:40.112567	2012-11-21 04:51:40.112567	https://basho-giddyup.s3.amazonaws.com/618.log	riak-1.2.1-81-ge681ace-master
619	t	\N	34	4	2012-11-21 04:52:38.751172	2012-11-21 04:52:38.751172	https://basho-giddyup.s3.amazonaws.com/619.log	riak-1.2.1-81-ge681ace-master
620	f	\N	44	4	2012-11-21 04:53:03.508572	2012-11-21 04:53:03.508572	https://basho-giddyup.s3.amazonaws.com/620.log	riak-1.2.1-81-ge681ace-master
621	t	\N	54	4	2012-11-21 04:53:54.797836	2012-11-21 04:53:54.797836	https://basho-giddyup.s3.amazonaws.com/621.log	riak-1.2.1-81-ge681ace-master
622	t	\N	64	4	2012-11-21 04:54:14.949613	2012-11-21 04:54:14.949613	https://basho-giddyup.s3.amazonaws.com/622.log	riak-1.2.1-81-ge681ace-master
623	t	\N	94	4	2012-11-21 04:54:41.358517	2012-11-21 04:54:41.358517	https://basho-giddyup.s3.amazonaws.com/623.log	riak-1.2.1-81-ge681ace-master
624	f	\N	84	4	2012-11-21 05:05:30.094724	2012-11-21 05:05:30.094724	https://basho-giddyup.s3.amazonaws.com/624.log	riak-1.2.1-81-ge681ace-master
625	f	\N	104	4	2012-11-21 05:10:59.410207	2012-11-21 05:10:59.410207	https://basho-giddyup.s3.amazonaws.com/625.log	riak-1.2.1-81-ge681ace-master
626	f	\N	114	4	2012-11-21 05:16:22.842983	2012-11-21 05:16:22.842983	https://basho-giddyup.s3.amazonaws.com/626.log	riak-1.2.1-81-ge681ace-master
627	t	\N	124	4	2012-11-21 05:16:57.518644	2012-11-21 05:16:57.518644	https://basho-giddyup.s3.amazonaws.com/627.log	riak-1.2.1-81-ge681ace-master
628	f	\N	134	4	2012-11-21 05:17:15.992341	2012-11-21 05:17:15.992341	https://basho-giddyup.s3.amazonaws.com/628.log	riak-1.2.1-81-ge681ace-master
629	t	\N	144	4	2012-11-21 05:17:35.173778	2012-11-21 05:17:35.173778	https://basho-giddyup.s3.amazonaws.com/629.log	riak-1.2.1-81-ge681ace-master
630	t	\N	154	4	2012-11-21 05:18:40.252604	2012-11-21 05:18:40.252604	https://basho-giddyup.s3.amazonaws.com/630.log	riak-1.2.1-81-ge681ace-master
631	t	\N	164	4	2012-11-21 05:20:54.777945	2012-11-21 05:20:54.777945	https://basho-giddyup.s3.amazonaws.com/631.log	riak-1.2.1-81-ge681ace-master
632	t	\N	177	4	2012-11-21 05:21:17.337726	2012-11-21 05:21:17.337726	https://basho-giddyup.s3.amazonaws.com/632.log	riak-1.2.1-81-ge681ace-master
633	t	\N	178	4	2012-11-21 05:22:06.582911	2012-11-21 05:22:06.582911	https://basho-giddyup.s3.amazonaws.com/633.log	riak-1.2.1-81-ge681ace-master
634	t	\N	233	4	2012-11-21 05:22:39.462176	2012-11-21 05:22:39.462176	https://basho-giddyup.s3.amazonaws.com/634.log	riak-1.2.1-81-ge681ace-master
635	t	\N	245	4	2012-11-21 05:24:33.385108	2012-11-21 05:24:33.385108	https://basho-giddyup.s3.amazonaws.com/635.log	riak-1.2.1-81-ge681ace-master
636	f	\N	257	4	2012-11-21 05:24:43.893423	2012-11-21 05:24:43.893423	https://basho-giddyup.s3.amazonaws.com/636.log	riak-1.2.1-81-ge681ace-master
637	f	\N	269	4	2012-11-21 05:26:03.666058	2012-11-21 05:26:03.666058	https://basho-giddyup.s3.amazonaws.com/637.log	riak-1.2.1-81-ge681ace-master
638	f	\N	281	4	2012-11-21 05:27:16.299894	2012-11-21 05:27:16.299894	https://basho-giddyup.s3.amazonaws.com/638.log	riak-1.2.1-81-ge681ace-master
639	t	\N	296	4	2012-11-21 05:58:13.577635	2012-11-21 05:58:13.577635	https://basho-giddyup.s3.amazonaws.com/639.log	riak-1.2.1-81-ge681ace-master
640	t	\N	332	4	2012-11-21 06:30:42.555969	2012-11-21 06:30:42.555969	https://basho-giddyup.s3.amazonaws.com/640.log	riak-1.2.1-81-ge681ace-master
641	t	\N	297	4	2012-11-21 07:10:20.675835	2012-11-21 07:10:20.675835	https://basho-giddyup.s3.amazonaws.com/641.log	riak-1.2.1-81-ge681ace-master
642	t	\N	333	4	2012-11-21 07:48:42.876005	2012-11-21 07:48:42.876005	https://basho-giddyup.s3.amazonaws.com/642.log	riak-1.2.1-81-ge681ace-master
643	f	\N	353	4	2012-11-21 07:49:28.637028	2012-11-21 07:49:28.637028	https://basho-giddyup.s3.amazonaws.com/643.log	riak-1.2.1-81-ge681ace-master
644	t	\N	4	4	2012-11-21 15:07:55.222511	2012-11-21 15:07:55.222511	https://basho-giddyup.s3.amazonaws.com/644.log	riak-1.2.1-81-ge681ace-master
645	f	\N	14	4	2012-11-21 15:08:22.924931	2012-11-21 15:08:22.924931	https://basho-giddyup.s3.amazonaws.com/645.log	riak-1.2.1-81-ge681ace-master
646	t	\N	24	4	2012-11-21 15:09:30.445585	2012-11-21 15:09:30.445585	https://basho-giddyup.s3.amazonaws.com/646.log	riak-1.2.1-81-ge681ace-master
647	t	\N	34	4	2012-11-21 15:10:32.994873	2012-11-21 15:10:32.994873	https://basho-giddyup.s3.amazonaws.com/647.log	riak-1.2.1-81-ge681ace-master
648	f	\N	44	4	2012-11-21 15:10:56.149562	2012-11-21 15:10:56.149562	https://basho-giddyup.s3.amazonaws.com/648.log	riak-1.2.1-81-ge681ace-master
649	f	\N	54	4	2012-11-21 15:11:12.264487	2012-11-21 15:11:12.264487	https://basho-giddyup.s3.amazonaws.com/649.log	riak-1.2.1-81-ge681ace-master
650	t	\N	64	4	2012-11-21 15:11:33.065126	2012-11-21 15:11:33.065126	https://basho-giddyup.s3.amazonaws.com/650.log	riak-1.2.1-81-ge681ace-master
651	f	\N	94	4	2012-11-21 15:11:49.579812	2012-11-21 15:11:49.579812	https://basho-giddyup.s3.amazonaws.com/651.log	riak-1.2.1-81-ge681ace-master
652	f	\N	84	4	2012-11-21 15:12:20.366336	2012-11-21 15:12:20.366336	https://basho-giddyup.s3.amazonaws.com/652.log	riak-1.2.1-81-ge681ace-master
653	f	\N	104	4	2012-11-21 15:17:49.63174	2012-11-21 15:17:49.63174	https://basho-giddyup.s3.amazonaws.com/653.log	riak-1.2.1-81-ge681ace-master
654	f	\N	114	4	2012-11-21 15:23:13.521124	2012-11-21 15:23:13.521124	https://basho-giddyup.s3.amazonaws.com/654.log	riak-1.2.1-81-ge681ace-master
655	t	\N	124	4	2012-11-21 15:23:49.858415	2012-11-21 15:23:49.858415	https://basho-giddyup.s3.amazonaws.com/655.log	riak-1.2.1-81-ge681ace-master
656	f	\N	134	4	2012-11-21 15:24:08.153062	2012-11-21 15:24:08.153062	https://basho-giddyup.s3.amazonaws.com/656.log	riak-1.2.1-81-ge681ace-master
657	t	\N	144	4	2012-11-21 15:24:28.87622	2012-11-21 15:24:28.87622	https://basho-giddyup.s3.amazonaws.com/657.log	riak-1.2.1-81-ge681ace-master
658	t	\N	154	4	2012-11-21 15:30:40.248766	2012-11-21 15:30:40.248766	https://basho-giddyup.s3.amazonaws.com/658.log	riak-1.2.1-81-ge681ace-master
659	t	\N	164	4	2012-11-21 15:33:00.221505	2012-11-21 15:33:00.221505	https://basho-giddyup.s3.amazonaws.com/659.log	riak-1.2.1-81-ge681ace-master
660	t	\N	177	4	2012-11-21 15:33:28.458789	2012-11-21 15:33:28.458789	https://basho-giddyup.s3.amazonaws.com/660.log	riak-1.2.1-81-ge681ace-master
661	t	\N	178	4	2012-11-21 15:34:17.93219	2012-11-21 15:34:17.93219	https://basho-giddyup.s3.amazonaws.com/661.log	riak-1.2.1-81-ge681ace-master
401	t	\N	192	4	2012-11-15 21:31:40.471786	2012-11-15 21:31:40.471786	https://basho-giddyup.s3.amazonaws.com/401.log	riak-1.2.1-71-g37f0b9f-master
402	f	\N	193	4	2012-11-15 21:32:11.568008	2012-11-15 21:32:11.568008	https://basho-giddyup.s3.amazonaws.com/402.log	riak-1.2.1-71-g37f0b9f-master
403	t	\N	194	4	2012-11-15 21:32:49.843924	2012-11-15 21:32:49.843924	https://basho-giddyup.s3.amazonaws.com/403.log	riak-1.2.1-71-g37f0b9f-master
404	t	\N	195	4	2012-11-15 21:33:25.611283	2012-11-15 21:33:25.611283	https://basho-giddyup.s3.amazonaws.com/404.log	riak-1.2.1-71-g37f0b9f-master
405	t	\N	196	4	2012-11-15 21:33:53.540101	2012-11-15 21:33:53.540101	https://basho-giddyup.s3.amazonaws.com/405.log	riak-1.2.1-71-g37f0b9f-master
406	t	\N	197	4	2012-11-15 21:35:03.48709	2012-11-15 21:35:03.48709	https://basho-giddyup.s3.amazonaws.com/406.log	riak-1.2.1-71-g37f0b9f-master
407	t	\N	198	4	2012-11-15 21:35:20.846272	2012-11-15 21:35:20.846272	https://basho-giddyup.s3.amazonaws.com/407.log	riak-1.2.1-71-g37f0b9f-master
408	f	\N	200	4	2012-11-15 21:35:25.482194	2012-11-15 21:35:25.482194	https://basho-giddyup.s3.amazonaws.com/408.log	riak-1.2.1-71-g37f0b9f-master
409	t	\N	201	4	2012-11-15 21:35:44.911418	2012-11-15 21:35:44.911418	https://basho-giddyup.s3.amazonaws.com/409.log	riak-1.2.1-71-g37f0b9f-master
410	f	\N	202	4	2012-11-15 21:35:50.518071	2012-11-15 21:35:50.518071	https://basho-giddyup.s3.amazonaws.com/410.log	riak-1.2.1-71-g37f0b9f-master
412	t	\N	204	4	2012-11-15 21:36:57.80569	2012-11-15 21:36:57.80569	https://basho-giddyup.s3.amazonaws.com/412.log	riak-1.2.1-71-g37f0b9f-master
413	t	\N	205	4	2012-11-15 21:39:19.395738	2012-11-15 21:39:19.395738	https://basho-giddyup.s3.amazonaws.com/413.log	riak-1.2.1-71-g37f0b9f-master
414	t	\N	206	4	2012-11-15 21:39:37.747299	2012-11-15 21:39:37.747299	https://basho-giddyup.s3.amazonaws.com/414.log	riak-1.2.1-71-g37f0b9f-master
415	t	\N	207	4	2012-11-15 21:40:38.211073	2012-11-15 21:40:38.211073	https://basho-giddyup.s3.amazonaws.com/415.log	riak-1.2.1-71-g37f0b9f-master
416	t	\N	208	4	2012-11-15 21:43:24.83352	2012-11-15 21:43:24.83352	https://basho-giddyup.s3.amazonaws.com/416.log	riak-1.2.1-71-g37f0b9f-master
417	t	\N	209	4	2012-11-15 21:44:00.633024	2012-11-15 21:44:00.633024	https://basho-giddyup.s3.amazonaws.com/417.log	riak-1.2.1-71-g37f0b9f-master
418	t	\N	210	4	2012-11-15 21:44:21.932079	2012-11-15 21:44:21.932079	https://basho-giddyup.s3.amazonaws.com/418.log	riak-1.2.1-71-g37f0b9f-master
419	f	\N	241	4	2012-11-15 21:47:58.987928	2012-11-15 21:47:58.987928	https://basho-giddyup.s3.amazonaws.com/419.log	riak-1.2.1-71-g37f0b9f-master
420	t	\N	192	4	2012-11-16 22:24:02.963386	2012-11-16 22:24:02.963386	https://basho-giddyup.s3.amazonaws.com/420.log	riak-1.2.1-75-geecfec6-master
421	f	\N	193	4	2012-11-16 22:24:39.673434	2012-11-16 22:24:39.673434	https://basho-giddyup.s3.amazonaws.com/421.log	riak-1.2.1-75-geecfec6-master
422	t	\N	194	4	2012-11-16 22:25:20.922609	2012-11-16 22:25:20.922609	https://basho-giddyup.s3.amazonaws.com/422.log	riak-1.2.1-75-geecfec6-master
423	t	\N	195	4	2012-11-16 22:25:58.068179	2012-11-16 22:25:58.068179	https://basho-giddyup.s3.amazonaws.com/423.log	riak-1.2.1-75-geecfec6-master
424	t	\N	196	4	2012-11-16 22:26:27.77113	2012-11-16 22:26:27.77113	https://basho-giddyup.s3.amazonaws.com/424.log	riak-1.2.1-75-geecfec6-master
425	t	\N	197	4	2012-11-16 22:27:22.412923	2012-11-16 22:27:22.412923	https://basho-giddyup.s3.amazonaws.com/425.log	riak-1.2.1-75-geecfec6-master
426	t	\N	198	4	2012-11-16 22:27:39.993544	2012-11-16 22:27:39.993544	https://basho-giddyup.s3.amazonaws.com/426.log	riak-1.2.1-75-geecfec6-master
427	t	\N	201	4	2012-11-16 22:28:09.896078	2012-11-16 22:28:09.896078	https://basho-giddyup.s3.amazonaws.com/427.log	riak-1.2.1-75-geecfec6-master
428	f	\N	202	4	2012-11-16 22:28:30.74414	2012-11-16 22:28:30.74414	https://basho-giddyup.s3.amazonaws.com/428.log	riak-1.2.1-75-geecfec6-master
429	f	\N	203	4	2012-11-16 22:29:08.054565	2012-11-16 22:29:08.054565	https://basho-giddyup.s3.amazonaws.com/429.log	riak-1.2.1-75-geecfec6-master
430	t	\N	204	4	2012-11-16 22:29:30.024688	2012-11-16 22:29:30.024688	https://basho-giddyup.s3.amazonaws.com/430.log	riak-1.2.1-75-geecfec6-master
431	t	\N	205	4	2012-11-16 22:31:51.596255	2012-11-16 22:31:51.596255	https://basho-giddyup.s3.amazonaws.com/431.log	riak-1.2.1-75-geecfec6-master
432	t	\N	206	4	2012-11-16 22:37:11.909285	2012-11-16 22:37:11.909285	https://basho-giddyup.s3.amazonaws.com/432.log	riak-1.2.1-75-geecfec6-master
433	t	\N	207	4	2012-11-16 22:38:11.971605	2012-11-16 22:38:11.971605	https://basho-giddyup.s3.amazonaws.com/433.log	riak-1.2.1-75-geecfec6-master
434	t	\N	208	4	2012-11-17 00:04:57.989045	2012-11-17 00:04:57.989045	https://basho-giddyup.s3.amazonaws.com/434.log	riak-1.2.1-75-geecfec6-master
435	t	\N	209	4	2012-11-17 00:05:41.147341	2012-11-17 00:05:41.147341	https://basho-giddyup.s3.amazonaws.com/435.log	riak-1.2.1-75-geecfec6-master
436	t	\N	210	4	2012-11-17 00:06:18.574725	2012-11-17 00:06:18.574725	https://basho-giddyup.s3.amazonaws.com/436.log	riak-1.2.1-75-geecfec6-master
437	t	\N	241	4	2012-11-17 00:06:55.382615	2012-11-17 00:06:55.382615	https://basho-giddyup.s3.amazonaws.com/437.log	riak-1.2.1-75-geecfec6-master
438	t	\N	253	4	2012-11-17 00:08:31.720767	2012-11-17 00:08:31.720767	https://basho-giddyup.s3.amazonaws.com/438.log	riak-1.2.1-75-geecfec6-master
439	f	\N	265	4	2012-11-17 00:08:40.370474	2012-11-17 00:08:40.370474	https://basho-giddyup.s3.amazonaws.com/439.log	riak-1.2.1-75-geecfec6-master
440	f	\N	277	4	2012-11-17 00:08:58.408346	2012-11-17 00:08:58.408346	https://basho-giddyup.s3.amazonaws.com/440.log	riak-1.2.1-75-geecfec6-master
441	t	\N	200	4	2012-11-17 00:10:42.715068	2012-11-17 00:10:42.715068	https://basho-giddyup.s3.amazonaws.com/441.log	riak-1.2.1-75-geecfec6-master
442	f	\N	289	4	2012-11-17 00:12:14.845093	2012-11-17 00:12:14.845093	https://basho-giddyup.s3.amazonaws.com/442.log	riak-1.2.1-75-geecfec6-master
443	t	\N	312	4	2012-11-17 08:58:39.459927	2012-11-17 08:58:39.459927	https://basho-giddyup.s3.amazonaws.com/443.log	riak-1.2.1-75-geecfec6-master
444	t	\N	346	4	2012-11-17 13:50:47.919312	2012-11-17 13:50:47.919312	https://basho-giddyup.s3.amazonaws.com/444.log	riak-1.2.1-75-geecfec6-master
445	t	\N	313	4	2012-11-17 14:31:58.417972	2012-11-17 14:31:58.417972	https://basho-giddyup.s3.amazonaws.com/445.log	riak-1.2.1-75-geecfec6-master
446	t	\N	347	4	2012-11-17 15:15:27.393384	2012-11-17 15:15:27.393384	https://basho-giddyup.s3.amazonaws.com/446.log	riak-1.2.1-75-geecfec6-master
447	t	\N	359	4	2012-11-17 15:17:20.482271	2012-11-17 15:17:20.482271	https://basho-giddyup.s3.amazonaws.com/447.log	riak-1.2.1-75-geecfec6-master
448	f	\N	4	4	2012-11-19 16:48:29.413848	2012-11-19 16:48:29.413848	https://basho-giddyup.s3.amazonaws.com/448.log	riak-1.2.1-81-ge681ace-master
449	f	\N	14	4	2012-11-19 16:54:06.600427	2012-11-19 16:54:06.600427	https://basho-giddyup.s3.amazonaws.com/449.log	riak-1.2.1-81-ge681ace-master
450	f	\N	24	4	2012-11-19 16:59:50.718496	2012-11-19 16:59:50.718496	https://basho-giddyup.s3.amazonaws.com/450.log	riak-1.2.1-81-ge681ace-master
451	t	\N	34	4	2012-11-19 17:00:54.1023	2012-11-19 17:00:54.1023	https://basho-giddyup.s3.amazonaws.com/451.log	riak-1.2.1-81-ge681ace-master
452	f	\N	44	4	2012-11-19 17:01:04.596436	2012-11-19 17:01:04.596436	https://basho-giddyup.s3.amazonaws.com/452.log	riak-1.2.1-81-ge681ace-master
453	t	\N	54	4	2012-11-19 17:01:54.371294	2012-11-19 17:01:54.371294	https://basho-giddyup.s3.amazonaws.com/453.log	riak-1.2.1-81-ge681ace-master
454	t	\N	64	4	2012-11-19 17:07:12.413631	2012-11-19 17:07:12.413631	https://basho-giddyup.s3.amazonaws.com/454.log	riak-1.2.1-81-ge681ace-master
455	t	\N	94	4	2012-11-19 17:07:42.069516	2012-11-19 17:07:42.069516	https://basho-giddyup.s3.amazonaws.com/455.log	riak-1.2.1-81-ge681ace-master
456	f	\N	84	4	2012-11-19 17:13:20.008686	2012-11-19 17:13:20.008686	https://basho-giddyup.s3.amazonaws.com/456.log	riak-1.2.1-81-ge681ace-master
457	f	\N	104	4	2012-11-19 17:13:39.202519	2012-11-19 17:13:39.202519	https://basho-giddyup.s3.amazonaws.com/457.log	riak-1.2.1-81-ge681ace-master
458	f	\N	114	4	2012-11-19 17:18:56.625056	2012-11-19 17:18:56.625056	https://basho-giddyup.s3.amazonaws.com/458.log	riak-1.2.1-81-ge681ace-master
459	t	\N	124	4	2012-11-19 17:24:40.69642	2012-11-19 17:24:40.69642	https://basho-giddyup.s3.amazonaws.com/459.log	riak-1.2.1-81-ge681ace-master
460	t	\N	134	4	2012-11-19 17:26:40.062744	2012-11-19 17:26:40.062744	https://basho-giddyup.s3.amazonaws.com/460.log	riak-1.2.1-81-ge681ace-master
461	t	\N	144	4	2012-11-19 17:26:54.560662	2012-11-19 17:26:54.560662	https://basho-giddyup.s3.amazonaws.com/461.log	riak-1.2.1-81-ge681ace-master
462	t	\N	154	4	2012-11-19 17:32:59.345739	2012-11-19 17:32:59.345739	https://basho-giddyup.s3.amazonaws.com/462.log	riak-1.2.1-81-ge681ace-master
463	t	\N	164	4	2012-11-19 17:35:16.353435	2012-11-19 17:35:16.353435	https://basho-giddyup.s3.amazonaws.com/463.log	riak-1.2.1-81-ge681ace-master
464	t	\N	177	4	2012-11-19 17:35:46.100853	2012-11-19 17:35:46.100853	https://basho-giddyup.s3.amazonaws.com/464.log	riak-1.2.1-81-ge681ace-master
465	t	\N	178	4	2012-11-19 17:36:29.432038	2012-11-19 17:36:29.432038	https://basho-giddyup.s3.amazonaws.com/465.log	riak-1.2.1-81-ge681ace-master
466	t	\N	233	4	2012-11-19 17:41:59.707457	2012-11-19 17:41:59.707457	https://basho-giddyup.s3.amazonaws.com/466.log	riak-1.2.1-81-ge681ace-master
467	f	\N	245	4	2012-11-19 17:45:09.623142	2012-11-19 17:45:09.623142	https://basho-giddyup.s3.amazonaws.com/467.log	riak-1.2.1-81-ge681ace-master
468	f	\N	257	4	2012-11-19 17:45:13.772586	2012-11-19 17:45:13.772586	https://basho-giddyup.s3.amazonaws.com/468.log	riak-1.2.1-81-ge681ace-master
469	f	\N	269	4	2012-11-19 17:45:28.30488	2012-11-19 17:45:28.30488	https://basho-giddyup.s3.amazonaws.com/469.log	riak-1.2.1-81-ge681ace-master
470	f	\N	281	4	2012-11-19 17:50:39.238373	2012-11-19 17:50:39.238373	https://basho-giddyup.s3.amazonaws.com/470.log	riak-1.2.1-81-ge681ace-master
471	f	\N	296	4	2012-11-19 17:50:42.725025	2012-11-19 17:50:42.725025	https://basho-giddyup.s3.amazonaws.com/471.log	riak-1.2.1-81-ge681ace-master
472	f	\N	332	4	2012-11-19 17:50:46.25946	2012-11-19 17:50:46.25946	https://basho-giddyup.s3.amazonaws.com/472.log	riak-1.2.1-81-ge681ace-master
473	f	\N	297	4	2012-11-19 17:50:49.621086	2012-11-19 17:50:49.621086	https://basho-giddyup.s3.amazonaws.com/473.log	riak-1.2.1-81-ge681ace-master
474	f	\N	333	4	2012-11-19 17:50:53.168967	2012-11-19 17:50:53.168967	https://basho-giddyup.s3.amazonaws.com/474.log	riak-1.2.1-81-ge681ace-master
475	f	\N	353	4	2012-11-19 17:51:25.7782	2012-11-19 17:51:25.7782	https://basho-giddyup.s3.amazonaws.com/475.log	riak-1.2.1-81-ge681ace-master
476	f	\N	4	4	2012-11-19 18:59:34.611024	2012-11-19 18:59:34.611024	https://basho-giddyup.s3.amazonaws.com/476.log	riak-1.2.1-81-ge681ace-master
477	f	\N	14	4	2012-11-19 19:05:10.696326	2012-11-19 19:05:10.696326	https://basho-giddyup.s3.amazonaws.com/477.log	riak-1.2.1-81-ge681ace-master
478	t	\N	24	4	2012-11-19 19:11:11.116433	2012-11-19 19:11:11.116433	https://basho-giddyup.s3.amazonaws.com/478.log	riak-1.2.1-81-ge681ace-master
479	t	\N	34	4	2012-11-19 19:17:28.751075	2012-11-19 19:17:28.751075	https://basho-giddyup.s3.amazonaws.com/479.log	riak-1.2.1-81-ge681ace-master
480	f	\N	44	4	2012-11-19 19:17:38.962075	2012-11-19 19:17:38.962075	https://basho-giddyup.s3.amazonaws.com/480.log	riak-1.2.1-81-ge681ace-master
481	t	\N	54	4	2012-11-19 19:23:52.32429	2012-11-19 19:23:52.32429	https://basho-giddyup.s3.amazonaws.com/481.log	riak-1.2.1-81-ge681ace-master
482	t	\N	64	4	2012-11-19 19:29:10.475663	2012-11-19 19:29:10.475663	https://basho-giddyup.s3.amazonaws.com/482.log	riak-1.2.1-81-ge681ace-master
483	t	\N	94	4	2012-11-19 19:29:39.968237	2012-11-19 19:29:39.968237	https://basho-giddyup.s3.amazonaws.com/483.log	riak-1.2.1-81-ge681ace-master
484	f	\N	84	4	2012-11-19 19:30:12.902396	2012-11-19 19:30:12.902396	https://basho-giddyup.s3.amazonaws.com/484.log	riak-1.2.1-81-ge681ace-master
485	t	\N	104	4	2012-11-19 19:41:47.529301	2012-11-19 19:41:47.529301	https://basho-giddyup.s3.amazonaws.com/485.log	riak-1.2.1-81-ge681ace-master
486	t	\N	114	4	2012-11-19 19:42:26.296084	2012-11-19 19:42:26.296084	https://basho-giddyup.s3.amazonaws.com/486.log	riak-1.2.1-81-ge681ace-master
487	t	\N	124	4	2012-11-19 19:48:11.928734	2012-11-19 19:48:11.928734	https://basho-giddyup.s3.amazonaws.com/487.log	riak-1.2.1-81-ge681ace-master
488	t	\N	134	4	2012-11-19 19:50:51.49063	2012-11-19 19:50:51.49063	https://basho-giddyup.s3.amazonaws.com/488.log	riak-1.2.1-81-ge681ace-master
489	t	\N	144	4	2012-11-19 19:51:04.316782	2012-11-19 19:51:04.316782	https://basho-giddyup.s3.amazonaws.com/489.log	riak-1.2.1-81-ge681ace-master
490	t	\N	154	4	2012-11-19 19:52:04.004374	2012-11-19 19:52:04.004374	https://basho-giddyup.s3.amazonaws.com/490.log	riak-1.2.1-81-ge681ace-master
662	f	\N	233	4	2012-11-21 15:37:46.480976	2012-11-21 15:37:46.480976	https://basho-giddyup.s3.amazonaws.com/662.log	riak-1.2.1-81-ge681ace-master
702	t	\N	206	4	2012-11-21 22:52:15.112772	2012-11-21 22:52:15.112772	https://basho-giddyup.s3.amazonaws.com/702.log	riak-1.2.1-81-ge681ace-master
703	f	\N	207	4	2012-11-21 22:52:32.107698	2012-11-21 22:52:32.107698	https://basho-giddyup.s3.amazonaws.com/703.log	riak-1.2.1-81-ge681ace-master
704	t	\N	208	4	2012-11-21 22:55:04.167171	2012-11-21 22:55:04.167171	https://basho-giddyup.s3.amazonaws.com/704.log	riak-1.2.1-81-ge681ace-master
705	t	\N	209	4	2012-11-21 22:55:29.548519	2012-11-21 22:55:29.548519	https://basho-giddyup.s3.amazonaws.com/705.log	riak-1.2.1-81-ge681ace-master
706	t	\N	210	4	2012-11-21 22:55:53.923772	2012-11-21 22:55:53.923772	https://basho-giddyup.s3.amazonaws.com/706.log	riak-1.2.1-81-ge681ace-master
707	f	\N	241	4	2012-11-21 23:04:24.949013	2012-11-21 23:04:24.949013	https://basho-giddyup.s3.amazonaws.com/707.log	riak-1.2.1-81-ge681ace-master
491	t	\N	164	4	2012-11-19 19:54:29.893199	2012-11-19 19:54:29.893199	https://basho-giddyup.s3.amazonaws.com/491.log	riak-1.2.1-81-ge681ace-master
492	f	\N	177	4	2012-11-19 19:54:48.049646	2012-11-19 19:54:48.049646	https://basho-giddyup.s3.amazonaws.com/492.log	riak-1.2.1-81-ge681ace-master
493	t	\N	178	4	2012-11-19 19:55:39.307921	2012-11-19 19:55:39.307921	https://basho-giddyup.s3.amazonaws.com/493.log	riak-1.2.1-81-ge681ace-master
494	f	\N	233	4	2012-11-19 20:04:03.483228	2012-11-19 20:04:03.483228	https://basho-giddyup.s3.amazonaws.com/494.log	riak-1.2.1-81-ge681ace-master
495	f	\N	245	4	2012-11-19 20:07:14.784492	2012-11-19 20:07:14.784492	https://basho-giddyup.s3.amazonaws.com/495.log	riak-1.2.1-81-ge681ace-master
496	f	\N	257	4	2012-11-19 20:07:19.209891	2012-11-19 20:07:19.209891	https://basho-giddyup.s3.amazonaws.com/496.log	riak-1.2.1-81-ge681ace-master
497	f	\N	269	4	2012-11-19 20:07:33.132221	2012-11-19 20:07:33.132221	https://basho-giddyup.s3.amazonaws.com/497.log	riak-1.2.1-81-ge681ace-master
498	f	\N	281	4	2012-11-19 20:12:43.602633	2012-11-19 20:12:43.602633	https://basho-giddyup.s3.amazonaws.com/498.log	riak-1.2.1-81-ge681ace-master
499	t	\N	296	4	2012-11-19 20:44:48.63584	2012-11-19 20:44:48.63584	https://basho-giddyup.s3.amazonaws.com/499.log	riak-1.2.1-81-ge681ace-master
500	t	\N	332	4	2012-11-19 21:16:49.619123	2012-11-19 21:16:49.619123	https://basho-giddyup.s3.amazonaws.com/500.log	riak-1.2.1-81-ge681ace-master
501	t	\N	297	4	2012-11-19 21:55:10.194065	2012-11-19 21:55:10.194065	https://basho-giddyup.s3.amazonaws.com/501.log	riak-1.2.1-81-ge681ace-master
502	t	\N	333	4	2012-11-19 22:41:56.709271	2012-11-19 22:41:56.709271	https://basho-giddyup.s3.amazonaws.com/502.log	riak-1.2.1-81-ge681ace-master
503	f	\N	353	4	2012-11-19 22:42:09.031887	2012-11-19 22:42:09.031887	https://basho-giddyup.s3.amazonaws.com/503.log	riak-1.2.1-81-ge681ace-master
504	f	\N	7	4	2012-11-19 23:10:28.004368	2012-11-19 23:10:28.004368	https://basho-giddyup.s3.amazonaws.com/504.log	riak-1.2.1-81-gd414744-master
505	f	\N	17	4	2012-11-19 23:15:42.898325	2012-11-19 23:15:42.898325	https://basho-giddyup.s3.amazonaws.com/505.log	riak-1.2.1-81-gd414744-master
506	f	\N	27	4	2012-11-19 23:20:59.870972	2012-11-19 23:20:59.870972	https://basho-giddyup.s3.amazonaws.com/506.log	riak-1.2.1-81-gd414744-master
507	f	\N	37	4	2012-11-19 23:26:16.000636	2012-11-19 23:26:16.000636	https://basho-giddyup.s3.amazonaws.com/507.log	riak-1.2.1-81-gd414744-master
508	f	\N	47	4	2012-11-19 23:31:29.402748	2012-11-19 23:31:29.402748	https://basho-giddyup.s3.amazonaws.com/508.log	riak-1.2.1-81-gd414744-master
509	f	\N	57	4	2012-11-19 23:36:45.930316	2012-11-19 23:36:45.930316	https://basho-giddyup.s3.amazonaws.com/509.log	riak-1.2.1-81-gd414744-master
510	f	\N	67	4	2012-11-19 23:36:54.239412	2012-11-19 23:36:54.239412	https://basho-giddyup.s3.amazonaws.com/510.log	riak-1.2.1-81-gd414744-master
511	f	\N	87	4	2012-11-19 23:42:11.431195	2012-11-19 23:42:11.431195	https://basho-giddyup.s3.amazonaws.com/511.log	riak-1.2.1-81-gd414744-master
512	f	\N	97	4	2012-11-19 23:42:22.995978	2012-11-19 23:42:22.995978	https://basho-giddyup.s3.amazonaws.com/512.log	riak-1.2.1-81-gd414744-master
513	f	\N	107	4	2012-11-19 23:47:37.941163	2012-11-19 23:47:37.941163	https://basho-giddyup.s3.amazonaws.com/513.log	riak-1.2.1-81-gd414744-master
514	f	\N	117	4	2012-11-19 23:47:49.913228	2012-11-19 23:47:49.913228	https://basho-giddyup.s3.amazonaws.com/514.log	riak-1.2.1-81-gd414744-master
515	f	\N	127	4	2012-11-19 23:53:06.679982	2012-11-19 23:53:06.679982	https://basho-giddyup.s3.amazonaws.com/515.log	riak-1.2.1-81-gd414744-master
516	f	\N	137	4	2012-11-19 23:58:22.928057	2012-11-19 23:58:22.928057	https://basho-giddyup.s3.amazonaws.com/516.log	riak-1.2.1-81-gd414744-master
517	f	\N	147	4	2012-11-20 00:03:35.996068	2012-11-20 00:03:35.996068	https://basho-giddyup.s3.amazonaws.com/517.log	riak-1.2.1-81-gd414744-master
518	f	\N	157	4	2012-11-20 00:03:45.786811	2012-11-20 00:03:45.786811	https://basho-giddyup.s3.amazonaws.com/518.log	riak-1.2.1-81-gd414744-master
519	f	\N	167	4	2012-11-20 00:09:04.261069	2012-11-20 00:09:04.261069	https://basho-giddyup.s3.amazonaws.com/519.log	riak-1.2.1-81-gd414744-master
520	f	\N	183	4	2012-11-20 00:14:30.906301	2012-11-20 00:14:30.906301	https://basho-giddyup.s3.amazonaws.com/520.log	riak-1.2.1-81-gd414744-master
521	f	\N	184	4	2012-11-20 00:14:41.06424	2012-11-20 00:14:41.06424	https://basho-giddyup.s3.amazonaws.com/521.log	riak-1.2.1-81-gd414744-master
522	f	\N	237	4	2012-11-20 00:14:50.205325	2012-11-20 00:14:50.205325	https://basho-giddyup.s3.amazonaws.com/522.log	riak-1.2.1-81-gd414744-master
523	f	\N	249	4	2012-11-20 00:15:00.873352	2012-11-20 00:15:00.873352	https://basho-giddyup.s3.amazonaws.com/523.log	riak-1.2.1-81-gd414744-master
524	f	\N	261	4	2012-11-20 00:20:11.136634	2012-11-20 00:20:11.136634	https://basho-giddyup.s3.amazonaws.com/524.log	riak-1.2.1-81-gd414744-master
525	f	\N	273	4	2012-11-20 00:20:22.757625	2012-11-20 00:20:22.757625	https://basho-giddyup.s3.amazonaws.com/525.log	riak-1.2.1-81-gd414744-master
526	f	\N	285	4	2012-11-20 00:25:33.147221	2012-11-20 00:25:33.147221	https://basho-giddyup.s3.amazonaws.com/526.log	riak-1.2.1-81-gd414744-master
527	f	\N	304	4	2012-11-20 00:25:37.530731	2012-11-20 00:25:37.530731	https://basho-giddyup.s3.amazonaws.com/527.log	riak-1.2.1-81-gd414744-master
528	f	\N	338	4	2012-11-20 00:25:41.949726	2012-11-20 00:25:41.949726	https://basho-giddyup.s3.amazonaws.com/528.log	riak-1.2.1-81-gd414744-master
529	f	\N	305	4	2012-11-20 00:25:45.852508	2012-11-20 00:25:45.852508	https://basho-giddyup.s3.amazonaws.com/529.log	riak-1.2.1-81-gd414744-master
530	f	\N	339	4	2012-11-20 00:25:49.70601	2012-11-20 00:25:49.70601	https://basho-giddyup.s3.amazonaws.com/530.log	riak-1.2.1-81-gd414744-master
531	f	\N	355	4	2012-11-20 00:25:58.866503	2012-11-20 00:25:58.866503	https://basho-giddyup.s3.amazonaws.com/531.log	riak-1.2.1-81-gd414744-master
532	t	\N	7	4	2012-11-20 00:51:59.984848	2012-11-20 00:51:59.984848	https://basho-giddyup.s3.amazonaws.com/532.log	riak-1.2.1-81-gd414744-master
533	f	\N	17	4	2012-11-20 00:52:30.634413	2012-11-20 00:52:30.634413	https://basho-giddyup.s3.amazonaws.com/533.log	riak-1.2.1-81-gd414744-master
534	t	\N	27	4	2012-11-20 00:53:24.342904	2012-11-20 00:53:24.342904	https://basho-giddyup.s3.amazonaws.com/534.log	riak-1.2.1-81-gd414744-master
535	t	\N	37	4	2012-11-20 00:54:32.644879	2012-11-20 00:54:32.644879	https://basho-giddyup.s3.amazonaws.com/535.log	riak-1.2.1-81-gd414744-master
536	f	\N	47	4	2012-11-20 00:54:42.106432	2012-11-20 00:54:42.106432	https://basho-giddyup.s3.amazonaws.com/536.log	riak-1.2.1-81-gd414744-master
537	t	\N	57	4	2012-11-20 01:00:38.263294	2012-11-20 01:00:38.263294	https://basho-giddyup.s3.amazonaws.com/537.log	riak-1.2.1-81-gd414744-master
538	t	\N	67	4	2012-11-20 01:05:56.726581	2012-11-20 01:05:56.726581	https://basho-giddyup.s3.amazonaws.com/538.log	riak-1.2.1-81-gd414744-master
539	f	\N	87	4	2012-11-20 01:06:51.115025	2012-11-20 01:06:51.115025	https://basho-giddyup.s3.amazonaws.com/539.log	riak-1.2.1-81-gd414744-master
540	f	\N	97	4	2012-11-20 01:12:09.385369	2012-11-20 01:12:09.385369	https://basho-giddyup.s3.amazonaws.com/540.log	riak-1.2.1-81-gd414744-master
541	t	\N	107	4	2012-11-20 01:34:05.121498	2012-11-20 01:34:05.121498	https://basho-giddyup.s3.amazonaws.com/541.log	riak-1.2.1-81-gd414744-master
542	f	\N	117	4	2012-11-20 01:34:40.931622	2012-11-20 01:34:40.931622	https://basho-giddyup.s3.amazonaws.com/542.log	riak-1.2.1-81-gd414744-master
543	t	\N	127	4	2012-11-20 01:40:27.34046	2012-11-20 01:40:27.34046	https://basho-giddyup.s3.amazonaws.com/543.log	riak-1.2.1-81-gd414744-master
544	t	\N	137	4	2012-11-20 01:43:17.447991	2012-11-20 01:43:17.447991	https://basho-giddyup.s3.amazonaws.com/544.log	riak-1.2.1-81-gd414744-master
545	t	\N	147	4	2012-11-20 01:43:34.091817	2012-11-20 01:43:34.091817	https://basho-giddyup.s3.amazonaws.com/545.log	riak-1.2.1-81-gd414744-master
546	t	\N	157	4	2012-11-20 01:49:39.061193	2012-11-20 01:49:39.061193	https://basho-giddyup.s3.amazonaws.com/546.log	riak-1.2.1-81-gd414744-master
547	t	\N	167	4	2012-11-20 01:51:58.933636	2012-11-20 01:51:58.933636	https://basho-giddyup.s3.amazonaws.com/547.log	riak-1.2.1-81-gd414744-master
548	f	\N	183	4	2012-11-20 01:52:11.759267	2012-11-20 01:52:11.759267	https://basho-giddyup.s3.amazonaws.com/548.log	riak-1.2.1-81-gd414744-master
549	t	\N	184	4	2012-11-20 01:53:01.23005	2012-11-20 01:53:01.23005	https://basho-giddyup.s3.amazonaws.com/549.log	riak-1.2.1-81-gd414744-master
550	f	\N	237	4	2012-11-20 01:56:24.929185	2012-11-20 01:56:24.929185	https://basho-giddyup.s3.amazonaws.com/550.log	riak-1.2.1-81-gd414744-master
551	f	\N	249	4	2012-11-20 01:59:39.680644	2012-11-20 01:59:39.680644	https://basho-giddyup.s3.amazonaws.com/551.log	riak-1.2.1-81-gd414744-master
552	f	\N	261	4	2012-11-20 01:59:44.558409	2012-11-20 01:59:44.558409	https://basho-giddyup.s3.amazonaws.com/552.log	riak-1.2.1-81-gd414744-master
553	f	\N	273	4	2012-11-20 02:00:02.542261	2012-11-20 02:00:02.542261	https://basho-giddyup.s3.amazonaws.com/553.log	riak-1.2.1-81-gd414744-master
554	f	\N	285	4	2012-11-20 02:05:12.749936	2012-11-20 02:05:12.749936	https://basho-giddyup.s3.amazonaws.com/554.log	riak-1.2.1-81-gd414744-master
555	f	\N	304	4	2012-11-20 02:05:16.835025	2012-11-20 02:05:16.835025	https://basho-giddyup.s3.amazonaws.com/555.log	riak-1.2.1-81-gd414744-master
556	f	\N	338	4	2012-11-20 02:05:21.103919	2012-11-20 02:05:21.103919	https://basho-giddyup.s3.amazonaws.com/556.log	riak-1.2.1-81-gd414744-master
557	f	\N	305	4	2012-11-20 02:05:25.093152	2012-11-20 02:05:25.093152	https://basho-giddyup.s3.amazonaws.com/557.log	riak-1.2.1-81-gd414744-master
558	f	\N	339	4	2012-11-20 02:05:29.491673	2012-11-20 02:05:29.491673	https://basho-giddyup.s3.amazonaws.com/558.log	riak-1.2.1-81-gd414744-master
559	f	\N	355	4	2012-11-20 02:06:12.144785	2012-11-20 02:06:12.144785	https://basho-giddyup.s3.amazonaws.com/559.log	riak-1.2.1-81-gd414744-master
663	t	\N	245	4	2012-11-21 15:39:53.399548	2012-11-21 15:39:53.399548	https://basho-giddyup.s3.amazonaws.com/663.log	riak-1.2.1-81-ge681ace-master
664	f	\N	257	4	2012-11-21 15:40:00.33894	2012-11-21 15:40:00.33894	https://basho-giddyup.s3.amazonaws.com/664.log	riak-1.2.1-81-ge681ace-master
665	f	\N	269	4	2012-11-21 15:41:37.733842	2012-11-21 15:41:37.733842	https://basho-giddyup.s3.amazonaws.com/665.log	riak-1.2.1-81-ge681ace-master
666	f	\N	281	4	2012-11-21 15:47:54.268861	2012-11-21 15:47:54.268861	https://basho-giddyup.s3.amazonaws.com/666.log	riak-1.2.1-81-ge681ace-master
667	t	\N	296	4	2012-11-21 16:19:26.796385	2012-11-21 16:19:26.796385	https://basho-giddyup.s3.amazonaws.com/667.log	riak-1.2.1-81-ge681ace-master
759	t	\N	304	4	2012-11-28 20:20:09.919437	2012-11-28 20:20:09.919437	https://basho-giddyup.s3.amazonaws.com/759.log	riak-1.2.1-81-gd414744-master
760	f	\N	338	4	2012-11-28 20:20:34.460741	2012-11-28 20:20:34.460741	https://basho-giddyup.s3.amazonaws.com/760.log	riak-1.2.1-81-gd414744-master
761	t	\N	305	4	2012-11-28 20:55:15.573683	2012-11-28 20:55:15.573683	https://basho-giddyup.s3.amazonaws.com/761.log	riak-1.2.1-81-gd414744-master
762	t	\N	339	4	2012-11-28 21:33:08.290846	2012-11-28 21:33:08.290846	https://basho-giddyup.s3.amazonaws.com/762.log	riak-1.2.1-81-gd414744-master
763	f	\N	355	4	2012-11-28 21:34:02.466376	2012-11-28 21:34:02.466376	https://basho-giddyup.s3.amazonaws.com/763.log	riak-1.2.1-81-gd414744-master
765	f	\N	17	4	2012-11-29 02:59:57.160156	2012-11-29 02:59:57.160156	https://basho-giddyup.s3.amazonaws.com/765.log	riak-1.2.1-81-gd414744-master
766	f	\N	27	4	2012-11-29 03:00:30.951996	2012-11-29 03:00:30.951996	https://basho-giddyup.s3.amazonaws.com/766.log	riak-1.2.1-81-gd414744-master
767	t	\N	37	4	2012-11-29 03:01:36.628851	2012-11-29 03:01:36.628851	https://basho-giddyup.s3.amazonaws.com/767.log	riak-1.2.1-81-gd414744-master
768	f	\N	47	4	2012-11-29 03:02:01.984818	2012-11-29 03:02:01.984818	https://basho-giddyup.s3.amazonaws.com/768.log	riak-1.2.1-81-gd414744-master
769	t	\N	57	4	2012-11-29 03:02:51.575007	2012-11-29 03:02:51.575007	https://basho-giddyup.s3.amazonaws.com/769.log	riak-1.2.1-81-gd414744-master
770	t	\N	67	4	2012-11-29 03:03:12.603362	2012-11-29 03:03:12.603362	https://basho-giddyup.s3.amazonaws.com/770.log	riak-1.2.1-81-gd414744-master
771	f	\N	87	4	2012-11-29 03:04:03.510106	2012-11-29 03:04:03.510106	https://basho-giddyup.s3.amazonaws.com/771.log	riak-1.2.1-81-gd414744-master
772	t	\N	97	4	2012-11-29 03:15:25.365849	2012-11-29 03:15:25.365849	https://basho-giddyup.s3.amazonaws.com/772.log	riak-1.2.1-81-gd414744-master
773	f	\N	107	4	2012-11-29 03:15:51.614358	2012-11-29 03:15:51.614358	https://basho-giddyup.s3.amazonaws.com/773.log	riak-1.2.1-81-gd414744-master
774	f	\N	117	4	2012-11-29 03:21:16.062757	2012-11-29 03:21:16.062757	https://basho-giddyup.s3.amazonaws.com/774.log	riak-1.2.1-81-gd414744-master
775	t	\N	127	4	2012-11-29 03:26:56.662586	2012-11-29 03:26:56.662586	https://basho-giddyup.s3.amazonaws.com/775.log	riak-1.2.1-81-gd414744-master
776	f	\N	137	4	2012-11-29 03:27:19.859521	2012-11-29 03:27:19.859521	https://basho-giddyup.s3.amazonaws.com/776.log	riak-1.2.1-81-gd414744-master
777	t	\N	147	4	2012-11-29 03:32:47.950502	2012-11-29 03:32:47.950502	https://basho-giddyup.s3.amazonaws.com/777.log	riak-1.2.1-81-gd414744-master
778	t	\N	157	4	2012-11-29 03:33:58.070948	2012-11-29 03:33:58.070948	https://basho-giddyup.s3.amazonaws.com/778.log	riak-1.2.1-81-gd414744-master
779	t	\N	167	4	2012-11-29 03:36:15.172125	2012-11-29 03:36:15.172125	https://basho-giddyup.s3.amazonaws.com/779.log	riak-1.2.1-81-gd414744-master
780	t	\N	183	4	2012-11-29 03:36:41.538072	2012-11-29 03:36:41.538072	https://basho-giddyup.s3.amazonaws.com/780.log	riak-1.2.1-81-gd414744-master
781	t	\N	184	4	2012-11-29 03:37:36.499143	2012-11-29 03:37:36.499143	https://basho-giddyup.s3.amazonaws.com/781.log	riak-1.2.1-81-gd414744-master
782	t	\N	237	4	2012-11-29 03:38:12.510252	2012-11-29 03:38:12.510252	https://basho-giddyup.s3.amazonaws.com/782.log	riak-1.2.1-81-gd414744-master
560	f	\N	7	4	2012-11-20 14:57:59.553356	2012-11-20 14:57:59.553356	https://basho-giddyup.s3.amazonaws.com/560.log	riak-1.2.1-81-gd414744-master
561	f	\N	17	4	2012-11-20 15:03:33.318903	2012-11-20 15:03:33.318903	https://basho-giddyup.s3.amazonaws.com/561.log	riak-1.2.1-81-gd414744-master
562	f	\N	27	4	2012-11-20 15:09:19.395105	2012-11-20 15:09:19.395105	https://basho-giddyup.s3.amazonaws.com/562.log	riak-1.2.1-81-gd414744-master
563	t	\N	37	4	2012-11-20 15:10:25.09606	2012-11-20 15:10:25.09606	https://basho-giddyup.s3.amazonaws.com/563.log	riak-1.2.1-81-gd414744-master
564	f	\N	47	4	2012-11-20 15:10:38.038317	2012-11-20 15:10:38.038317	https://basho-giddyup.s3.amazonaws.com/564.log	riak-1.2.1-81-gd414744-master
585	t	\N	305	4	2012-11-20 17:56:37.133642	2012-11-20 17:56:37.133642	https://basho-giddyup.s3.amazonaws.com/585.log	riak-1.2.1-81-gd414744-master
586	t	\N	339	4	2012-11-20 18:32:00.577063	2012-11-20 18:32:00.577063	https://basho-giddyup.s3.amazonaws.com/586.log	riak-1.2.1-81-gd414744-master
587	f	\N	355	4	2012-11-20 18:32:49.93595	2012-11-20 18:32:49.93595	https://basho-giddyup.s3.amazonaws.com/587.log	riak-1.2.1-81-gd414744-master
588	t	\N	7	4	2012-11-20 21:44:40.011047	2012-11-20 21:44:40.011047	https://basho-giddyup.s3.amazonaws.com/588.log	riak-1.2.1-81-gd414744-master
589	f	\N	17	4	2012-11-20 21:45:10.521092	2012-11-20 21:45:10.521092	https://basho-giddyup.s3.amazonaws.com/589.log	riak-1.2.1-81-gd414744-master
590	f	\N	27	4	2012-11-20 21:46:01.13249	2012-11-20 21:46:01.13249	https://basho-giddyup.s3.amazonaws.com/590.log	riak-1.2.1-81-gd414744-master
668	t	\N	332	4	2012-11-21 16:54:22.278162	2012-11-21 16:54:22.278162	https://basho-giddyup.s3.amazonaws.com/668.log	riak-1.2.1-81-ge681ace-master
669	t	\N	297	4	2012-11-21 17:33:42.338642	2012-11-21 17:33:42.338642	https://basho-giddyup.s3.amazonaws.com/669.log	riak-1.2.1-81-ge681ace-master
670	t	\N	333	4	2012-11-21 18:13:31.702116	2012-11-21 18:13:31.702116	https://basho-giddyup.s3.amazonaws.com/670.log	riak-1.2.1-81-ge681ace-master
671	f	\N	353	4	2012-11-21 18:14:16.86754	2012-11-21 18:14:16.86754	https://basho-giddyup.s3.amazonaws.com/671.log	riak-1.2.1-81-ge681ace-master
672	t	\N	192	4	2012-11-21 21:32:12.279962	2012-11-21 21:32:12.279962	https://basho-giddyup.s3.amazonaws.com/672.log	riak-1.2.1-81-ge681ace-master
673	f	\N	193	4	2012-11-21 21:32:33.020387	2012-11-21 21:32:33.020387	https://basho-giddyup.s3.amazonaws.com/673.log	riak-1.2.1-81-ge681ace-master
674	t	\N	194	4	2012-11-21 21:33:09.911498	2012-11-21 21:33:09.911498	https://basho-giddyup.s3.amazonaws.com/674.log	riak-1.2.1-81-ge681ace-master
675	f	\N	195	4	2012-11-21 21:33:31.266618	2012-11-21 21:33:31.266618	https://basho-giddyup.s3.amazonaws.com/675.log	riak-1.2.1-81-ge681ace-master
676	f	\N	196	4	2012-11-21 21:34:00.814354	2012-11-21 21:34:00.814354	https://basho-giddyup.s3.amazonaws.com/676.log	riak-1.2.1-81-ge681ace-master
677	t	\N	197	4	2012-11-21 21:35:00.024173	2012-11-21 21:35:00.024173	https://basho-giddyup.s3.amazonaws.com/677.log	riak-1.2.1-81-ge681ace-master
678	t	\N	198	4	2012-11-21 21:40:16.698594	2012-11-21 21:40:16.698594	https://basho-giddyup.s3.amazonaws.com/678.log	riak-1.2.1-81-ge681ace-master
679	t	\N	201	4	2012-11-21 21:40:33.176741	2012-11-21 21:40:33.176741	https://basho-giddyup.s3.amazonaws.com/679.log	riak-1.2.1-81-ge681ace-master
680	f	\N	202	4	2012-11-21 21:40:39.333142	2012-11-21 21:40:39.333142	https://basho-giddyup.s3.amazonaws.com/680.log	riak-1.2.1-81-ge681ace-master
681	t	\N	203	4	2012-11-21 21:41:05.842262	2012-11-21 21:41:05.842262	https://basho-giddyup.s3.amazonaws.com/681.log	riak-1.2.1-81-ge681ace-master
682	t	\N	204	4	2012-11-21 21:41:43.791003	2012-11-21 21:41:43.791003	https://basho-giddyup.s3.amazonaws.com/682.log	riak-1.2.1-81-ge681ace-master
683	t	\N	205	4	2012-11-21 21:43:41.631114	2012-11-21 21:43:41.631114	https://basho-giddyup.s3.amazonaws.com/683.log	riak-1.2.1-81-ge681ace-master
684	t	\N	206	4	2012-11-21 21:48:58.847484	2012-11-21 21:48:58.847484	https://basho-giddyup.s3.amazonaws.com/684.log	riak-1.2.1-81-ge681ace-master
685	f	\N	207	4	2012-11-21 21:49:18.248823	2012-11-21 21:49:18.248823	https://basho-giddyup.s3.amazonaws.com/685.log	riak-1.2.1-81-ge681ace-master
686	t	\N	208	4	2012-11-21 21:51:51.86569	2012-11-21 21:51:51.86569	https://basho-giddyup.s3.amazonaws.com/686.log	riak-1.2.1-81-ge681ace-master
687	t	\N	209	4	2012-11-21 21:52:18.546522	2012-11-21 21:52:18.546522	https://basho-giddyup.s3.amazonaws.com/687.log	riak-1.2.1-81-ge681ace-master
688	t	\N	210	4	2012-11-21 21:52:44.829719	2012-11-21 21:52:44.829719	https://basho-giddyup.s3.amazonaws.com/688.log	riak-1.2.1-81-ge681ace-master
689	f	\N	241	4	2012-11-21 22:01:15.540366	2012-11-21 22:01:15.540366	https://basho-giddyup.s3.amazonaws.com/689.log	riak-1.2.1-81-ge681ace-master
690	t	\N	192	4	2012-11-21 22:32:26.065708	2012-11-21 22:32:26.065708	https://basho-giddyup.s3.amazonaws.com/690.log	riak-1.2.1-81-ge681ace-master
691	f	\N	193	4	2012-11-21 22:32:47.892774	2012-11-21 22:32:47.892774	https://basho-giddyup.s3.amazonaws.com/691.log	riak-1.2.1-81-ge681ace-master
692	t	\N	194	4	2012-11-21 22:38:33.092023	2012-11-21 22:38:33.092023	https://basho-giddyup.s3.amazonaws.com/692.log	riak-1.2.1-81-ge681ace-master
693	f	\N	195	4	2012-11-21 22:38:53.919033	2012-11-21 22:38:53.919033	https://basho-giddyup.s3.amazonaws.com/693.log	riak-1.2.1-81-ge681ace-master
694	f	\N	196	4	2012-11-21 22:39:12.923784	2012-11-21 22:39:12.923784	https://basho-giddyup.s3.amazonaws.com/694.log	riak-1.2.1-81-ge681ace-master
695	t	\N	197	4	2012-11-21 22:40:02.994817	2012-11-21 22:40:02.994817	https://basho-giddyup.s3.amazonaws.com/695.log	riak-1.2.1-81-ge681ace-master
696	t	\N	198	4	2012-11-21 22:45:20.280268	2012-11-21 22:45:20.280268	https://basho-giddyup.s3.amazonaws.com/696.log	riak-1.2.1-81-ge681ace-master
697	t	\N	201	4	2012-11-21 22:45:37.236922	2012-11-21 22:45:37.236922	https://basho-giddyup.s3.amazonaws.com/697.log	riak-1.2.1-81-ge681ace-master
1	f	\N	4	1	2012-09-27 05:50:16.333554	2012-11-15 17:39:37.43795	https://basho-giddyup.s3.amazonaws.com/1.log	riak-1.2.1rc2-(no
2	t	\N	14	1	2012-09-27 05:50:51.241147	2012-11-15 17:39:37.53292	https://basho-giddyup.s3.amazonaws.com/2.log	riak-1.2.1rc2-(no
3	t	\N	24	1	2012-09-27 05:56:38.105351	2012-11-15 17:39:37.545283	https://basho-giddyup.s3.amazonaws.com/3.log	riak-1.2.1rc2-(no
4	f	\N	34	1	2012-09-27 05:56:55.839232	2012-11-15 17:39:37.548536	https://basho-giddyup.s3.amazonaws.com/4.log	riak-1.2.1rc2-(no
5	t	\N	44	1	2012-09-27 05:57:24.367644	2012-11-15 17:39:37.552852	https://basho-giddyup.s3.amazonaws.com/5.log	riak-1.2.1rc2-(no
6	t	\N	54	1	2012-09-27 05:58:11.141205	2012-11-15 17:39:37.560706	https://basho-giddyup.s3.amazonaws.com/6.log	riak-1.2.1rc2-(no
7	t	\N	64	1	2012-09-27 05:58:22.309769	2012-11-15 17:39:37.563996	https://basho-giddyup.s3.amazonaws.com/7.log	riak-1.2.1rc2-(no
8	f	\N	74	1	2012-09-27 06:01:45.005532	2012-11-15 17:39:37.569363	https://basho-giddyup.s3.amazonaws.com/8.log	riak-1.2.1rc2-(no
9	f	\N	84	1	2012-09-27 06:05:09.143696	2012-11-15 17:39:37.573039	https://basho-giddyup.s3.amazonaws.com/9.log	riak-1.2.1rc2-(no
10	t	\N	94	1	2012-09-27 06:05:36.95114	2012-11-15 17:39:37.582319	https://basho-giddyup.s3.amazonaws.com/10.log	riak-1.2.1rc2-(no
11	f	\N	104	1	2012-09-27 06:05:41.655916	2012-11-15 17:39:37.585068	https://basho-giddyup.s3.amazonaws.com/11.log	riak-1.2.1rc2-(no
12	t	\N	114	1	2012-09-27 06:06:03.108755	2012-11-15 17:39:37.587792	https://basho-giddyup.s3.amazonaws.com/12.log	riak-1.2.1rc2-(no
13	t	\N	124	1	2012-09-27 06:06:39.659652	2012-11-15 17:39:37.591083	https://basho-giddyup.s3.amazonaws.com/13.log	riak-1.2.1rc2-(no
14	t	\N	134	1	2012-09-27 06:08:37.748284	2012-11-15 17:39:37.594213	https://basho-giddyup.s3.amazonaws.com/14.log	riak-1.2.1rc2-(no
15	t	\N	144	1	2012-09-27 06:13:52.306433	2012-11-15 17:39:37.59719	https://basho-giddyup.s3.amazonaws.com/15.log	riak-1.2.1rc2-(no
16	t	\N	154	1	2012-09-27 06:14:48.922363	2012-11-15 17:39:37.602106	https://basho-giddyup.s3.amazonaws.com/16.log	riak-1.2.1rc2-(no
17	t	\N	164	1	2012-09-27 06:17:06.62022	2012-11-15 17:39:37.607375	https://basho-giddyup.s3.amazonaws.com/17.log	riak-1.2.1rc2-(no
18	t	\N	177	1	2012-09-27 06:17:29.227875	2012-11-15 17:39:37.614146	https://basho-giddyup.s3.amazonaws.com/18.log	riak-1.2.1rc2-(no
19	t	\N	178	1	2012-09-27 06:18:02.251633	2012-11-15 17:39:37.617753	https://basho-giddyup.s3.amazonaws.com/19.log	riak-1.2.1rc2-(no
20	f	\N	3	1	2012-09-27 13:34:02.82691	2012-11-15 17:39:37.62447	https://basho-giddyup.s3.amazonaws.com/20.log	riak-1.2.1rc2-(no
21	t	\N	13	1	2012-09-27 13:34:31.905255	2012-11-15 17:39:37.627284	https://basho-giddyup.s3.amazonaws.com/21.log	riak-1.2.1rc2-(no
22	t	\N	23	1	2012-09-27 13:35:11.669037	2012-11-15 17:39:37.629631	https://basho-giddyup.s3.amazonaws.com/22.log	riak-1.2.1rc2-(no
23	f	\N	33	1	2012-09-27 13:35:24.496812	2012-11-15 17:39:37.631937	https://basho-giddyup.s3.amazonaws.com/23.log	riak-1.2.1rc2-(no
24	t	\N	43	1	2012-09-27 13:35:53.255782	2012-11-15 17:39:37.635083	https://basho-giddyup.s3.amazonaws.com/24.log	riak-1.2.1rc2-(no
25	t	\N	53	1	2012-09-27 13:36:30.184362	2012-11-15 17:39:37.639694	https://basho-giddyup.s3.amazonaws.com/25.log	riak-1.2.1rc2-(no
26	t	\N	63	1	2012-09-27 13:41:48.379006	2012-11-15 17:39:37.64225	https://basho-giddyup.s3.amazonaws.com/26.log	riak-1.2.1rc2-(no
27	t	\N	73	1	2012-09-27 13:42:12.663342	2012-11-15 17:39:37.644669	https://basho-giddyup.s3.amazonaws.com/27.log	riak-1.2.1rc2-(no
28	f	\N	83	1	2012-09-27 13:42:59.345864	2012-11-15 17:39:37.650316	https://basho-giddyup.s3.amazonaws.com/28.log	riak-1.2.1rc2-(no
29	t	\N	93	1	2012-09-27 13:43:19.40925	2012-11-15 17:39:37.664314	https://basho-giddyup.s3.amazonaws.com/29.log	riak-1.2.1rc2-(no
30	f	\N	103	1	2012-09-27 13:43:27.402306	2012-11-15 17:39:37.666803	https://basho-giddyup.s3.amazonaws.com/30.log	riak-1.2.1rc2-(no
31	t	\N	113	1	2012-09-27 13:43:49.114172	2012-11-15 17:39:37.815912	https://basho-giddyup.s3.amazonaws.com/31.log	riak-1.2.1rc2-(no
32	t	\N	123	1	2012-09-27 13:45:08.717744	2012-11-15 17:39:37.818505	https://basho-giddyup.s3.amazonaws.com/32.log	riak-1.2.1rc2-(no
33	t	\N	133	1	2012-09-27 13:47:09.279045	2012-11-15 17:39:37.825135	https://basho-giddyup.s3.amazonaws.com/33.log	riak-1.2.1rc2-(no
34	t	\N	143	1	2012-09-27 13:47:20.188269	2012-11-15 17:39:37.827512	https://basho-giddyup.s3.amazonaws.com/34.log	riak-1.2.1rc2-(no
35	t	\N	153	1	2012-09-27 13:48:17.70162	2012-11-15 17:39:37.830185	https://basho-giddyup.s3.amazonaws.com/35.log	riak-1.2.1rc2-(no
36	t	\N	163	1	2012-09-27 13:50:58.984858	2012-11-15 17:39:37.832707	https://basho-giddyup.s3.amazonaws.com/36.log	riak-1.2.1rc2-(no
37	t	\N	175	1	2012-09-27 13:51:23.838113	2012-11-15 17:39:37.838338	https://basho-giddyup.s3.amazonaws.com/37.log	riak-1.2.1rc2-(no
38	t	\N	176	1	2012-09-27 13:51:51.918206	2012-11-15 17:39:37.840798	https://basho-giddyup.s3.amazonaws.com/38.log	riak-1.2.1rc2-(no
39	f	\N	3	1	2012-09-27 13:53:15.583479	2012-11-15 17:39:37.843123	https://basho-giddyup.s3.amazonaws.com/39.log	riak-1.2.1rc2-(no
40	t	\N	13	1	2012-09-27 13:53:43.667673	2012-11-15 17:39:37.845671	https://basho-giddyup.s3.amazonaws.com/40.log	riak-1.2.1rc2-(no
41	t	\N	23	1	2012-09-27 13:54:28.25964	2012-11-15 17:39:37.847974	https://basho-giddyup.s3.amazonaws.com/41.log	riak-1.2.1rc2-(no
42	f	\N	33	1	2012-09-27 13:54:48.333201	2012-11-15 17:39:37.850152	https://basho-giddyup.s3.amazonaws.com/42.log	riak-1.2.1rc2-(no
43	t	\N	43	1	2012-09-27 13:55:16.700604	2012-11-15 17:39:37.852367	https://basho-giddyup.s3.amazonaws.com/43.log	riak-1.2.1rc2-(no
44	t	\N	53	1	2012-09-27 13:56:03.11878	2012-11-15 17:39:37.85504	https://basho-giddyup.s3.amazonaws.com/44.log	riak-1.2.1rc2-(no
45	t	\N	63	1	2012-09-27 14:01:20.306931	2012-11-15 17:39:37.857479	https://basho-giddyup.s3.amazonaws.com/45.log	riak-1.2.1rc2-(no
46	t	\N	73	1	2012-09-27 14:01:49.944535	2012-11-15 17:39:37.859714	https://basho-giddyup.s3.amazonaws.com/46.log	riak-1.2.1rc2-(no
47	f	\N	3	1	2012-09-27 14:04:53.582442	2012-11-15 17:39:37.86212	https://basho-giddyup.s3.amazonaws.com/47.log	riak-1.2.1rc2-(no
48	t	\N	13	1	2012-09-27 14:05:22.481632	2012-11-15 17:39:37.865796	https://basho-giddyup.s3.amazonaws.com/48.log	riak-1.2.1rc2-(no
49	t	\N	23	1	2012-09-27 14:06:11.938726	2012-11-15 17:39:37.868197	https://basho-giddyup.s3.amazonaws.com/49.log	riak-1.2.1rc2-(no
50	f	\N	33	1	2012-09-27 14:06:52.357061	2012-11-15 17:39:37.875375	https://basho-giddyup.s3.amazonaws.com/50.log	riak-1.2.1rc2-(no
51	t	\N	43	1	2012-09-27 14:07:20.581371	2012-11-15 17:39:37.877656	https://basho-giddyup.s3.amazonaws.com/51.log	riak-1.2.1rc2-(no
52	t	\N	53	1	2012-09-27 14:07:57.358504	2012-11-15 17:39:37.883891	https://basho-giddyup.s3.amazonaws.com/52.log	riak-1.2.1rc2-(no
53	t	\N	63	1	2012-09-27 14:13:16.234896	2012-11-15 17:39:37.886281	https://basho-giddyup.s3.amazonaws.com/53.log	riak-1.2.1rc2-(no
54	t	\N	73	1	2012-09-27 14:13:47.190683	2012-11-15 17:39:37.888749	https://basho-giddyup.s3.amazonaws.com/54.log	riak-1.2.1rc2-(no
55	f	\N	83	1	2012-09-27 14:14:32.033425	2012-11-15 17:39:37.895329	https://basho-giddyup.s3.amazonaws.com/55.log	riak-1.2.1rc2-(no
56	t	\N	93	1	2012-09-27 14:14:52.933699	2012-11-15 17:39:37.900766	https://basho-giddyup.s3.amazonaws.com/56.log	riak-1.2.1rc2-(no
57	f	\N	103	1	2012-09-27 14:14:59.608533	2012-11-15 17:39:37.903639	https://basho-giddyup.s3.amazonaws.com/57.log	riak-1.2.1rc2-(no
58	t	\N	113	1	2012-09-27 14:15:22.90071	2012-11-15 17:39:37.910418	https://basho-giddyup.s3.amazonaws.com/58.log	riak-1.2.1rc2-(no
59	t	\N	123	1	2012-09-27 14:16:13.945127	2012-11-15 17:39:37.913886	https://basho-giddyup.s3.amazonaws.com/59.log	riak-1.2.1rc2-(no
60	t	\N	133	1	2012-09-27 14:18:35.036436	2012-11-15 17:39:37.917239	https://basho-giddyup.s3.amazonaws.com/60.log	riak-1.2.1rc2-(no
61	t	\N	143	1	2012-09-27 14:18:45.939461	2012-11-15 17:39:37.920505	https://basho-giddyup.s3.amazonaws.com/61.log	riak-1.2.1rc2-(no
62	t	\N	153	1	2012-09-27 14:19:50.730616	2012-11-15 17:39:37.924692	https://basho-giddyup.s3.amazonaws.com/62.log	riak-1.2.1rc2-(no
63	t	\N	163	1	2012-09-27 14:22:34.419912	2012-11-15 17:39:37.929358	https://basho-giddyup.s3.amazonaws.com/63.log	riak-1.2.1rc2-(no
64	t	\N	175	1	2012-09-27 14:23:09.949518	2012-11-15 17:39:37.932959	https://basho-giddyup.s3.amazonaws.com/64.log	riak-1.2.1rc2-(no
65	t	\N	176	1	2012-09-27 14:23:46.638273	2012-11-15 17:39:37.937384	https://basho-giddyup.s3.amazonaws.com/65.log	riak-1.2.1rc2-(no
66	f	\N	3	2	2012-09-27 15:40:24.90423	2012-11-15 17:39:37.94074	https://basho-giddyup.s3.amazonaws.com/66.log	unknown
67	t	\N	13	2	2012-09-27 15:40:57.750593	2012-11-15 17:39:37.94453	https://basho-giddyup.s3.amazonaws.com/67.log	unknown
68	t	\N	23	2	2012-09-27 15:41:49.940783	2012-11-15 17:39:37.947832	https://basho-giddyup.s3.amazonaws.com/68.log	unknown
69	f	\N	33	2	2012-09-27 15:47:09.702889	2012-11-15 17:39:37.955813	https://basho-giddyup.s3.amazonaws.com/69.log	unknown
70	t	\N	43	2	2012-09-27 15:47:40.795141	2012-11-15 17:39:37.958876	https://basho-giddyup.s3.amazonaws.com/70.log	unknown
71	t	\N	53	2	2012-09-27 15:48:21.450538	2012-11-15 17:39:37.961428	https://basho-giddyup.s3.amazonaws.com/71.log	unknown
72	t	\N	63	2	2012-09-27 15:48:37.361582	2012-11-15 17:39:37.969589	https://basho-giddyup.s3.amazonaws.com/72.log	unknown
73	t	\N	73	2	2012-09-27 15:49:10.495184	2012-11-15 17:39:37.972495	https://basho-giddyup.s3.amazonaws.com/73.log	unknown
74	f	\N	83	2	2012-09-27 15:49:56.91861	2012-11-15 17:39:37.975157	https://basho-giddyup.s3.amazonaws.com/74.log	unknown
75	t	\N	93	2	2012-09-27 15:50:28.726662	2012-11-15 17:39:37.980187	https://basho-giddyup.s3.amazonaws.com/75.log	unknown
76	f	\N	103	2	2012-09-27 15:50:36.367888	2012-11-15 17:39:37.983874	https://basho-giddyup.s3.amazonaws.com/76.log	unknown
77	t	\N	113	2	2012-09-27 15:51:11.303296	2012-11-15 17:39:37.987023	https://basho-giddyup.s3.amazonaws.com/77.log	unknown
78	t	\N	123	2	2012-09-27 15:56:58.646815	2012-11-15 17:39:37.989664	https://basho-giddyup.s3.amazonaws.com/78.log	unknown
79	t	\N	133	2	2012-09-27 15:58:51.471626	2012-11-15 17:39:37.993739	https://basho-giddyup.s3.amazonaws.com/79.log	unknown
80	t	\N	143	2	2012-09-27 15:59:04.901276	2012-11-15 17:39:37.996911	https://basho-giddyup.s3.amazonaws.com/80.log	unknown
81	t	\N	153	2	2012-09-27 16:00:04.755943	2012-11-15 17:39:37.999735	https://basho-giddyup.s3.amazonaws.com/81.log	unknown
82	t	\N	163	2	2012-09-27 16:02:52.071502	2012-11-15 17:39:38.002481	https://basho-giddyup.s3.amazonaws.com/82.log	unknown
83	t	\N	175	2	2012-09-27 16:03:12.121183	2012-11-15 17:39:38.00515	https://basho-giddyup.s3.amazonaws.com/83.log	unknown
84	t	\N	176	2	2012-09-27 16:03:52.473826	2012-11-15 17:39:38.008743	https://basho-giddyup.s3.amazonaws.com/84.log	unknown
85	f	\N	3	2	2012-09-27 17:36:29.633507	2012-11-15 17:39:38.015325	https://basho-giddyup.s3.amazonaws.com/85.log	unknown
86	t	\N	13	2	2012-09-27 17:37:00.195146	2012-11-15 17:39:38.021018	https://basho-giddyup.s3.amazonaws.com/86.log	unknown
87	t	\N	23	2	2012-09-27 17:37:36.683645	2012-11-15 17:39:38.02392	https://basho-giddyup.s3.amazonaws.com/87.log	unknown
88	t	\N	33	2	2012-09-27 17:43:30.400298	2012-11-15 17:39:38.028575	https://basho-giddyup.s3.amazonaws.com/88.log	unknown
89	t	\N	43	2	2012-09-27 17:43:53.174485	2012-11-15 17:39:38.120367	https://basho-giddyup.s3.amazonaws.com/89.log	unknown
90	t	\N	53	2	2012-09-27 17:44:33.371539	2012-11-15 17:39:38.236381	https://basho-giddyup.s3.amazonaws.com/90.log	unknown
91	t	\N	63	2	2012-09-27 17:44:49.771537	2012-11-15 17:39:38.371377	https://basho-giddyup.s3.amazonaws.com/91.log	unknown
92	t	\N	73	2	2012-09-27 17:45:23.960528	2012-11-15 17:39:38.375265	https://basho-giddyup.s3.amazonaws.com/92.log	unknown
93	f	\N	83	2	2012-09-27 17:46:10.645676	2012-11-15 17:39:38.378149	https://basho-giddyup.s3.amazonaws.com/93.log	unknown
94	t	\N	93	2	2012-09-27 17:46:26.231939	2012-11-15 17:39:38.380958	https://basho-giddyup.s3.amazonaws.com/94.log	unknown
95	f	\N	103	2	2012-09-27 17:46:41.79644	2012-11-15 17:39:38.384775	https://basho-giddyup.s3.amazonaws.com/95.log	unknown
96	t	\N	113	2	2012-09-27 17:47:02.029516	2012-11-15 17:39:38.391812	https://basho-giddyup.s3.amazonaws.com/96.log	unknown
97	t	\N	123	2	2012-09-27 17:47:54.205748	2012-11-15 17:39:38.394893	https://basho-giddyup.s3.amazonaws.com/97.log	unknown
98	t	\N	133	2	2012-09-27 17:49:58.537122	2012-11-15 17:39:38.397465	https://basho-giddyup.s3.amazonaws.com/98.log	unknown
99	t	\N	143	2	2012-09-27 17:50:11.771819	2012-11-15 17:39:38.400024	https://basho-giddyup.s3.amazonaws.com/99.log	unknown
100	t	\N	153	2	2012-09-27 17:51:11.207489	2012-11-15 17:39:38.402905	https://basho-giddyup.s3.amazonaws.com/100.log	unknown
101	t	\N	163	2	2012-09-27 17:53:55.054041	2012-11-15 17:39:38.405542	https://basho-giddyup.s3.amazonaws.com/101.log	unknown
102	t	\N	175	2	2012-09-27 17:54:22.647999	2012-11-15 17:39:38.408108	https://basho-giddyup.s3.amazonaws.com/102.log	unknown
103	t	\N	176	2	2012-09-27 17:55:22.123378	2012-11-15 17:39:38.410571	https://basho-giddyup.s3.amazonaws.com/103.log	unknown
104	t	\N	3	2	2012-09-27 18:19:39.188256	2012-11-15 17:39:38.412975	https://basho-giddyup.s3.amazonaws.com/104.log	unknown
105	t	\N	13	2	2012-09-27 18:20:10.550545	2012-11-15 17:39:38.416299	https://basho-giddyup.s3.amazonaws.com/105.log	unknown
106	t	\N	23	2	2012-09-27 18:20:48.769862	2012-11-15 17:39:38.418869	https://basho-giddyup.s3.amazonaws.com/106.log	unknown
107	f	\N	3	1	2012-09-27 19:20:40.462324	2012-11-15 17:39:38.425074	https://basho-giddyup.s3.amazonaws.com/107.log	riak-1.2.1rc2-(no
108	f	\N	3	1	2012-09-27 19:21:40.386362	2012-11-15 17:39:38.427603	https://basho-giddyup.s3.amazonaws.com/108.log	riak-1.2.1rc2-(no
109	t	\N	3	1	2012-09-27 19:27:43.688356	2012-11-15 17:39:38.430335	https://basho-giddyup.s3.amazonaws.com/109.log	riak-1.2.1rc2-(no
110	t	\N	13	1	2012-09-27 19:28:12.816907	2012-11-15 17:39:38.432699	https://basho-giddyup.s3.amazonaws.com/110.log	riak-1.2.1rc2-(no
111	t	\N	23	1	2012-09-27 19:28:58.074191	2012-11-15 17:39:38.43663	https://basho-giddyup.s3.amazonaws.com/111.log	riak-1.2.1rc2-(no
112	f	\N	33	1	2012-09-27 19:29:18.936585	2012-11-15 17:39:38.439063	https://basho-giddyup.s3.amazonaws.com/112.log	riak-1.2.1rc2-(no
113	t	\N	43	1	2012-09-27 19:29:49.989801	2012-11-15 17:39:38.445357	https://basho-giddyup.s3.amazonaws.com/113.log	riak-1.2.1rc2-(no
114	t	\N	3	1	2012-09-27 19:44:09.425672	2012-11-15 17:39:38.447875	https://basho-giddyup.s3.amazonaws.com/114.log	riak-1.2.1rc2-(no
115	t	\N	13	1	2012-09-27 19:44:38.801709	2012-11-15 17:39:38.450157	https://basho-giddyup.s3.amazonaws.com/115.log	riak-1.2.1rc2-(no
116	t	\N	23	1	2012-09-27 19:45:18.149662	2012-11-15 17:39:38.454018	https://basho-giddyup.s3.amazonaws.com/116.log	riak-1.2.1rc2-(no
117	t	\N	33	1	2012-09-27 19:46:06.203961	2012-11-15 17:39:38.456574	https://basho-giddyup.s3.amazonaws.com/117.log	riak-1.2.1rc2-(no
118	t	\N	43	1	2012-09-27 19:46:59.129059	2012-11-15 17:39:38.459177	https://basho-giddyup.s3.amazonaws.com/118.log	riak-1.2.1rc2-(no
119	t	\N	53	1	2012-09-27 19:47:37.496221	2012-11-15 17:39:38.4616	https://basho-giddyup.s3.amazonaws.com/119.log	riak-1.2.1rc2-(no
120	t	\N	63	1	2012-09-27 19:53:06.408605	2012-11-15 17:39:38.463904	https://basho-giddyup.s3.amazonaws.com/120.log	riak-1.2.1rc2-(no
121	t	\N	73	1	2012-09-27 19:53:35.360912	2012-11-15 17:39:38.466194	https://basho-giddyup.s3.amazonaws.com/121.log	riak-1.2.1rc2-(no
122	f	\N	83	1	2012-09-27 19:54:11.872348	2012-11-15 17:39:38.468481	https://basho-giddyup.s3.amazonaws.com/122.log	riak-1.2.1rc2-(no
123	t	\N	93	1	2012-09-27 19:59:36.680351	2012-11-15 17:39:38.476421	https://basho-giddyup.s3.amazonaws.com/123.log	riak-1.2.1rc2-(no
124	f	\N	103	1	2012-09-27 19:59:42.539959	2012-11-15 17:39:38.603322	https://basho-giddyup.s3.amazonaws.com/124.log	riak-1.2.1rc2-(no
125	t	\N	113	1	2012-09-27 20:00:04.300318	2012-11-15 17:39:38.607087	https://basho-giddyup.s3.amazonaws.com/125.log	riak-1.2.1rc2-(no
126	t	\N	123	1	2012-09-27 20:00:45.117474	2012-11-15 17:39:38.612661	https://basho-giddyup.s3.amazonaws.com/126.log	riak-1.2.1rc2-(no
127	t	\N	133	1	2012-09-27 20:02:47.787557	2012-11-15 17:39:38.617318	https://basho-giddyup.s3.amazonaws.com/127.log	riak-1.2.1rc2-(no
128	t	\N	143	1	2012-09-27 20:02:58.864546	2012-11-15 17:39:38.622525	https://basho-giddyup.s3.amazonaws.com/128.log	riak-1.2.1rc2-(no
129	t	\N	153	1	2012-09-27 20:03:56.715047	2012-11-15 17:39:38.628168	https://basho-giddyup.s3.amazonaws.com/129.log	riak-1.2.1rc2-(no
130	t	\N	163	1	2012-09-27 20:06:38.310504	2012-11-15 17:39:38.635122	https://basho-giddyup.s3.amazonaws.com/130.log	riak-1.2.1rc2-(no
131	t	\N	175	1	2012-09-27 20:07:03.504155	2012-11-15 17:39:38.638858	https://basho-giddyup.s3.amazonaws.com/131.log	riak-1.2.1rc2-(no
132	t	\N	176	1	2012-09-27 20:07:31.439398	2012-11-15 17:39:38.645491	https://basho-giddyup.s3.amazonaws.com/132.log	riak-1.2.1rc2-(no
133	t	\N	4	1	2012-09-27 20:14:28.126489	2012-11-15 17:39:38.649199	https://basho-giddyup.s3.amazonaws.com/133.log	riak-1.2.1rc2-(no
134	t	\N	14	1	2012-09-27 20:20:08.477418	2012-11-15 17:39:38.65596	https://basho-giddyup.s3.amazonaws.com/134.log	riak-1.2.1rc2-(no
135	t	\N	24	1	2012-09-27 20:20:45.38545	2012-11-15 17:39:38.661774	https://basho-giddyup.s3.amazonaws.com/135.log	riak-1.2.1rc2-(no
136	f	\N	34	1	2012-09-27 20:20:53.343226	2012-11-15 17:39:38.666137	https://basho-giddyup.s3.amazonaws.com/136.log	riak-1.2.1rc2-(no
137	t	\N	44	1	2012-09-27 20:21:12.316551	2012-11-15 17:39:38.669606	https://basho-giddyup.s3.amazonaws.com/137.log	riak-1.2.1rc2-(no
138	t	\N	54	1	2012-09-27 20:21:50.316572	2012-11-15 17:39:38.672753	https://basho-giddyup.s3.amazonaws.com/138.log	riak-1.2.1rc2-(no
139	t	\N	64	1	2012-09-27 20:22:01.491706	2012-11-15 17:39:38.680264	https://basho-giddyup.s3.amazonaws.com/139.log	riak-1.2.1rc2-(no
140	f	\N	74	1	2012-09-27 20:25:23.841689	2012-11-15 17:39:38.684122	https://basho-giddyup.s3.amazonaws.com/140.log	riak-1.2.1rc2-(no
141	f	\N	84	1	2012-09-27 20:28:46.957199	2012-11-15 17:39:38.698637	https://basho-giddyup.s3.amazonaws.com/141.log	riak-1.2.1rc2-(no
142	f	\N	94	1	2012-09-27 20:28:55.100798	2012-11-15 17:39:38.757555	https://basho-giddyup.s3.amazonaws.com/142.log	riak-1.2.1rc2-(no
143	f	\N	104	1	2012-09-27 20:28:59.645781	2012-11-15 17:39:38.760325	https://basho-giddyup.s3.amazonaws.com/143.log	riak-1.2.1rc2-(no
144	t	\N	114	1	2012-09-27 20:29:29.424708	2012-11-15 17:39:38.762653	https://basho-giddyup.s3.amazonaws.com/144.log	riak-1.2.1rc2-(no
145	t	\N	124	1	2012-09-27 20:29:56.830072	2012-11-15 17:39:38.766956	https://basho-giddyup.s3.amazonaws.com/145.log	riak-1.2.1rc2-(no
146	t	\N	134	1	2012-09-27 20:32:04.401388	2012-11-15 17:39:38.770575	https://basho-giddyup.s3.amazonaws.com/146.log	riak-1.2.1rc2-(no
147	t	\N	144	1	2012-09-27 20:37:18.7868	2012-11-15 17:39:38.777071	https://basho-giddyup.s3.amazonaws.com/147.log	riak-1.2.1rc2-(no
148	t	\N	154	1	2012-09-27 20:38:15.89335	2012-11-15 17:39:38.779473	https://basho-giddyup.s3.amazonaws.com/148.log	riak-1.2.1rc2-(no
149	t	\N	164	1	2012-09-27 20:40:52.965442	2012-11-15 17:39:38.781784	https://basho-giddyup.s3.amazonaws.com/149.log	riak-1.2.1rc2-(no
150	t	\N	177	1	2012-09-27 20:41:25.899786	2012-11-15 17:39:38.817052	https://basho-giddyup.s3.amazonaws.com/150.log	riak-1.2.1rc2-(no
151	f	\N	178	1	2012-09-27 20:41:34.908244	2012-11-15 17:39:38.822607	https://basho-giddyup.s3.amazonaws.com/151.log	riak-1.2.1rc2-(no
152	t	\N	2	3	2012-09-28 14:57:34.728054	2012-11-15 17:39:38.830444	https://basho-giddyup.s3.amazonaws.com/152.log	riak-1.2.0-42-ga7c83aa-master
153	f	\N	12	3	2012-09-28 14:58:07.257823	2012-11-15 17:39:38.835353	https://basho-giddyup.s3.amazonaws.com/153.log	riak-1.2.0-42-ga7c83aa-master
154	t	\N	22	3	2012-09-28 15:03:54.029818	2012-11-15 17:39:38.842174	https://basho-giddyup.s3.amazonaws.com/154.log	riak-1.2.0-42-ga7c83aa-master
155	f	\N	32	3	2012-09-28 15:04:29.224942	2012-11-15 17:39:38.84901	https://basho-giddyup.s3.amazonaws.com/155.log	riak-1.2.0-42-ga7c83aa-master
156	t	\N	42	3	2012-09-28 15:05:04.788749	2012-11-15 17:39:38.854331	https://basho-giddyup.s3.amazonaws.com/156.log	riak-1.2.0-42-ga7c83aa-master
157	t	\N	52	3	2012-09-28 15:10:52.116548	2012-11-15 17:39:38.859732	https://basho-giddyup.s3.amazonaws.com/157.log	riak-1.2.0-42-ga7c83aa-master
158	t	\N	62	3	2012-09-28 15:11:18.287103	2012-11-15 17:39:38.863074	https://basho-giddyup.s3.amazonaws.com/158.log	riak-1.2.0-42-ga7c83aa-master
159	t	\N	72	3	2012-09-28 15:11:44.690678	2012-11-15 17:39:38.869158	https://basho-giddyup.s3.amazonaws.com/159.log	riak-1.2.0-42-ga7c83aa-master
160	f	\N	82	3	2012-09-28 15:12:31.94882	2012-11-15 17:39:38.87508	https://basho-giddyup.s3.amazonaws.com/160.log	riak-1.2.0-42-ga7c83aa-master
161	t	\N	92	3	2012-09-28 15:13:05.817094	2012-11-15 17:39:38.878694	https://basho-giddyup.s3.amazonaws.com/161.log	riak-1.2.0-42-ga7c83aa-master
162	f	\N	102	3	2012-09-28 15:13:15.0024	2012-11-15 17:39:38.881938	https://basho-giddyup.s3.amazonaws.com/162.log	riak-1.2.0-42-ga7c83aa-master
163	f	\N	112	3	2012-09-28 15:13:22.026613	2012-11-15 17:39:38.885408	https://basho-giddyup.s3.amazonaws.com/163.log	riak-1.2.0-42-ga7c83aa-master
164	t	\N	122	3	2012-09-28 15:14:25.72481	2012-11-15 17:39:38.891124	https://basho-giddyup.s3.amazonaws.com/164.log	riak-1.2.0-42-ga7c83aa-master
165	t	\N	132	3	2012-09-28 15:16:54.456158	2012-11-15 17:39:38.896072	https://basho-giddyup.s3.amazonaws.com/165.log	riak-1.2.0-42-ga7c83aa-master
166	t	\N	142	3	2012-09-28 15:17:13.689324	2012-11-15 17:39:38.992602	https://basho-giddyup.s3.amazonaws.com/166.log	riak-1.2.0-42-ga7c83aa-master
167	t	\N	152	3	2012-09-28 15:18:15.988391	2012-11-15 17:39:39.015938	https://basho-giddyup.s3.amazonaws.com/167.log	riak-1.2.0-42-ga7c83aa-master
168	t	\N	162	3	2012-09-28 15:21:07.178976	2012-11-15 17:39:39.019299	https://basho-giddyup.s3.amazonaws.com/168.log	riak-1.2.0-42-ga7c83aa-master
169	t	\N	173	3	2012-09-28 15:21:45.143837	2012-11-15 17:39:39.022337	https://basho-giddyup.s3.amazonaws.com/169.log	riak-1.2.0-42-ga7c83aa-master
170	t	\N	174	3	2012-09-28 15:22:28.782679	2012-11-15 17:39:39.028006	https://basho-giddyup.s3.amazonaws.com/170.log	riak-1.2.0-42-ga7c83aa-master
171	t	\N	2	3	2012-10-01 19:54:39.099619	2012-11-15 17:39:39.031363	https://basho-giddyup.s3.amazonaws.com/171.log	riak-1.2.0-42-ga7c83aa-master
172	f	\N	12	3	2012-10-01 19:55:11.701136	2012-11-15 17:39:39.035616	https://basho-giddyup.s3.amazonaws.com/172.log	riak-1.2.0-42-ga7c83aa-master
173	t	\N	22	3	2012-10-01 20:01:02.341009	2012-11-15 17:39:39.038578	https://basho-giddyup.s3.amazonaws.com/173.log	riak-1.2.0-42-ga7c83aa-master
174	f	\N	32	3	2012-10-01 20:01:28.615033	2012-11-15 17:39:39.043374	https://basho-giddyup.s3.amazonaws.com/174.log	riak-1.2.0-42-ga7c83aa-master
175	t	\N	42	3	2012-10-01 20:07:20.47483	2012-11-15 17:39:39.046725	https://basho-giddyup.s3.amazonaws.com/175.log	riak-1.2.0-42-ga7c83aa-master
176	t	\N	52	3	2012-10-01 20:13:14.769544	2012-11-15 17:39:39.049822	https://basho-giddyup.s3.amazonaws.com/176.log	riak-1.2.0-42-ga7c83aa-master
177	t	\N	62	3	2012-10-01 20:13:40.939872	2012-11-15 17:39:39.052496	https://basho-giddyup.s3.amazonaws.com/177.log	riak-1.2.0-42-ga7c83aa-master
178	t	\N	72	3	2012-10-01 20:14:07.840482	2012-11-15 17:39:39.055602	https://basho-giddyup.s3.amazonaws.com/178.log	riak-1.2.0-42-ga7c83aa-master
179	f	\N	82	3	2012-10-01 20:14:55.239422	2012-11-15 17:39:39.058548	https://basho-giddyup.s3.amazonaws.com/179.log	riak-1.2.0-42-ga7c83aa-master
180	t	\N	92	3	2012-10-01 20:15:41.642664	2012-11-15 17:39:39.061381	https://basho-giddyup.s3.amazonaws.com/180.log	riak-1.2.0-42-ga7c83aa-master
181	f	\N	102	3	2012-10-01 20:15:54.252731	2012-11-15 17:39:39.065517	https://basho-giddyup.s3.amazonaws.com/181.log	riak-1.2.0-42-ga7c83aa-master
182	t	\N	112	3	2012-10-01 20:16:34.734786	2012-11-15 17:39:39.069145	https://basho-giddyup.s3.amazonaws.com/182.log	riak-1.2.0-42-ga7c83aa-master
183	t	\N	122	3	2012-10-01 20:22:43.672487	2012-11-15 17:39:39.072739	https://basho-giddyup.s3.amazonaws.com/183.log	riak-1.2.0-42-ga7c83aa-master
184	t	\N	132	3	2012-10-01 20:24:52.267424	2012-11-15 17:39:39.089137	https://basho-giddyup.s3.amazonaws.com/184.log	riak-1.2.0-42-ga7c83aa-master
185	t	\N	142	3	2012-10-01 20:25:11.379358	2012-11-15 17:39:39.096267	https://basho-giddyup.s3.amazonaws.com/185.log	riak-1.2.0-42-ga7c83aa-master
186	t	\N	152	3	2012-10-01 20:26:12.862951	2012-11-15 17:39:39.099753	https://basho-giddyup.s3.amazonaws.com/186.log	riak-1.2.0-42-ga7c83aa-master
187	t	\N	162	3	2012-10-01 20:29:05.568752	2012-11-15 17:39:39.102316	https://basho-giddyup.s3.amazonaws.com/187.log	riak-1.2.0-42-ga7c83aa-master
188	t	\N	173	3	2012-10-01 20:29:43.183608	2012-11-15 17:39:39.105166	https://basho-giddyup.s3.amazonaws.com/188.log	riak-1.2.0-42-ga7c83aa-master
189	t	\N	174	3	2012-10-01 20:30:22.104066	2012-11-15 17:39:39.114378	https://basho-giddyup.s3.amazonaws.com/189.log	riak-1.2.0-42-ga7c83aa-master
190	f	\N	192	4	2012-10-29 19:51:14.24547	2012-11-15 17:39:39.119457	https://basho-giddyup.s3.amazonaws.com/190.log	riak-1.2.1-55-gcc3758d-master
191	f	\N	193	4	2012-10-29 19:51:31.575792	2012-11-15 17:39:39.122313	https://basho-giddyup.s3.amazonaws.com/191.log	riak-1.2.1-55-gcc3758d-master
192	f	\N	194	4	2012-10-29 19:51:51.272211	2012-11-15 17:39:39.136305	https://basho-giddyup.s3.amazonaws.com/192.log	riak-1.2.1-55-gcc3758d-master
193	f	\N	195	4	2012-10-29 19:52:11.199156	2012-11-15 17:39:39.202538	https://basho-giddyup.s3.amazonaws.com/193.log	riak-1.2.1-55-gcc3758d-master
194	f	\N	196	4	2012-10-29 19:52:29.547189	2012-11-15 17:39:39.21198	https://basho-giddyup.s3.amazonaws.com/194.log	riak-1.2.1-55-gcc3758d-master
195	f	\N	197	4	2012-10-29 19:52:48.931667	2012-11-15 17:39:39.220368	https://basho-giddyup.s3.amazonaws.com/195.log	riak-1.2.1-55-gcc3758d-master
196	f	\N	198	4	2012-10-29 19:53:02.825284	2012-11-15 17:39:39.226672	https://basho-giddyup.s3.amazonaws.com/196.log	riak-1.2.1-55-gcc3758d-master
197	f	\N	199	4	2012-10-29 19:53:23.92864	2012-11-15 17:39:39.23424	https://basho-giddyup.s3.amazonaws.com/197.log	riak-1.2.1-55-gcc3758d-master
198	f	\N	200	4	2012-10-29 19:53:41.390763	2012-11-15 17:39:39.238817	https://basho-giddyup.s3.amazonaws.com/198.log	riak-1.2.1-55-gcc3758d-master
199	t	\N	192	4	2012-10-29 20:04:34.693673	2012-11-15 17:39:39.243692	https://basho-giddyup.s3.amazonaws.com/199.log	riak-1.2.1-55-gcc3758d-master
200	f	\N	193	4	2012-10-29 20:05:22.476689	2012-11-15 17:39:39.249508	https://basho-giddyup.s3.amazonaws.com/200.log	riak-1.2.1-55-gcc3758d-master
201	t	\N	194	4	2012-10-29 20:06:25.26227	2012-11-15 17:39:39.261936	https://basho-giddyup.s3.amazonaws.com/201.log	riak-1.2.1-55-gcc3758d-master
202	f	\N	195	4	2012-10-29 20:11:58.358276	2012-11-15 17:39:39.26651	https://basho-giddyup.s3.amazonaws.com/202.log	riak-1.2.1-55-gcc3758d-master
203	t	\N	196	4	2012-10-29 20:12:36.172312	2012-11-15 17:39:39.270399	https://basho-giddyup.s3.amazonaws.com/203.log	riak-1.2.1-55-gcc3758d-master
204	t	\N	197	4	2012-10-29 20:18:48.259713	2012-11-15 17:39:39.278459	https://basho-giddyup.s3.amazonaws.com/204.log	riak-1.2.1-55-gcc3758d-master
205	t	\N	198	4	2012-10-29 20:24:25.848639	2012-11-15 17:39:39.28141	https://basho-giddyup.s3.amazonaws.com/205.log	riak-1.2.1-55-gcc3758d-master
206	t	\N	199	4	2012-10-29 20:25:22.092339	2012-11-15 17:39:39.287456	https://basho-giddyup.s3.amazonaws.com/206.log	riak-1.2.1-55-gcc3758d-master
207	f	\N	200	4	2012-10-29 20:32:46.367252	2012-11-15 17:39:39.289978	https://basho-giddyup.s3.amazonaws.com/207.log	riak-1.2.1-55-gcc3758d-master
208	t	\N	201	4	2012-10-29 20:33:23.065036	2012-11-15 17:39:39.292343	https://basho-giddyup.s3.amazonaws.com/208.log	riak-1.2.1-55-gcc3758d-master
209	f	\N	202	4	2012-10-29 20:33:34.64149	2012-11-15 17:39:39.294809	https://basho-giddyup.s3.amazonaws.com/209.log	riak-1.2.1-55-gcc3758d-master
210	t	\N	203	4	2012-10-29 20:34:16.33447	2012-11-15 17:39:39.297272	https://basho-giddyup.s3.amazonaws.com/210.log	riak-1.2.1-55-gcc3758d-master
211	t	\N	204	4	2012-10-29 20:35:03.014723	2012-11-15 17:39:39.299755	https://basho-giddyup.s3.amazonaws.com/211.log	riak-1.2.1-55-gcc3758d-master
212	t	\N	192	4	2012-10-29 21:41:32.903368	2012-11-15 17:39:39.302042	https://basho-giddyup.s3.amazonaws.com/212.log	riak-1.2.1-55-gcc3758d-master
213	f	\N	193	4	2012-10-29 21:42:20.200979	2012-11-15 17:39:39.304776	https://basho-giddyup.s3.amazonaws.com/213.log	riak-1.2.1-55-gcc3758d-master
214	t	\N	194	4	2012-10-29 21:43:20.809461	2012-11-15 17:39:39.310593	https://basho-giddyup.s3.amazonaws.com/214.log	riak-1.2.1-55-gcc3758d-master
215	f	\N	195	4	2012-10-29 21:49:03.954674	2012-11-15 17:39:39.312914	https://basho-giddyup.s3.amazonaws.com/215.log	riak-1.2.1-55-gcc3758d-master
216	t	\N	196	4	2012-10-29 21:54:46.799465	2012-11-15 17:39:39.316066	https://basho-giddyup.s3.amazonaws.com/216.log	riak-1.2.1-55-gcc3758d-master
217	t	\N	197	4	2012-10-29 22:00:57.104344	2012-11-15 17:39:39.318491	https://basho-giddyup.s3.amazonaws.com/217.log	riak-1.2.1-55-gcc3758d-master
218	t	\N	198	4	2012-10-29 22:06:34.076959	2012-11-15 17:39:39.320675	https://basho-giddyup.s3.amazonaws.com/218.log	riak-1.2.1-55-gcc3758d-master
219	t	\N	199	4	2012-10-29 22:07:16.039493	2012-11-15 17:39:39.323043	https://basho-giddyup.s3.amazonaws.com/219.log	riak-1.2.1-55-gcc3758d-master
220	f	\N	200	4	2012-10-29 22:08:00.429666	2012-11-15 17:39:39.32839	https://basho-giddyup.s3.amazonaws.com/220.log	riak-1.2.1-55-gcc3758d-master
221	t	\N	201	4	2012-10-29 22:08:28.077036	2012-11-15 17:39:39.331413	https://basho-giddyup.s3.amazonaws.com/221.log	riak-1.2.1-55-gcc3758d-master
222	f	\N	202	4	2012-10-29 22:08:38.452113	2012-11-15 17:39:39.334829	https://basho-giddyup.s3.amazonaws.com/222.log	riak-1.2.1-55-gcc3758d-master
223	t	\N	203	4	2012-10-29 22:09:12.826978	2012-11-15 17:39:39.337309	https://basho-giddyup.s3.amazonaws.com/223.log	riak-1.2.1-55-gcc3758d-master
224	t	\N	204	4	2012-10-29 22:15:14.864667	2012-11-15 17:39:39.339531	https://basho-giddyup.s3.amazonaws.com/224.log	riak-1.2.1-55-gcc3758d-master
225	t	\N	205	4	2012-10-29 22:17:47.707308	2012-11-15 17:39:39.345709	https://basho-giddyup.s3.amazonaws.com/225.log	riak-1.2.1-55-gcc3758d-master
226	t	\N	206	4	2012-10-29 22:23:17.808632	2012-11-15 17:39:39.348762	https://basho-giddyup.s3.amazonaws.com/226.log	riak-1.2.1-55-gcc3758d-master
227	t	\N	207	4	2012-10-29 22:24:23.013561	2012-11-15 17:39:39.351311	https://basho-giddyup.s3.amazonaws.com/227.log	riak-1.2.1-55-gcc3758d-master
228	t	\N	208	4	2012-10-29 22:27:31.9763	2012-11-15 17:39:39.353745	https://basho-giddyup.s3.amazonaws.com/228.log	riak-1.2.1-55-gcc3758d-master
229	t	\N	209	4	2012-10-29 22:27:58.807005	2012-11-15 17:39:39.3567	https://basho-giddyup.s3.amazonaws.com/229.log	riak-1.2.1-55-gcc3758d-master
230	t	\N	210	4	2012-10-29 22:28:41.570675	2012-11-15 17:39:39.362748	https://basho-giddyup.s3.amazonaws.com/230.log	riak-1.2.1-55-gcc3758d-master
231	f	\N	193	4	2012-10-30 17:14:09.393803	2012-11-15 17:39:39.365629	https://basho-giddyup.s3.amazonaws.com/231.log	riak-1.2.1-55-gcc3758d-master
232	t	\N	194	4	2012-10-30 17:20:08.679702	2012-11-15 17:39:39.376027	https://basho-giddyup.s3.amazonaws.com/232.log	riak-1.2.1-55-gcc3758d-master
233	f	\N	195	4	2012-10-30 17:20:38.137349	2012-11-15 17:39:39.378577	https://basho-giddyup.s3.amazonaws.com/233.log	riak-1.2.1-55-gcc3758d-master
234	t	\N	196	4	2012-10-30 17:26:20.280296	2012-11-15 17:39:39.386172	https://basho-giddyup.s3.amazonaws.com/234.log	riak-1.2.1-55-gcc3758d-master
235	t	\N	197	4	2012-10-30 17:32:28.884405	2012-11-15 17:39:39.397597	https://basho-giddyup.s3.amazonaws.com/235.log	riak-1.2.1-55-gcc3758d-master
236	t	\N	198	4	2012-10-30 17:38:06.424023	2012-11-15 17:39:39.399935	https://basho-giddyup.s3.amazonaws.com/236.log	riak-1.2.1-55-gcc3758d-master
237	t	\N	199	4	2012-10-30 17:38:45.249499	2012-11-15 17:39:39.402252	https://basho-giddyup.s3.amazonaws.com/237.log	riak-1.2.1-55-gcc3758d-master
238	f	\N	200	4	2012-10-30 17:41:03.457321	2012-11-15 17:39:39.413673	https://basho-giddyup.s3.amazonaws.com/238.log	riak-1.2.1-55-gcc3758d-master
239	t	\N	201	4	2012-10-30 17:41:30.44426	2012-11-15 17:39:39.41649	https://basho-giddyup.s3.amazonaws.com/239.log	riak-1.2.1-55-gcc3758d-master
240	f	\N	202	4	2012-10-30 17:41:41.036341	2012-11-15 17:39:39.4186	https://basho-giddyup.s3.amazonaws.com/240.log	riak-1.2.1-55-gcc3758d-master
241	f	\N	203	4	2012-10-30 17:42:13.509505	2012-11-15 17:39:39.420678	https://basho-giddyup.s3.amazonaws.com/241.log	riak-1.2.1-55-gcc3758d-master
242	t	\N	204	4	2012-10-30 17:47:51.549539	2012-11-15 17:39:39.422852	https://basho-giddyup.s3.amazonaws.com/242.log	riak-1.2.1-55-gcc3758d-master
243	t	\N	205	4	2012-10-30 17:55:28.201687	2012-11-15 17:39:39.425971	https://basho-giddyup.s3.amazonaws.com/243.log	riak-1.2.1-55-gcc3758d-master
244	t	\N	206	4	2012-10-30 18:00:57.934252	2012-11-15 17:39:39.431295	https://basho-giddyup.s3.amazonaws.com/244.log	riak-1.2.1-55-gcc3758d-master
245	t	\N	207	4	2012-10-30 18:02:03.529929	2012-11-15 17:39:39.433935	https://basho-giddyup.s3.amazonaws.com/245.log	riak-1.2.1-55-gcc3758d-master
246	t	\N	208	4	2012-10-30 18:05:16.925118	2012-11-15 17:39:39.436519	https://basho-giddyup.s3.amazonaws.com/246.log	riak-1.2.1-55-gcc3758d-master
247	f	\N	209	4	2012-10-30 18:10:46.952876	2012-11-15 17:39:39.520712	https://basho-giddyup.s3.amazonaws.com/247.log	riak-1.2.1-55-gcc3758d-master
248	t	\N	210	4	2012-10-30 18:11:13.733699	2012-11-15 17:39:39.530739	https://basho-giddyup.s3.amazonaws.com/248.log	riak-1.2.1-55-gcc3758d-master
249	f	\N	7	4	2012-11-07 22:23:10.012764	2012-11-15 17:39:39.569065	https://basho-giddyup.s3.amazonaws.com/249.log	riak-1.2.1-55-gcc3758d-master
250	f	\N	17	4	2012-11-07 22:23:40.595561	2012-11-15 17:39:39.576319	https://basho-giddyup.s3.amazonaws.com/250.log	riak-1.2.1-55-gcc3758d-master
251	t	\N	27	4	2012-11-07 22:24:24.088584	2012-11-15 17:39:39.581914	https://basho-giddyup.s3.amazonaws.com/251.log	riak-1.2.1-55-gcc3758d-master
252	t	\N	2	4	2012-11-07 22:27:10.512275	2012-11-15 17:39:39.585529	https://basho-giddyup.s3.amazonaws.com/252.log	riak-1.2.1-55-gcc3758d-master
253	t	\N	3	4	2012-11-07 22:27:44.954849	2012-11-15 17:39:39.588355	https://basho-giddyup.s3.amazonaws.com/253.log	riak-1.2.1-55-gcc3758d-master
254	f	\N	13	4	2012-11-07 22:28:12.652312	2012-11-15 17:39:39.591089	https://basho-giddyup.s3.amazonaws.com/254.log	riak-1.2.1-55-gcc3758d-master
255	t	\N	23	4	2012-11-07 22:28:56.315105	2012-11-15 17:39:39.598589	https://basho-giddyup.s3.amazonaws.com/255.log	riak-1.2.1-55-gcc3758d-master
256	f	\N	33	4	2012-11-07 22:29:17.020818	2012-11-15 17:39:39.601679	https://basho-giddyup.s3.amazonaws.com/256.log	riak-1.2.1-55-gcc3758d-master
257	t	\N	211	4	2012-11-07 22:29:31.91245	2012-11-15 17:39:39.606089	https://basho-giddyup.s3.amazonaws.com/257.log	riak-1.2.1-55-gcc3758d-master
258	t	\N	43	4	2012-11-07 22:29:48.383678	2012-11-15 17:39:39.609455	https://basho-giddyup.s3.amazonaws.com/258.log	riak-1.2.1-55-gcc3758d-master
259	f	\N	37	4	2012-11-07 22:29:49.401774	2012-11-15 17:39:39.620675	https://basho-giddyup.s3.amazonaws.com/259.log	riak-1.2.1-55-gcc3758d-master
260	t	\N	4	4	2012-11-07 22:29:53.508241	2012-11-15 17:39:39.642368	https://basho-giddyup.s3.amazonaws.com/260.log	riak-1.2.1-55-gcc3758d-master
261	f	\N	14	4	2012-11-07 22:30:24.32211	2012-11-15 17:39:39.645063	https://basho-giddyup.s3.amazonaws.com/261.log	riak-1.2.1-55-gcc3758d-master
262	t	\N	47	4	2012-11-07 22:30:29.700901	2012-11-15 17:39:39.647386	https://basho-giddyup.s3.amazonaws.com/262.log	riak-1.2.1-55-gcc3758d-master
263	t	\N	53	4	2012-11-07 22:30:31.854045	2012-11-15 17:39:39.711726	https://basho-giddyup.s3.amazonaws.com/263.log	riak-1.2.1-55-gcc3758d-master
264	t	\N	63	4	2012-11-07 22:30:44.398186	2012-11-15 17:39:39.715875	https://basho-giddyup.s3.amazonaws.com/264.log	riak-1.2.1-55-gcc3758d-master
265	f	\N	24	4	2012-11-07 22:31:00.702535	2012-11-15 17:39:39.719703	https://basho-giddyup.s3.amazonaws.com/265.log	riak-1.2.1-55-gcc3758d-master
266	t	\N	57	4	2012-11-07 22:31:16.864549	2012-11-15 17:39:39.722622	https://basho-giddyup.s3.amazonaws.com/266.log	riak-1.2.1-55-gcc3758d-master
267	t	\N	73	4	2012-11-07 22:31:17.810806	2012-11-15 17:39:39.725673	https://basho-giddyup.s3.amazonaws.com/267.log	riak-1.2.1-55-gcc3758d-master
268	t	\N	67	4	2012-11-07 22:31:30.660002	2012-11-15 17:39:39.728279	https://basho-giddyup.s3.amazonaws.com/268.log	riak-1.2.1-55-gcc3758d-master
269	f	\N	34	4	2012-11-07 22:31:36.547342	2012-11-15 17:39:39.731171	https://basho-giddyup.s3.amazonaws.com/269.log	riak-1.2.1-55-gcc3758d-master
270	t	\N	44	4	2012-11-07 22:31:59.476838	2012-11-15 17:39:39.735129	https://basho-giddyup.s3.amazonaws.com/270.log	riak-1.2.1-55-gcc3758d-master
271	f	\N	83	4	2012-11-07 22:32:04.948156	2012-11-15 17:39:39.738874	https://basho-giddyup.s3.amazonaws.com/271.log	riak-1.2.1-55-gcc3758d-master
272	t	\N	77	4	2012-11-07 22:32:07.531296	2012-11-15 17:39:39.742194	https://basho-giddyup.s3.amazonaws.com/272.log	riak-1.2.1-55-gcc3758d-master
273	t	\N	93	4	2012-11-07 22:32:35.607743	2012-11-15 17:39:39.745504	https://basho-giddyup.s3.amazonaws.com/273.log	riak-1.2.1-55-gcc3758d-master
274	t	\N	54	4	2012-11-07 22:32:37.6979	2012-11-15 17:39:39.748449	https://basho-giddyup.s3.amazonaws.com/274.log	riak-1.2.1-55-gcc3758d-master
275	f	\N	103	4	2012-11-07 22:32:40.165879	2012-11-15 17:39:39.752553	https://basho-giddyup.s3.amazonaws.com/275.log	riak-1.2.1-55-gcc3758d-master
276	f	\N	12	4	2012-11-07 22:32:44.261539	2012-11-15 17:39:39.756754	https://basho-giddyup.s3.amazonaws.com/276.log	riak-1.2.1-55-gcc3758d-master
277	f	\N	87	4	2012-11-07 22:32:49.575981	2012-11-15 17:39:39.762481	https://basho-giddyup.s3.amazonaws.com/277.log	riak-1.2.1-55-gcc3758d-master
278	t	\N	64	4	2012-11-07 22:32:50.679645	2012-11-15 17:39:39.77361	https://basho-giddyup.s3.amazonaws.com/278.log	riak-1.2.1-55-gcc3758d-master
279	t	\N	113	4	2012-11-07 22:33:04.843113	2012-11-15 17:39:39.777	https://basho-giddyup.s3.amazonaws.com/279.log	riak-1.2.1-55-gcc3758d-master
280	t	\N	97	4	2012-11-07 22:33:10.447895	2012-11-15 17:39:39.780147	https://basho-giddyup.s3.amazonaws.com/280.log	riak-1.2.1-55-gcc3758d-master
281	f	\N	107	4	2012-11-07 22:33:15.432584	2012-11-15 17:39:39.784998	https://basho-giddyup.s3.amazonaws.com/281.log	riak-1.2.1-55-gcc3758d-master
282	t	\N	22	4	2012-11-07 22:33:24.873363	2012-11-15 17:39:39.788497	https://basho-giddyup.s3.amazonaws.com/282.log	riak-1.2.1-55-gcc3758d-master
283	t	\N	74	4	2012-11-07 22:33:26.143313	2012-11-15 17:39:39.791982	https://basho-giddyup.s3.amazonaws.com/283.log	riak-1.2.1-55-gcc3758d-master
284	t	\N	123	4	2012-11-07 22:33:43.428277	2012-11-15 17:39:39.795486	https://basho-giddyup.s3.amazonaws.com/284.log	riak-1.2.1-55-gcc3758d-master
285	f	\N	32	4	2012-11-07 22:33:46.938614	2012-11-15 17:39:39.801248	https://basho-giddyup.s3.amazonaws.com/285.log	riak-1.2.1-55-gcc3758d-master
286	t	\N	117	4	2012-11-07 22:33:51.77664	2012-11-15 17:39:39.805534	https://basho-giddyup.s3.amazonaws.com/286.log	riak-1.2.1-55-gcc3758d-master
287	f	\N	84	4	2012-11-07 22:34:13.608165	2012-11-15 17:39:39.813732	https://basho-giddyup.s3.amazonaws.com/287.log	riak-1.2.1-55-gcc3758d-master
288	t	\N	42	4	2012-11-07 22:34:18.518683	2012-11-15 17:39:39.817462	https://basho-giddyup.s3.amazonaws.com/288.log	riak-1.2.1-55-gcc3758d-master
289	t	\N	127	4	2012-11-07 22:34:31.606271	2012-11-15 17:39:39.820745	https://basho-giddyup.s3.amazonaws.com/289.log	riak-1.2.1-55-gcc3758d-master
290	f	\N	94	4	2012-11-07 22:34:34.876603	2012-11-15 17:39:39.826535	https://basho-giddyup.s3.amazonaws.com/290.log	riak-1.2.1-55-gcc3758d-master
291	f	\N	212	4	2012-11-07 22:35:08.36335	2012-11-15 17:39:39.83586	https://basho-giddyup.s3.amazonaws.com/291.log	riak-1.2.1-55-gcc3758d-master
292	t	\N	133	4	2012-11-07 22:36:03.664333	2012-11-15 17:39:39.844874	https://basho-giddyup.s3.amazonaws.com/292.log	riak-1.2.1-55-gcc3758d-master
293	t	\N	213	4	2012-11-07 22:36:12.749809	2012-11-15 17:39:39.85372	https://basho-giddyup.s3.amazonaws.com/293.log	riak-1.2.1-55-gcc3758d-master
294	t	\N	143	4	2012-11-07 22:36:15.673319	2012-11-15 17:39:39.960796	https://basho-giddyup.s3.amazonaws.com/294.log	riak-1.2.1-55-gcc3758d-master
295	f	\N	214	4	2012-11-07 22:36:47.638139	2012-11-15 17:39:39.966464	https://basho-giddyup.s3.amazonaws.com/295.log	riak-1.2.1-55-gcc3758d-master
296	t	\N	137	4	2012-11-07 22:37:02.911184	2012-11-15 17:39:39.96986	https://basho-giddyup.s3.amazonaws.com/296.log	riak-1.2.1-55-gcc3758d-master
297	t	\N	153	4	2012-11-07 22:37:14.56892	2012-11-15 17:39:39.972721	https://basho-giddyup.s3.amazonaws.com/297.log	riak-1.2.1-55-gcc3758d-master
298	t	\N	215	4	2012-11-07 22:37:15.349125	2012-11-15 17:39:39.978543	https://basho-giddyup.s3.amazonaws.com/298.log	riak-1.2.1-55-gcc3758d-master
299	t	\N	147	4	2012-11-07 22:37:16.36035	2012-11-15 17:39:40.037775	https://basho-giddyup.s3.amazonaws.com/299.log	riak-1.2.1-55-gcc3758d-master
300	t	\N	216	4	2012-11-07 22:37:55.175912	2012-11-15 17:39:40.054212	https://basho-giddyup.s3.amazonaws.com/300.log	riak-1.2.1-55-gcc3758d-master
301	t	\N	217	4	2012-11-07 22:38:09.652485	2012-11-15 17:39:40.065104	https://basho-giddyup.s3.amazonaws.com/301.log	riak-1.2.1-55-gcc3758d-master
302	t	\N	157	4	2012-11-07 22:38:16.499887	2012-11-15 17:39:40.131816	https://basho-giddyup.s3.amazonaws.com/302.log	riak-1.2.1-55-gcc3758d-master
303	t	\N	218	4	2012-11-07 22:38:44.646478	2012-11-15 17:39:40.136542	https://basho-giddyup.s3.amazonaws.com/303.log	riak-1.2.1-55-gcc3758d-master
304	f	\N	219	4	2012-11-07 22:39:24.839784	2012-11-15 17:39:40.14379	https://basho-giddyup.s3.amazonaws.com/304.log	riak-1.2.1-55-gcc3758d-master
305	f	\N	104	4	2012-11-07 22:39:45.225036	2012-11-15 17:39:40.147275	https://basho-giddyup.s3.amazonaws.com/305.log	riak-1.2.1-55-gcc3758d-master
306	t	\N	220	4	2012-11-07 22:39:46.035893	2012-11-15 17:39:40.15593	https://basho-giddyup.s3.amazonaws.com/306.log	riak-1.2.1-55-gcc3758d-master
307	f	\N	221	4	2012-11-07 22:39:50.333838	2012-11-15 17:39:40.159926	https://basho-giddyup.s3.amazonaws.com/307.log	riak-1.2.1-55-gcc3758d-master
308	f	\N	114	4	2012-11-07 22:39:55.964229	2012-11-15 17:39:40.164176	https://basho-giddyup.s3.amazonaws.com/308.log	riak-1.2.1-55-gcc3758d-master
309	t	\N	163	4	2012-11-07 22:40:06.737276	2012-11-15 17:39:40.168417	https://basho-giddyup.s3.amazonaws.com/309.log	riak-1.2.1-55-gcc3758d-master
310	t	\N	52	4	2012-11-07 22:40:07.655446	2012-11-15 17:39:40.17265	https://basho-giddyup.s3.amazonaws.com/310.log	riak-1.2.1-55-gcc3758d-master
311	t	\N	222	4	2012-11-07 22:40:17.730202	2012-11-15 17:39:40.184363	https://basho-giddyup.s3.amazonaws.com/311.log	riak-1.2.1-55-gcc3758d-master
312	t	\N	62	4	2012-11-07 22:40:20.520024	2012-11-15 17:39:40.188241	https://basho-giddyup.s3.amazonaws.com/312.log	riak-1.2.1-55-gcc3758d-master
313	t	\N	124	4	2012-11-07 22:40:24.289904	2012-11-15 17:39:40.192833	https://basho-giddyup.s3.amazonaws.com/313.log	riak-1.2.1-55-gcc3758d-master
314	t	\N	175	4	2012-11-07 22:40:33.71239	2012-11-15 17:39:40.21955	https://basho-giddyup.s3.amazonaws.com/314.log	riak-1.2.1-55-gcc3758d-master
315	t	\N	223	4	2012-11-07 22:40:36.985636	2012-11-15 17:39:40.230334	https://basho-giddyup.s3.amazonaws.com/315.log	riak-1.2.1-55-gcc3758d-master
316	t	\N	72	4	2012-11-07 22:41:07.506668	2012-11-15 17:39:40.238491	https://basho-giddyup.s3.amazonaws.com/316.log	riak-1.2.1-55-gcc3758d-master
317	t	\N	167	4	2012-11-07 22:41:09.359268	2012-11-15 17:39:40.241775	https://basho-giddyup.s3.amazonaws.com/317.log	riak-1.2.1-55-gcc3758d-master
318	t	\N	183	4	2012-11-07 22:41:29.30329	2012-11-15 17:39:40.248919	https://basho-giddyup.s3.amazonaws.com/318.log	riak-1.2.1-55-gcc3758d-master
319	t	\N	176	4	2012-11-07 22:41:31.260028	2012-11-15 17:39:40.279648	https://basho-giddyup.s3.amazonaws.com/319.log	riak-1.2.1-55-gcc3758d-master
320	f	\N	82	4	2012-11-07 22:41:47.314203	2012-11-15 17:39:40.291482	https://basho-giddyup.s3.amazonaws.com/320.log	riak-1.2.1-55-gcc3758d-master
321	t	\N	92	4	2012-11-07 22:42:08.564049	2012-11-15 17:39:40.295158	https://basho-giddyup.s3.amazonaws.com/321.log	riak-1.2.1-55-gcc3758d-master
322	f	\N	102	4	2012-11-07 22:42:13.647051	2012-11-15 17:39:40.297859	https://basho-giddyup.s3.amazonaws.com/322.log	riak-1.2.1-55-gcc3758d-master
323	t	\N	184	4	2012-11-07 22:42:20.143312	2012-11-15 17:39:40.310108	https://basho-giddyup.s3.amazonaws.com/323.log	riak-1.2.1-55-gcc3758d-master
324	f	\N	112	4	2012-11-07 22:42:38.431567	2012-11-15 17:39:40.315911	https://basho-giddyup.s3.amazonaws.com/324.log	riak-1.2.1-55-gcc3758d-master
325	t	\N	134	4	2012-11-07 22:42:54.505797	2012-11-15 17:39:40.321865	https://basho-giddyup.s3.amazonaws.com/325.log	riak-1.2.1-55-gcc3758d-master
326	t	\N	224	4	2012-11-07 22:42:57.12815	2012-11-15 17:39:40.326727	https://basho-giddyup.s3.amazonaws.com/326.log	riak-1.2.1-55-gcc3758d-master
327	t	\N	144	4	2012-11-07 22:43:06.937073	2012-11-15 17:39:40.332321	https://basho-giddyup.s3.amazonaws.com/327.log	riak-1.2.1-55-gcc3758d-master
328	t	\N	225	4	2012-11-07 22:43:09.159261	2012-11-15 17:39:40.35017	https://basho-giddyup.s3.amazonaws.com/328.log	riak-1.2.1-55-gcc3758d-master
329	t	\N	122	4	2012-11-07 22:43:18.788707	2012-11-15 17:39:40.353728	https://basho-giddyup.s3.amazonaws.com/329.log	riak-1.2.1-55-gcc3758d-master
330	t	\N	154	4	2012-11-07 22:44:06.869003	2012-11-15 17:39:40.356875	https://basho-giddyup.s3.amazonaws.com/330.log	riak-1.2.1-55-gcc3758d-master
331	t	\N	132	4	2012-11-07 22:45:49.408204	2012-11-15 17:39:40.362675	https://basho-giddyup.s3.amazonaws.com/331.log	riak-1.2.1-55-gcc3758d-master
332	t	\N	142	4	2012-11-07 22:46:03.564335	2012-11-15 17:39:40.430073	https://basho-giddyup.s3.amazonaws.com/332.log	riak-1.2.1-55-gcc3758d-master
333	t	\N	164	4	2012-11-07 22:46:58.474782	2012-11-15 17:39:40.43529	https://basho-giddyup.s3.amazonaws.com/333.log	riak-1.2.1-55-gcc3758d-master
334	t	\N	152	4	2012-11-07 22:47:04.267711	2012-11-15 17:39:40.438758	https://basho-giddyup.s3.amazonaws.com/334.log	riak-1.2.1-55-gcc3758d-master
335	t	\N	177	4	2012-11-07 22:47:16.206025	2012-11-15 17:39:40.444752	https://basho-giddyup.s3.amazonaws.com/335.log	riak-1.2.1-55-gcc3758d-master
336	t	\N	178	4	2012-11-07 22:48:02.504169	2012-11-15 17:39:40.44785	https://basho-giddyup.s3.amazonaws.com/336.log	riak-1.2.1-55-gcc3758d-master
337	f	\N	226	4	2012-11-07 22:48:42.542018	2012-11-15 17:39:40.452888	https://basho-giddyup.s3.amazonaws.com/337.log	riak-1.2.1-55-gcc3758d-master
338	t	\N	162	4	2012-11-07 22:49:54.936649	2012-11-15 17:39:40.455945	https://basho-giddyup.s3.amazonaws.com/338.log	riak-1.2.1-55-gcc3758d-master
339	t	\N	173	4	2012-11-07 22:50:19.010577	2012-11-15 17:39:40.464241	https://basho-giddyup.s3.amazonaws.com/339.log	riak-1.2.1-55-gcc3758d-master
340	f	\N	174	4	2012-11-07 22:50:32.870468	2012-11-15 17:39:40.471026	https://basho-giddyup.s3.amazonaws.com/340.log	riak-1.2.1-55-gcc3758d-master
341	t	\N	227	4	2012-11-07 22:51:34.74808	2012-11-15 17:39:40.474819	https://basho-giddyup.s3.amazonaws.com/341.log	riak-1.2.1-55-gcc3758d-master
342	f	\N	228	4	2012-11-07 22:52:16.108018	2012-11-15 17:39:40.479959	https://basho-giddyup.s3.amazonaws.com/342.log	riak-1.2.1-55-gcc3758d-master
343	f	\N	229	4	2012-11-07 22:52:35.554605	2012-11-15 17:39:40.485486	https://basho-giddyup.s3.amazonaws.com/343.log	riak-1.2.1-55-gcc3758d-master
344	f	\N	9	4	2012-11-07 23:48:26.105926	2012-11-15 17:39:40.491276	https://basho-giddyup.s3.amazonaws.com/344.log	riak-1.2.1-55-gcc3758d-master
345	t	\N	19	4	2012-11-07 23:49:04.597374	2012-11-15 17:39:40.499082	https://basho-giddyup.s3.amazonaws.com/345.log	riak-1.2.1-55-gcc3758d-master
346	f	\N	29	4	2012-11-07 23:49:13.82117	2012-11-15 17:39:40.508148	https://basho-giddyup.s3.amazonaws.com/346.log	riak-1.2.1-55-gcc3758d-master
347	f	\N	39	4	2012-11-07 23:49:24.360752	2012-11-15 17:39:40.516282	https://basho-giddyup.s3.amazonaws.com/347.log	riak-1.2.1-55-gcc3758d-master
348	f	\N	49	4	2012-11-07 23:49:33.550589	2012-11-15 17:39:40.525204	https://basho-giddyup.s3.amazonaws.com/348.log	riak-1.2.1-55-gcc3758d-master
349	f	\N	59	4	2012-11-07 23:52:42.882176	2012-11-15 17:39:40.539992	https://basho-giddyup.s3.amazonaws.com/349.log	riak-1.2.1-55-gcc3758d-master
350	f	\N	69	4	2012-11-07 23:52:50.674368	2012-11-15 17:39:40.545393	https://basho-giddyup.s3.amazonaws.com/350.log	riak-1.2.1-55-gcc3758d-master
351	f	\N	79	4	2012-11-07 23:56:05.444525	2012-11-15 17:39:40.554842	https://basho-giddyup.s3.amazonaws.com/351.log	riak-1.2.1-55-gcc3758d-master
352	f	\N	89	4	2012-11-07 23:59:17.35913	2012-11-15 17:39:40.562659	https://basho-giddyup.s3.amazonaws.com/352.log	riak-1.2.1-55-gcc3758d-master
353	t	\N	99	4	2012-11-07 23:59:38.036478	2012-11-15 17:39:40.574976	https://basho-giddyup.s3.amazonaws.com/353.log	riak-1.2.1-55-gcc3758d-master
354	f	\N	109	4	2012-11-07 23:59:45.246767	2012-11-15 17:39:40.709149	https://basho-giddyup.s3.amazonaws.com/354.log	riak-1.2.1-55-gcc3758d-master
355	t	\N	119	4	2012-11-08 00:00:18.83386	2012-11-15 17:39:40.721043	https://basho-giddyup.s3.amazonaws.com/355.log	riak-1.2.1-55-gcc3758d-master
356	t	\N	129	4	2012-11-08 00:00:42.190644	2012-11-15 17:39:40.724104	https://basho-giddyup.s3.amazonaws.com/356.log	riak-1.2.1-55-gcc3758d-master
357	t	\N	139	4	2012-11-08 00:03:05.36081	2012-11-15 17:39:40.726728	https://basho-giddyup.s3.amazonaws.com/357.log	riak-1.2.1-55-gcc3758d-master
358	t	\N	149	4	2012-11-08 00:03:16.063017	2012-11-15 17:39:40.729187	https://basho-giddyup.s3.amazonaws.com/358.log	riak-1.2.1-55-gcc3758d-master
359	t	\N	159	4	2012-11-08 00:04:15.067597	2012-11-15 17:39:40.731439	https://basho-giddyup.s3.amazonaws.com/359.log	riak-1.2.1-55-gcc3758d-master
360	t	\N	169	4	2012-11-08 00:07:17.894434	2012-11-15 17:39:40.733909	https://basho-giddyup.s3.amazonaws.com/360.log	riak-1.2.1-55-gcc3758d-master
361	t	\N	187	4	2012-11-08 00:07:47.281275	2012-11-15 17:39:40.740301	https://basho-giddyup.s3.amazonaws.com/361.log	riak-1.2.1-55-gcc3758d-master
362	f	\N	188	4	2012-11-08 00:10:41.77009	2012-11-15 17:39:40.743684	https://basho-giddyup.s3.amazonaws.com/362.log	riak-1.2.1-55-gcc3758d-master
565	t	\N	57	4	2012-11-20 15:16:56.694134	2012-11-20 15:16:56.694134	https://basho-giddyup.s3.amazonaws.com/565.log	riak-1.2.1-81-gd414744-master
566	t	\N	67	4	2012-11-20 15:22:15.541707	2012-11-20 15:22:15.541707	https://basho-giddyup.s3.amazonaws.com/566.log	riak-1.2.1-81-gd414744-master
567	f	\N	87	4	2012-11-20 15:22:46.601984	2012-11-20 15:22:46.601984	https://basho-giddyup.s3.amazonaws.com/567.log	riak-1.2.1-81-gd414744-master
568	t	\N	97	4	2012-11-20 15:23:11.502148	2012-11-20 15:23:11.502148	https://basho-giddyup.s3.amazonaws.com/568.log	riak-1.2.1-81-gd414744-master
569	f	\N	107	4	2012-11-20 15:23:30.377708	2012-11-20 15:23:30.377708	https://basho-giddyup.s3.amazonaws.com/569.log	riak-1.2.1-81-gd414744-master
570	t	\N	117	4	2012-11-20 15:29:15.294068	2012-11-20 15:29:15.294068	https://basho-giddyup.s3.amazonaws.com/570.log	riak-1.2.1-81-gd414744-master
571	t	\N	127	4	2012-11-20 15:35:05.140009	2012-11-20 15:35:05.140009	https://basho-giddyup.s3.amazonaws.com/571.log	riak-1.2.1-81-gd414744-master
572	t	\N	137	4	2012-11-20 15:42:00.820098	2012-11-20 15:42:00.820098	https://basho-giddyup.s3.amazonaws.com/572.log	riak-1.2.1-81-gd414744-master
573	t	\N	147	4	2012-11-20 15:47:23.091756	2012-11-20 15:47:23.091756	https://basho-giddyup.s3.amazonaws.com/573.log	riak-1.2.1-81-gd414744-master
574	t	\N	157	4	2012-11-20 15:53:28.486346	2012-11-20 15:53:28.486346	https://basho-giddyup.s3.amazonaws.com/574.log	riak-1.2.1-81-gd414744-master
575	t	\N	167	4	2012-11-20 15:55:55.200151	2012-11-20 15:55:55.200151	https://basho-giddyup.s3.amazonaws.com/575.log	riak-1.2.1-81-gd414744-master
576	f	\N	183	4	2012-11-20 15:56:06.056129	2012-11-20 15:56:06.056129	https://basho-giddyup.s3.amazonaws.com/576.log	riak-1.2.1-81-gd414744-master
577	t	\N	184	4	2012-11-20 15:57:10.874591	2012-11-20 15:57:10.874591	https://basho-giddyup.s3.amazonaws.com/577.log	riak-1.2.1-81-gd414744-master
578	f	\N	237	4	2012-11-20 16:05:38.822613	2012-11-20 16:05:38.822613	https://basho-giddyup.s3.amazonaws.com/578.log	riak-1.2.1-81-gd414744-master
579	f	\N	249	4	2012-11-20 16:08:50.773516	2012-11-20 16:08:50.773516	https://basho-giddyup.s3.amazonaws.com/579.log	riak-1.2.1-81-gd414744-master
580	f	\N	261	4	2012-11-20 16:08:55.722269	2012-11-20 16:08:55.722269	https://basho-giddyup.s3.amazonaws.com/580.log	riak-1.2.1-81-gd414744-master
581	f	\N	273	4	2012-11-20 16:09:14.080684	2012-11-20 16:09:14.080684	https://basho-giddyup.s3.amazonaws.com/581.log	riak-1.2.1-81-gd414744-master
582	f	\N	285	4	2012-11-20 16:14:32.681401	2012-11-20 16:14:32.681401	https://basho-giddyup.s3.amazonaws.com/582.log	riak-1.2.1-81-gd414744-master
583	t	\N	304	4	2012-11-20 16:47:59.290531	2012-11-20 16:47:59.290531	https://basho-giddyup.s3.amazonaws.com/583.log	riak-1.2.1-81-gd414744-master
584	t	\N	338	4	2012-11-20 17:19:24.668245	2012-11-20 17:19:24.668245	https://basho-giddyup.s3.amazonaws.com/584.log	riak-1.2.1-81-gd414744-master
591	t	\N	37	4	2012-11-20 21:52:05.233889	2012-11-20 21:52:05.233889	https://basho-giddyup.s3.amazonaws.com/591.log	riak-1.2.1-81-gd414744-master
592	f	\N	47	4	2012-11-20 21:52:31.120969	2012-11-20 21:52:31.120969	https://basho-giddyup.s3.amazonaws.com/592.log	riak-1.2.1-81-gd414744-master
593	t	\N	57	4	2012-11-20 21:53:21.961963	2012-11-20 21:53:21.961963	https://basho-giddyup.s3.amazonaws.com/593.log	riak-1.2.1-81-gd414744-master
594	t	\N	67	4	2012-11-20 21:53:43.401874	2012-11-20 21:53:43.401874	https://basho-giddyup.s3.amazonaws.com/594.log	riak-1.2.1-81-gd414744-master
595	f	\N	87	4	2012-11-20 21:54:13.806766	2012-11-20 21:54:13.806766	https://basho-giddyup.s3.amazonaws.com/595.log	riak-1.2.1-81-gd414744-master
596	t	\N	97	4	2012-11-20 21:54:41.499111	2012-11-20 21:54:41.499111	https://basho-giddyup.s3.amazonaws.com/596.log	riak-1.2.1-81-gd414744-master
597	t	\N	107	4	2012-11-20 22:01:26.410355	2012-11-20 22:01:26.410355	https://basho-giddyup.s3.amazonaws.com/597.log	riak-1.2.1-81-gd414744-master
598	f	\N	117	4	2012-11-20 22:01:44.665588	2012-11-20 22:01:44.665588	https://basho-giddyup.s3.amazonaws.com/598.log	riak-1.2.1-81-gd414744-master
599	t	\N	127	4	2012-11-20 22:02:22.456476	2012-11-20 22:02:22.456476	https://basho-giddyup.s3.amazonaws.com/599.log	riak-1.2.1-81-gd414744-master
600	f	\N	137	4	2012-11-20 22:07:47.71345	2012-11-20 22:07:47.71345	https://basho-giddyup.s3.amazonaws.com/600.log	riak-1.2.1-81-gd414744-master
601	t	\N	147	4	2012-11-20 22:08:10.54734	2012-11-20 22:08:10.54734	https://basho-giddyup.s3.amazonaws.com/601.log	riak-1.2.1-81-gd414744-master
602	t	\N	157	4	2012-11-20 22:14:25.217213	2012-11-20 22:14:25.217213	https://basho-giddyup.s3.amazonaws.com/602.log	riak-1.2.1-81-gd414744-master
603	t	\N	167	4	2012-11-20 22:16:42.032042	2012-11-20 22:16:42.032042	https://basho-giddyup.s3.amazonaws.com/603.log	riak-1.2.1-81-gd414744-master
604	t	\N	183	4	2012-11-20 22:17:08.377948	2012-11-20 22:17:08.377948	https://basho-giddyup.s3.amazonaws.com/604.log	riak-1.2.1-81-gd414744-master
396	t	\N	207	4	2012-11-15 17:39:21.088048	2012-11-15 17:39:41.371583	https://basho-giddyup.s3.amazonaws.com/396.log	riak-1.2.1-71-g37f0b9f-master
395	t	\N	206	4	2012-11-15 17:38:22.331927	2012-11-15 17:39:41.373922	https://basho-giddyup.s3.amazonaws.com/395.log	riak-1.2.1-71-g37f0b9f-master
394	t	\N	205	4	2012-11-15 17:33:03.082264	2012-11-15 17:39:41.375402	https://basho-giddyup.s3.amazonaws.com/394.log	riak-1.2.1-71-g37f0b9f-master
393	t	\N	204	4	2012-11-15 17:30:42.888676	2012-11-15 17:39:41.379851	https://basho-giddyup.s3.amazonaws.com/393.log	riak-1.2.1-71-g37f0b9f-master
392	f	\N	203	4	2012-11-15 17:30:13.416113	2012-11-15 17:39:41.381207	https://basho-giddyup.s3.amazonaws.com/392.log	riak-1.2.1-71-g37f0b9f-master
391	f	\N	202	4	2012-11-15 17:29:48.542651	2012-11-15 17:39:41.384344	https://basho-giddyup.s3.amazonaws.com/391.log	riak-1.2.1-71-g37f0b9f-master
390	t	\N	201	4	2012-11-15 17:29:44.095763	2012-11-15 17:39:41.386054	https://basho-giddyup.s3.amazonaws.com/390.log	riak-1.2.1-71-g37f0b9f-master
389	f	\N	200	4	2012-11-15 17:29:24.417562	2012-11-15 17:39:41.387432	https://basho-giddyup.s3.amazonaws.com/389.log	riak-1.2.1-71-g37f0b9f-master
388	t	\N	198	4	2012-11-15 17:25:57.484321	2012-11-15 17:39:41.388729	https://basho-giddyup.s3.amazonaws.com/388.log	riak-1.2.1-71-g37f0b9f-master
387	t	\N	197	4	2012-11-15 17:25:41.302737	2012-11-15 17:39:41.392253	https://basho-giddyup.s3.amazonaws.com/387.log	riak-1.2.1-71-g37f0b9f-master
386	t	\N	196	4	2012-11-15 17:24:42.457335	2012-11-15 17:39:41.40369	https://basho-giddyup.s3.amazonaws.com/386.log	riak-1.2.1-71-g37f0b9f-master
385	t	\N	195	4	2012-11-15 17:24:14.570295	2012-11-15 17:39:41.405261	https://basho-giddyup.s3.amazonaws.com/385.log	riak-1.2.1-71-g37f0b9f-master
384	t	\N	194	4	2012-11-15 17:23:39.726679	2012-11-15 17:39:41.410362	https://basho-giddyup.s3.amazonaws.com/384.log	riak-1.2.1-71-g37f0b9f-master
383	f	\N	193	4	2012-11-15 17:23:00.389076	2012-11-15 17:39:41.413755	https://basho-giddyup.s3.amazonaws.com/383.log	riak-1.2.1-71-g37f0b9f-master
382	t	\N	192	4	2012-11-15 17:22:29.272617	2012-11-15 17:39:41.415068	https://basho-giddyup.s3.amazonaws.com/382.log	riak-1.2.1-71-g37f0b9f-master
381	f	\N	241	4	2012-11-15 08:43:03.390783	2012-11-15 17:39:41.416961	https://basho-giddyup.s3.amazonaws.com/381.log	riak-1.2.1-71-g37f0b9f-master
380	t	\N	210	4	2012-11-15 08:39:22.493988	2012-11-15 17:39:41.418231	https://basho-giddyup.s3.amazonaws.com/380.log	riak-1.2.1-71-g37f0b9f-master
379	t	\N	209	4	2012-11-15 08:38:49.583605	2012-11-15 17:39:41.420073	https://basho-giddyup.s3.amazonaws.com/379.log	riak-1.2.1-71-g37f0b9f-master
378	t	\N	208	4	2012-11-15 08:38:22.933592	2012-11-15 17:39:41.42172	https://basho-giddyup.s3.amazonaws.com/378.log	riak-1.2.1-71-g37f0b9f-master
377	t	\N	207	4	2012-11-15 08:35:24.938513	2012-11-15 17:39:41.423689	https://basho-giddyup.s3.amazonaws.com/377.log	riak-1.2.1-71-g37f0b9f-master
376	t	\N	206	4	2012-11-15 08:34:25.019832	2012-11-15 17:39:41.425528	https://basho-giddyup.s3.amazonaws.com/376.log	riak-1.2.1-71-g37f0b9f-master
375	t	\N	205	4	2012-11-15 08:29:03.956918	2012-11-15 17:39:41.426747	https://basho-giddyup.s3.amazonaws.com/375.log	riak-1.2.1-71-g37f0b9f-master
374	t	\N	204	4	2012-11-15 08:26:42.745714	2012-11-15 17:39:41.427915	https://basho-giddyup.s3.amazonaws.com/374.log	riak-1.2.1-71-g37f0b9f-master
373	f	\N	203	4	2012-11-15 08:26:20.585016	2012-11-15 17:39:41.429123	https://basho-giddyup.s3.amazonaws.com/373.log	riak-1.2.1-71-g37f0b9f-master
372	f	\N	202	4	2012-11-15 08:25:54.802973	2012-11-15 17:39:41.430369	https://basho-giddyup.s3.amazonaws.com/372.log	riak-1.2.1-71-g37f0b9f-master
371	t	\N	201	4	2012-11-15 08:25:49.890833	2012-11-15 17:39:41.431634	https://basho-giddyup.s3.amazonaws.com/371.log	riak-1.2.1-71-g37f0b9f-master
370	f	\N	200	4	2012-11-15 08:25:29.462713	2012-11-15 17:39:41.432931	https://basho-giddyup.s3.amazonaws.com/370.log	riak-1.2.1-71-g37f0b9f-master
369	t	\N	198	4	2012-11-15 08:22:00.387195	2012-11-15 17:39:41.437027	https://basho-giddyup.s3.amazonaws.com/369.log	riak-1.2.1-71-g37f0b9f-master
368	t	\N	197	4	2012-11-15 08:16:39.741321	2012-11-15 17:39:41.439017	https://basho-giddyup.s3.amazonaws.com/368.log	riak-1.2.1-71-g37f0b9f-master
367	t	\N	196	4	2012-11-15 08:15:48.453843	2012-11-15 17:39:41.440839	https://basho-giddyup.s3.amazonaws.com/367.log	riak-1.2.1-71-g37f0b9f-master
366	f	\N	195	4	2012-11-15 08:15:09.747065	2012-11-15 17:39:41.44217	https://basho-giddyup.s3.amazonaws.com/366.log	riak-1.2.1-71-g37f0b9f-master
365	t	\N	194	4	2012-11-15 08:14:48.991638	2012-11-15 17:39:41.443406	https://basho-giddyup.s3.amazonaws.com/365.log	riak-1.2.1-71-g37f0b9f-master
364	f	\N	193	4	2012-11-15 08:14:09.172483	2012-11-15 17:39:41.447293	https://basho-giddyup.s3.amazonaws.com/364.log	riak-1.2.1-71-g37f0b9f-master
363	t	\N	192	4	2012-11-15 08:13:37.250431	2012-11-15 17:39:41.449178	https://basho-giddyup.s3.amazonaws.com/363.log	riak-1.2.1-71-g37f0b9f-master
397	t	\N	208	4	2012-11-15 17:42:08.111865	2012-11-15 17:42:08.111865	https://basho-giddyup.s3.amazonaws.com/397.log	riak-1.2.1-71-g37f0b9f-master
398	t	\N	209	4	2012-11-15 17:42:33.653847	2012-11-15 17:42:33.653847	https://basho-giddyup.s3.amazonaws.com/398.log	riak-1.2.1-71-g37f0b9f-master
605	t	\N	184	4	2012-11-20 22:18:01.459424	2012-11-20 22:18:01.459424	https://basho-giddyup.s3.amazonaws.com/605.log	riak-1.2.1-81-gd414744-master
606	t	\N	237	4	2012-11-20 22:18:37.147527	2012-11-20 22:18:37.147527	https://basho-giddyup.s3.amazonaws.com/606.log	riak-1.2.1-81-gd414744-master
607	f	\N	249	4	2012-11-20 22:20:07.796175	2012-11-20 22:20:07.796175	https://basho-giddyup.s3.amazonaws.com/607.log	riak-1.2.1-81-gd414744-master
608	f	\N	261	4	2012-11-20 22:20:16.001592	2012-11-20 22:20:16.001592	https://basho-giddyup.s3.amazonaws.com/608.log	riak-1.2.1-81-gd414744-master
609	f	\N	273	4	2012-11-20 22:21:46.143814	2012-11-20 22:21:46.143814	https://basho-giddyup.s3.amazonaws.com/609.log	riak-1.2.1-81-gd414744-master
610	f	\N	285	4	2012-11-20 22:21:59.516438	2012-11-20 22:21:59.516438	https://basho-giddyup.s3.amazonaws.com/610.log	riak-1.2.1-81-gd414744-master
611	f	\N	304	4	2012-11-20 22:22:20.240341	2012-11-20 22:22:20.240341	https://basho-giddyup.s3.amazonaws.com/611.log	riak-1.2.1-81-gd414744-master
612	t	\N	338	4	2012-11-20 22:55:05.17155	2012-11-20 22:55:05.17155	https://basho-giddyup.s3.amazonaws.com/612.log	riak-1.2.1-81-gd414744-master
698	f	\N	202	4	2012-11-21 22:45:42.305992	2012-11-21 22:45:42.305992	https://basho-giddyup.s3.amazonaws.com/698.log	riak-1.2.1-81-ge681ace-master
699	t	\N	203	4	2012-11-21 22:46:08.425129	2012-11-21 22:46:08.425129	https://basho-giddyup.s3.amazonaws.com/699.log	riak-1.2.1-81-ge681ace-master
700	t	\N	204	4	2012-11-21 22:46:49.802517	2012-11-21 22:46:49.802517	https://basho-giddyup.s3.amazonaws.com/700.log	riak-1.2.1-81-ge681ace-master
701	f	\N	205	4	2012-11-21 22:46:58.019193	2012-11-21 22:46:58.019193	https://basho-giddyup.s3.amazonaws.com/701.log	riak-1.2.1-81-ge681ace-master
736	t	\N	7	4	2012-11-28 19:19:12.169766	2012-11-28 19:19:12.169766	https://basho-giddyup.s3.amazonaws.com/736.log	riak-1.2.1-81-gd414744-master
737	f	\N	17	4	2012-11-28 19:19:42.592383	2012-11-28 19:19:42.592383	https://basho-giddyup.s3.amazonaws.com/737.log	riak-1.2.1-81-gd414744-master
738	t	\N	27	4	2012-11-28 19:20:54.178897	2012-11-28 19:20:54.178897	https://basho-giddyup.s3.amazonaws.com/738.log	riak-1.2.1-81-gd414744-master
739	t	\N	37	4	2012-11-28 19:21:56.326923	2012-11-28 19:21:56.326923	https://basho-giddyup.s3.amazonaws.com/739.log	riak-1.2.1-81-gd414744-master
740	f	\N	47	4	2012-11-28 19:22:21.936523	2012-11-28 19:22:21.936523	https://basho-giddyup.s3.amazonaws.com/740.log	riak-1.2.1-81-gd414744-master
741	t	\N	57	4	2012-11-28 19:23:16.563426	2012-11-28 19:23:16.563426	https://basho-giddyup.s3.amazonaws.com/741.log	riak-1.2.1-81-gd414744-master
742	t	\N	67	4	2012-11-28 19:23:38.406065	2012-11-28 19:23:38.406065	https://basho-giddyup.s3.amazonaws.com/742.log	riak-1.2.1-81-gd414744-master
743	f	\N	87	4	2012-11-28 19:24:10.676604	2012-11-28 19:24:10.676604	https://basho-giddyup.s3.amazonaws.com/743.log	riak-1.2.1-81-gd414744-master
744	t	\N	97	4	2012-11-28 19:24:39.548421	2012-11-28 19:24:39.548421	https://basho-giddyup.s3.amazonaws.com/744.log	riak-1.2.1-81-gd414744-master
745	t	\N	107	4	2012-11-28 19:26:20.334056	2012-11-28 19:26:20.334056	https://basho-giddyup.s3.amazonaws.com/745.log	riak-1.2.1-81-gd414744-master
746	f	\N	117	4	2012-11-28 19:31:55.172491	2012-11-28 19:31:55.172491	https://basho-giddyup.s3.amazonaws.com/746.log	riak-1.2.1-81-gd414744-master
747	t	\N	127	4	2012-11-28 19:32:48.820479	2012-11-28 19:32:48.820479	https://basho-giddyup.s3.amazonaws.com/747.log	riak-1.2.1-81-gd414744-master
748	t	\N	137	4	2012-11-28 19:34:47.965004	2012-11-28 19:34:47.965004	https://basho-giddyup.s3.amazonaws.com/748.log	riak-1.2.1-81-gd414744-master
749	t	\N	147	4	2012-11-28 19:35:11.956641	2012-11-28 19:35:11.956641	https://basho-giddyup.s3.amazonaws.com/749.log	riak-1.2.1-81-gd414744-master
750	t	\N	157	4	2012-11-28 19:36:21.801693	2012-11-28 19:36:21.801693	https://basho-giddyup.s3.amazonaws.com/750.log	riak-1.2.1-81-gd414744-master
751	t	\N	167	4	2012-11-28 19:38:39.444312	2012-11-28 19:38:39.444312	https://basho-giddyup.s3.amazonaws.com/751.log	riak-1.2.1-81-gd414744-master
752	t	\N	183	4	2012-11-28 19:39:05.332164	2012-11-28 19:39:05.332164	https://basho-giddyup.s3.amazonaws.com/752.log	riak-1.2.1-81-gd414744-master
753	t	\N	184	4	2012-11-28 19:39:58.516117	2012-11-28 19:39:58.516117	https://basho-giddyup.s3.amazonaws.com/753.log	riak-1.2.1-81-gd414744-master
754	t	\N	237	4	2012-11-28 19:40:38.235228	2012-11-28 19:40:38.235228	https://basho-giddyup.s3.amazonaws.com/754.log	riak-1.2.1-81-gd414744-master
755	f	\N	249	4	2012-11-28 19:42:08.161841	2012-11-28 19:42:08.161841	https://basho-giddyup.s3.amazonaws.com/755.log	riak-1.2.1-81-gd414744-master
756	f	\N	261	4	2012-11-28 19:42:14.733117	2012-11-28 19:42:14.733117	https://basho-giddyup.s3.amazonaws.com/756.log	riak-1.2.1-81-gd414744-master
757	t	\N	273	4	2012-11-28 19:44:16.209511	2012-11-28 19:44:16.209511	https://basho-giddyup.s3.amazonaws.com/757.log	riak-1.2.1-81-gd414744-master
758	t	\N	285	4	2012-11-28 19:47:10.991464	2012-11-28 19:47:10.991464	https://basho-giddyup.s3.amazonaws.com/758.log	riak-1.2.1-81-gd414744-master
764	t	\N	7	4	2012-11-29 02:59:24.773704	2012-11-29 02:59:24.773704	https://basho-giddyup.s3.amazonaws.com/764.log	riak-1.2.1-81-gd414744-master
783	f	\N	249	4	2012-11-29 03:39:40.492587	2012-11-29 03:39:40.492587	https://basho-giddyup.s3.amazonaws.com/783.log	riak-1.2.1-81-gd414744-master
784	f	\N	261	4	2012-11-29 03:39:46.872933	2012-11-29 03:39:46.872933	https://basho-giddyup.s3.amazonaws.com/784.log	riak-1.2.1-81-gd414744-master
785	t	\N	273	4	2012-11-29 03:42:01.971552	2012-11-29 03:42:01.971552	https://basho-giddyup.s3.amazonaws.com/785.log	riak-1.2.1-81-gd414744-master
786	t	\N	285	4	2012-11-29 03:44:55.262537	2012-11-29 03:44:55.262537	https://basho-giddyup.s3.amazonaws.com/786.log	riak-1.2.1-81-gd414744-master
787	t	\N	304	4	2012-11-29 04:15:00.272148	2012-11-29 04:15:00.272148	https://basho-giddyup.s3.amazonaws.com/787.log	riak-1.2.1-81-gd414744-master
788	t	\N	338	4	2012-11-29 04:46:02.307409	2012-11-29 04:46:02.307409	https://basho-giddyup.s3.amazonaws.com/788.log	riak-1.2.1-81-gd414744-master
789	t	\N	305	4	2012-11-29 05:20:30.644156	2012-11-29 05:20:30.644156	https://basho-giddyup.s3.amazonaws.com/789.log	riak-1.2.1-81-gd414744-master
790	t	\N	339	4	2012-11-29 05:55:17.486289	2012-11-29 05:55:17.486289	https://basho-giddyup.s3.amazonaws.com/790.log	riak-1.2.1-81-gd414744-master
791	f	\N	355	4	2012-11-29 05:55:56.33754	2012-11-29 05:55:56.33754	https://basho-giddyup.s3.amazonaws.com/791.log	riak-1.2.1-81-gd414744-master
793	f	\N	17	4	2012-11-29 18:38:51.343045	2012-11-29 18:38:51.343045	https://basho-giddyup.s3.amazonaws.com/793.log	riak-1.2.1-81-gd414744-master
794	f	\N	7	4	2012-11-29 19:00:39.051833	2012-11-29 19:00:39.051833	https://basho-giddyup.s3.amazonaws.com/794.log	riak-1.2.1-81-gd414744-master
795	f	\N	17	4	2012-11-29 19:06:09.995986	2012-11-29 19:06:09.995986	https://basho-giddyup.s3.amazonaws.com/795.log	riak-1.2.1-81-gd414744-master
796	t	\N	27	4	2012-11-29 19:07:21.485557	2012-11-29 19:07:21.485557	https://basho-giddyup.s3.amazonaws.com/796.log	riak-1.2.1-81-gd414744-master
797	f	\N	37	4	2012-11-29 19:07:41.397238	2012-11-29 19:07:41.397238	https://basho-giddyup.s3.amazonaws.com/797.log	riak-1.2.1-81-gd414744-master
798	f	\N	47	4	2012-11-29 19:08:05.682886	2012-11-29 19:08:05.682886	https://basho-giddyup.s3.amazonaws.com/798.log	riak-1.2.1-81-gd414744-master
799	t	\N	57	4	2012-11-29 19:08:57.657913	2012-11-29 19:08:57.657913	https://basho-giddyup.s3.amazonaws.com/799.log	riak-1.2.1-81-gd414744-master
800	t	\N	67	4	2012-11-29 19:09:15.231247	2012-11-29 19:09:15.231247	https://basho-giddyup.s3.amazonaws.com/800.log	riak-1.2.1-81-gd414744-master
801	f	\N	87	4	2012-11-29 19:09:46.303864	2012-11-29 19:09:46.303864	https://basho-giddyup.s3.amazonaws.com/801.log	riak-1.2.1-81-gd414744-master
802	t	\N	97	4	2012-11-29 19:16:27.118584	2012-11-29 19:16:27.118584	https://basho-giddyup.s3.amazonaws.com/802.log	riak-1.2.1-81-gd414744-master
803	f	\N	107	4	2012-11-29 19:16:53.057055	2012-11-29 19:16:53.057055	https://basho-giddyup.s3.amazonaws.com/803.log	riak-1.2.1-81-gd414744-master
804	f	\N	117	4	2012-11-29 19:25:25.489402	2012-11-29 19:25:25.489402	https://basho-giddyup.s3.amazonaws.com/804.log	riak-1.2.1-81-gd414744-master
805	t	\N	127	4	2012-11-29 19:28:09.834454	2012-11-29 19:28:09.834454	https://basho-giddyup.s3.amazonaws.com/805.log	riak-1.2.1-81-gd414744-master
806	t	\N	137	4	2012-11-29 19:30:10.109502	2012-11-29 19:30:10.109502	https://basho-giddyup.s3.amazonaws.com/806.log	riak-1.2.1-81-gd414744-master
807	t	\N	147	4	2012-11-29 19:30:26.588199	2012-11-29 19:30:26.588199	https://basho-giddyup.s3.amazonaws.com/807.log	riak-1.2.1-81-gd414744-master
808	t	\N	157	4	2012-11-29 19:31:34.475682	2012-11-29 19:31:34.475682	https://basho-giddyup.s3.amazonaws.com/808.log	riak-1.2.1-81-gd414744-master
809	t	\N	167	4	2012-11-29 19:33:49.948788	2012-11-29 19:33:49.948788	https://basho-giddyup.s3.amazonaws.com/809.log	riak-1.2.1-81-gd414744-master
810	t	\N	183	4	2012-11-29 19:34:15.481201	2012-11-29 19:34:15.481201	https://basho-giddyup.s3.amazonaws.com/810.log	riak-1.2.1-81-gd414744-master
811	t	\N	184	4	2012-11-29 19:35:07.202901	2012-11-29 19:35:07.202901	https://basho-giddyup.s3.amazonaws.com/811.log	riak-1.2.1-81-gd414744-master
812	t	\N	237	4	2012-11-29 19:35:44.717002	2012-11-29 19:35:44.717002	https://basho-giddyup.s3.amazonaws.com/812.log	riak-1.2.1-81-gd414744-master
813	f	\N	249	4	2012-11-29 19:37:12.045684	2012-11-29 19:37:12.045684	https://basho-giddyup.s3.amazonaws.com/813.log	riak-1.2.1-81-gd414744-master
814	f	\N	261	4	2012-11-29 19:37:18.55169	2012-11-29 19:37:18.55169	https://basho-giddyup.s3.amazonaws.com/814.log	riak-1.2.1-81-gd414744-master
815	t	\N	273	4	2012-11-29 19:39:15.650093	2012-11-29 19:39:15.650093	https://basho-giddyup.s3.amazonaws.com/815.log	riak-1.2.1-81-gd414744-master
816	f	\N	285	4	2012-11-29 19:43:19.40843	2012-11-29 19:43:19.40843	https://basho-giddyup.s3.amazonaws.com/816.log	riak-1.2.1-81-gd414744-master
817	t	\N	304	4	2012-11-29 20:14:55.412827	2012-11-29 20:14:55.412827	https://basho-giddyup.s3.amazonaws.com/817.log	riak-1.2.1-81-gd414744-master
818	t	\N	338	4	2012-11-29 20:47:26.746579	2012-11-29 20:47:26.746579	https://basho-giddyup.s3.amazonaws.com/818.log	riak-1.2.1-81-gd414744-master
819	t	\N	305	4	2012-11-29 21:22:49.54432	2012-11-29 21:22:49.54432	https://basho-giddyup.s3.amazonaws.com/819.log	riak-1.2.1-81-gd414744-master
820	t	\N	7	4	2012-11-29 22:01:52.512895	2012-11-29 22:01:52.512895	https://basho-giddyup.s3.amazonaws.com/820.log	riak-1.2.1-83-gd8de021-master
821	f	\N	17	4	2012-11-29 22:02:32.621978	2012-11-29 22:02:32.621978	https://basho-giddyup.s3.amazonaws.com/821.log	riak-1.2.1-83-gd8de021-master
822	t	\N	27	4	2012-11-29 22:04:32.022401	2012-11-29 22:04:32.022401	https://basho-giddyup.s3.amazonaws.com/822.log	riak-1.2.1-83-gd8de021-master
823	f	\N	37	4	2012-11-29 22:05:09.025434	2012-11-29 22:05:09.025434	https://basho-giddyup.s3.amazonaws.com/823.log	riak-1.2.1-83-gd8de021-master
824	f	\N	47	4	2012-11-29 22:05:51.448864	2012-11-29 22:05:51.448864	https://basho-giddyup.s3.amazonaws.com/824.log	riak-1.2.1-83-gd8de021-master
825	t	\N	57	4	2012-11-29 22:11:46.107188	2012-11-29 22:11:46.107188	https://basho-giddyup.s3.amazonaws.com/825.log	riak-1.2.1-83-gd8de021-master
826	t	\N	67	4	2012-11-29 22:17:26.355345	2012-11-29 22:17:26.355345	https://basho-giddyup.s3.amazonaws.com/826.log	riak-1.2.1-83-gd8de021-master
827	t	\N	87	4	2012-11-29 22:19:17.764949	2012-11-29 22:19:17.764949	https://basho-giddyup.s3.amazonaws.com/827.log	riak-1.2.1-83-gd8de021-master
828	t	\N	97	4	2012-11-29 22:26:10.164563	2012-11-29 22:26:10.164563	https://basho-giddyup.s3.amazonaws.com/828.log	riak-1.2.1-83-gd8de021-master
829	f	\N	107	4	2012-11-29 22:26:51.70345	2012-11-29 22:26:51.70345	https://basho-giddyup.s3.amazonaws.com/829.log	riak-1.2.1-83-gd8de021-master
830	f	\N	117	4	2012-11-29 22:30:37.297319	2012-11-29 22:30:37.297319	https://basho-giddyup.s3.amazonaws.com/830.log	riak-1.2.1-83-gd8de021-master
831	t	\N	127	4	2012-11-29 22:33:54.694279	2012-11-29 22:33:54.694279	https://basho-giddyup.s3.amazonaws.com/831.log	riak-1.2.1-83-gd8de021-master
832	f	\N	137	4	2012-11-29 22:34:32.32999	2012-11-29 22:34:32.32999	https://basho-giddyup.s3.amazonaws.com/832.log	riak-1.2.1-83-gd8de021-master
833	t	\N	147	4	2012-11-29 22:35:05.836692	2012-11-29 22:35:05.836692	https://basho-giddyup.s3.amazonaws.com/833.log	riak-1.2.1-83-gd8de021-master
834	t	\N	157	4	2012-11-29 22:36:26.818866	2012-11-29 22:36:26.818866	https://basho-giddyup.s3.amazonaws.com/834.log	riak-1.2.1-83-gd8de021-master
835	t	\N	167	4	2012-11-29 22:40:22.869229	2012-11-29 22:40:22.869229	https://basho-giddyup.s3.amazonaws.com/835.log	riak-1.2.1-83-gd8de021-master
836	t	\N	183	4	2012-11-29 22:41:10.849967	2012-11-29 22:41:10.849967	https://basho-giddyup.s3.amazonaws.com/836.log	riak-1.2.1-83-gd8de021-master
837	t	\N	184	4	2012-11-29 22:42:22.41272	2012-11-29 22:42:22.41272	https://basho-giddyup.s3.amazonaws.com/837.log	riak-1.2.1-83-gd8de021-master
838	t	\N	237	4	2012-11-29 22:43:21.670062	2012-11-29 22:43:21.670062	https://basho-giddyup.s3.amazonaws.com/838.log	riak-1.2.1-83-gd8de021-master
839	f	\N	249	4	2012-11-29 22:45:04.019336	2012-11-29 22:45:04.019336	https://basho-giddyup.s3.amazonaws.com/839.log	riak-1.2.1-83-gd8de021-master
840	f	\N	261	4	2012-11-29 22:45:10.953471	2012-11-29 22:45:10.953471	https://basho-giddyup.s3.amazonaws.com/840.log	riak-1.2.1-83-gd8de021-master
841	t	\N	273	4	2012-11-29 22:47:49.882301	2012-11-29 22:47:49.882301	https://basho-giddyup.s3.amazonaws.com/841.log	riak-1.2.1-83-gd8de021-master
842	f	\N	285	4	2012-11-29 22:57:15.007951	2012-11-29 22:57:15.007951	https://basho-giddyup.s3.amazonaws.com/842.log	riak-1.2.1-83-gd8de021-master
843	t	\N	304	4	2012-11-29 23:29:29.563914	2012-11-29 23:29:29.563914	https://basho-giddyup.s3.amazonaws.com/843.log	riak-1.2.1-83-gd8de021-master
844	f	\N	338	4	2012-11-29 23:30:05.374856	2012-11-29 23:30:05.374856	https://basho-giddyup.s3.amazonaws.com/844.log	riak-1.2.1-83-gd8de021-master
845	t	\N	305	4	2012-11-30 00:06:29.045813	2012-11-30 00:06:29.045813	https://basho-giddyup.s3.amazonaws.com/845.log	riak-1.2.1-83-gd8de021-master
846	t	\N	339	4	2012-11-30 00:44:48.359301	2012-11-30 00:44:48.359301	https://basho-giddyup.s3.amazonaws.com/846.log	riak-1.2.1-83-gd8de021-master
847	t	\N	355	4	2012-11-30 00:46:47.527127	2012-11-30 00:46:47.527127	https://basho-giddyup.s3.amazonaws.com/847.log	riak-1.2.1-83-gd8de021-master
848	t	\N	7	4	2012-11-30 21:25:53.03933	2012-11-30 21:25:53.03933	https://basho-giddyup.s3.amazonaws.com/848.log	riak-1.2.1-83-gd8de021-master
849	f	\N	17	4	2012-11-30 21:26:35.782348	2012-11-30 21:26:35.782348	https://basho-giddyup.s3.amazonaws.com/849.log	riak-1.2.1-83-gd8de021-master
850	t	\N	27	4	2012-11-30 21:28:38.913507	2012-11-30 21:28:38.913507	https://basho-giddyup.s3.amazonaws.com/850.log	riak-1.2.1-83-gd8de021-master
851	t	\N	37	4	2012-11-30 21:30:02.841769	2012-11-30 21:30:02.841769	https://basho-giddyup.s3.amazonaws.com/851.log	riak-1.2.1-83-gd8de021-master
852	f	\N	47	4	2012-11-30 21:30:48.2613	2012-11-30 21:30:48.2613	https://basho-giddyup.s3.amazonaws.com/852.log	riak-1.2.1-83-gd8de021-master
853	t	\N	57	4	2012-11-30 21:36:45.621458	2012-11-30 21:36:45.621458	https://basho-giddyup.s3.amazonaws.com/853.log	riak-1.2.1-83-gd8de021-master
854	t	\N	67	4	2012-11-30 21:42:23.048975	2012-11-30 21:42:23.048975	https://basho-giddyup.s3.amazonaws.com/854.log	riak-1.2.1-83-gd8de021-master
855	t	\N	87	4	2012-11-30 21:44:16.461846	2012-11-30 21:44:16.461846	https://basho-giddyup.s3.amazonaws.com/855.log	riak-1.2.1-83-gd8de021-master
856	t	\N	97	4	2012-11-30 21:50:55.961544	2012-11-30 21:50:55.961544	https://basho-giddyup.s3.amazonaws.com/856.log	riak-1.2.1-83-gd8de021-master
857	f	\N	107	4	2012-11-30 21:51:43.701904	2012-11-30 21:51:43.701904	https://basho-giddyup.s3.amazonaws.com/857.log	riak-1.2.1-83-gd8de021-master
858	f	\N	117	4	2012-11-30 22:00:37.433317	2012-11-30 22:00:37.433317	https://basho-giddyup.s3.amazonaws.com/858.log	riak-1.2.1-83-gd8de021-master
859	f	\N	127	4	2012-11-30 22:06:20.752933	2012-11-30 22:06:20.752933	https://basho-giddyup.s3.amazonaws.com/859.log	riak-1.2.1-83-gd8de021-master
860	t	\N	137	4	2012-11-30 22:10:35.08887	2012-11-30 22:10:35.08887	https://basho-giddyup.s3.amazonaws.com/860.log	riak-1.2.1-83-gd8de021-master
861	t	\N	147	4	2012-11-30 22:16:13.408026	2012-11-30 22:16:13.408026	https://basho-giddyup.s3.amazonaws.com/861.log	riak-1.2.1-83-gd8de021-master
862	t	\N	157	4	2012-11-30 22:17:34.955446	2012-11-30 22:17:34.955446	https://basho-giddyup.s3.amazonaws.com/862.log	riak-1.2.1-83-gd8de021-master
863	t	\N	167	4	2012-11-30 22:20:49.680835	2012-11-30 22:20:49.680835	https://basho-giddyup.s3.amazonaws.com/863.log	riak-1.2.1-83-gd8de021-master
864	t	\N	183	4	2012-11-30 22:26:41.765917	2012-11-30 22:26:41.765917	https://basho-giddyup.s3.amazonaws.com/864.log	riak-1.2.1-83-gd8de021-master
865	t	\N	184	4	2012-11-30 22:27:54.746954	2012-11-30 22:27:54.746954	https://basho-giddyup.s3.amazonaws.com/865.log	riak-1.2.1-83-gd8de021-master
866	t	\N	237	4	2012-11-30 22:28:49.266004	2012-11-30 22:28:49.266004	https://basho-giddyup.s3.amazonaws.com/866.log	riak-1.2.1-83-gd8de021-master
867	t	\N	249	4	2012-11-30 22:30:58.607935	2012-11-30 22:30:58.607935	https://basho-giddyup.s3.amazonaws.com/867.log	riak-1.2.1-83-gd8de021-master
868	f	\N	261	4	2012-11-30 22:31:09.914055	2012-11-30 22:31:09.914055	https://basho-giddyup.s3.amazonaws.com/868.log	riak-1.2.1-83-gd8de021-master
869	t	\N	273	4	2012-11-30 22:33:37.269799	2012-11-30 22:33:37.269799	https://basho-giddyup.s3.amazonaws.com/869.log	riak-1.2.1-83-gd8de021-master
870	f	\N	285	4	2012-11-30 22:42:31.926917	2012-11-30 22:42:31.926917	https://basho-giddyup.s3.amazonaws.com/870.log	riak-1.2.1-83-gd8de021-master
871	t	\N	304	4	2012-11-30 23:18:05.942678	2012-11-30 23:18:05.942678	https://basho-giddyup.s3.amazonaws.com/871.log	riak-1.2.1-83-gd8de021-master
872	f	\N	338	4	2012-11-30 23:18:41.421021	2012-11-30 23:18:41.421021	https://basho-giddyup.s3.amazonaws.com/872.log	riak-1.2.1-83-gd8de021-master
873	f	\N	305	4	2012-11-30 23:19:30.011219	2012-11-30 23:19:30.011219	https://basho-giddyup.s3.amazonaws.com/873.log	riak-1.2.1-83-gd8de021-master
874	f	\N	339	4	2012-11-30 23:20:17.668252	2012-11-30 23:20:17.668252	https://basho-giddyup.s3.amazonaws.com/874.log	riak-1.2.1-83-gd8de021-master
875	t	\N	355	4	2012-11-30 23:22:22.81853	2012-11-30 23:22:22.81853	https://basho-giddyup.s3.amazonaws.com/875.log	riak-1.2.1-83-gd8de021-master
876	t	\N	192	4	2012-12-01 14:39:44.447227	2012-12-01 14:39:44.447227	https://basho-giddyup.s3.amazonaws.com/876.log	riak-1.2.1-83-g217841f-master
877	t	\N	193	4	2012-12-01 14:40:19.490413	2012-12-01 14:40:19.490413	https://basho-giddyup.s3.amazonaws.com/877.log	riak-1.2.1-83-g217841f-master
878	t	\N	194	4	2012-12-01 15:36:44.312072	2012-12-01 15:36:44.312072	https://basho-giddyup.s3.amazonaws.com/878.log	riak-1.2.1-83-g217841f-master
879	t	\N	195	4	2012-12-01 15:37:46.453327	2012-12-01 15:37:46.453327	https://basho-giddyup.s3.amazonaws.com/879.log	riak-1.2.1-83-g217841f-master
880	f	\N	196	4	2012-12-01 15:38:11.38945	2012-12-01 15:38:11.38945	https://basho-giddyup.s3.amazonaws.com/880.log	riak-1.2.1-83-g217841f-master
881	t	\N	197	4	2012-12-01 15:39:15.175657	2012-12-01 15:39:15.175657	https://basho-giddyup.s3.amazonaws.com/881.log	riak-1.2.1-83-g217841f-master
882	t	\N	198	4	2012-12-01 15:39:35.09874	2012-12-01 15:39:35.09874	https://basho-giddyup.s3.amazonaws.com/882.log	riak-1.2.1-83-g217841f-master
883	t	\N	201	4	2012-12-01 16:58:34.934023	2012-12-01 16:58:34.934023	https://basho-giddyup.s3.amazonaws.com/883.log	riak-1.2.1-83-g217841f-master
884	f	\N	202	4	2012-12-01 17:02:17.022053	2012-12-01 17:02:17.022053	https://basho-giddyup.s3.amazonaws.com/884.log	riak-1.2.1-83-g217841f-master
885	f	\N	203	4	2012-12-01 17:04:57.558715	2012-12-01 17:04:57.558715	https://basho-giddyup.s3.amazonaws.com/885.log	riak-1.2.1-83-g217841f-master
886	t	\N	204	4	2012-12-01 17:06:11.449867	2012-12-01 17:06:11.449867	https://basho-giddyup.s3.amazonaws.com/886.log	riak-1.2.1-83-g217841f-master
887	t	\N	205	4	2012-12-01 17:08:14.248275	2012-12-01 17:08:14.248275	https://basho-giddyup.s3.amazonaws.com/887.log	riak-1.2.1-83-g217841f-master
888	t	\N	206	4	2012-12-01 17:08:29.784134	2012-12-01 17:08:29.784134	https://basho-giddyup.s3.amazonaws.com/888.log	riak-1.2.1-83-g217841f-master
889	t	\N	207	4	2012-12-01 17:09:35.278421	2012-12-01 17:09:35.278421	https://basho-giddyup.s3.amazonaws.com/889.log	riak-1.2.1-83-g217841f-master
890	t	\N	208	4	2012-12-01 17:12:16.973688	2012-12-01 17:12:16.973688	https://basho-giddyup.s3.amazonaws.com/890.log	riak-1.2.1-83-g217841f-master
891	t	\N	209	4	2012-12-01 17:13:22.274976	2012-12-01 17:13:22.274976	https://basho-giddyup.s3.amazonaws.com/891.log	riak-1.2.1-83-g217841f-master
892	t	\N	210	4	2012-12-01 17:14:01.553753	2012-12-01 17:14:01.553753	https://basho-giddyup.s3.amazonaws.com/892.log	riak-1.2.1-83-g217841f-master
893	t	\N	241	4	2012-12-01 17:14:47.990729	2012-12-01 17:14:47.990729	https://basho-giddyup.s3.amazonaws.com/893.log	riak-1.2.1-83-g217841f-master
894	t	\N	253	4	2012-12-01 17:16:28.100839	2012-12-01 17:16:28.100839	https://basho-giddyup.s3.amazonaws.com/894.log	riak-1.2.1-83-g217841f-master
895	f	\N	265	4	2012-12-01 17:16:37.217406	2012-12-01 17:16:37.217406	https://basho-giddyup.s3.amazonaws.com/895.log	riak-1.2.1-83-g217841f-master
896	t	\N	277	4	2012-12-01 17:18:13.899436	2012-12-01 17:18:13.899436	https://basho-giddyup.s3.amazonaws.com/896.log	riak-1.2.1-83-g217841f-master
897	t	\N	200	4	2012-12-01 17:29:56.297399	2012-12-01 17:29:56.297399	https://basho-giddyup.s3.amazonaws.com/897.log	riak-1.2.1-83-g217841f-master
898	f	\N	289	4	2012-12-01 17:32:25.198139	2012-12-01 17:32:25.198139	https://basho-giddyup.s3.amazonaws.com/898.log	riak-1.2.1-83-g217841f-master
899	t	\N	312	4	2012-12-01 18:09:38.308599	2012-12-01 18:09:38.308599	https://basho-giddyup.s3.amazonaws.com/899.log	riak-1.2.1-83-g217841f-master
900	t	\N	346	4	2012-12-01 18:42:19.114829	2012-12-01 18:42:19.114829	https://basho-giddyup.s3.amazonaws.com/900.log	riak-1.2.1-83-g217841f-master
901	t	\N	313	4	2012-12-01 19:30:38.365568	2012-12-01 19:30:38.365568	https://basho-giddyup.s3.amazonaws.com/901.log	riak-1.2.1-83-g217841f-master
902	t	\N	347	4	2012-12-01 20:17:13.086514	2012-12-01 20:17:13.086514	https://basho-giddyup.s3.amazonaws.com/902.log	riak-1.2.1-83-g217841f-master
903	t	\N	359	4	2012-12-01 20:19:12.967399	2012-12-01 20:19:12.967399	https://basho-giddyup.s3.amazonaws.com/903.log	riak-1.2.1-83-g217841f-master
904	t	\N	7	4	2012-12-03 16:17:49.355559	2012-12-03 16:17:49.355559	https://basho-giddyup.s3.amazonaws.com/904.log	riak-1.2.1-83-gd8de021-master
905	f	\N	17	4	2012-12-03 16:18:28.344904	2012-12-03 16:18:28.344904	https://basho-giddyup.s3.amazonaws.com/905.log	riak-1.2.1-83-gd8de021-master
906	t	\N	27	4	2012-12-03 16:20:17.858544	2012-12-03 16:20:17.858544	https://basho-giddyup.s3.amazonaws.com/906.log	riak-1.2.1-83-gd8de021-master
907	t	\N	37	4	2012-12-03 16:21:40.505029	2012-12-03 16:21:40.505029	https://basho-giddyup.s3.amazonaws.com/907.log	riak-1.2.1-83-gd8de021-master
908	f	\N	47	4	2012-12-03 16:22:22.980262	2012-12-03 16:22:22.980262	https://basho-giddyup.s3.amazonaws.com/908.log	riak-1.2.1-83-gd8de021-master
909	t	\N	57	4	2012-12-03 16:23:14.535706	2012-12-03 16:23:14.535706	https://basho-giddyup.s3.amazonaws.com/909.log	riak-1.2.1-83-gd8de021-master
910	t	\N	67	4	2012-12-03 16:28:53.383043	2012-12-03 16:28:53.383043	https://basho-giddyup.s3.amazonaws.com/910.log	riak-1.2.1-83-gd8de021-master
911	t	\N	87	4	2012-12-03 16:35:52.842777	2012-12-03 16:35:52.842777	https://basho-giddyup.s3.amazonaws.com/911.log	riak-1.2.1-83-gd8de021-master
912	t	\N	97	4	2012-12-03 16:42:40.54613	2012-12-03 16:42:40.54613	https://basho-giddyup.s3.amazonaws.com/912.log	riak-1.2.1-83-gd8de021-master
913	f	\N	107	4	2012-12-03 16:43:22.357068	2012-12-03 16:43:22.357068	https://basho-giddyup.s3.amazonaws.com/913.log	riak-1.2.1-83-gd8de021-master
914	f	\N	117	4	2012-12-03 16:47:08.934375	2012-12-03 16:47:08.934375	https://basho-giddyup.s3.amazonaws.com/914.log	riak-1.2.1-83-gd8de021-master
915	t	\N	127	4	2012-12-03 16:50:08.389078	2012-12-03 16:50:08.389078	https://basho-giddyup.s3.amazonaws.com/915.log	riak-1.2.1-83-gd8de021-master
916	t	\N	137	4	2012-12-03 16:52:20.355143	2012-12-03 16:52:20.355143	https://basho-giddyup.s3.amazonaws.com/916.log	riak-1.2.1-83-gd8de021-master
917	t	\N	147	4	2012-12-03 16:57:57.477091	2012-12-03 16:57:57.477091	https://basho-giddyup.s3.amazonaws.com/917.log	riak-1.2.1-83-gd8de021-master
918	t	\N	157	4	2012-12-03 16:59:19.077366	2012-12-03 16:59:19.077366	https://basho-giddyup.s3.amazonaws.com/918.log	riak-1.2.1-83-gd8de021-master
919	t	\N	167	4	2012-12-03 17:01:57.057978	2012-12-03 17:01:57.057978	https://basho-giddyup.s3.amazonaws.com/919.log	riak-1.2.1-83-gd8de021-master
920	t	\N	183	4	2012-12-03 17:02:42.068811	2012-12-03 17:02:42.068811	https://basho-giddyup.s3.amazonaws.com/920.log	riak-1.2.1-83-gd8de021-master
921	t	\N	184	4	2012-12-03 17:03:54.244629	2012-12-03 17:03:54.244629	https://basho-giddyup.s3.amazonaws.com/921.log	riak-1.2.1-83-gd8de021-master
922	t	\N	237	4	2012-12-03 17:04:49.153482	2012-12-03 17:04:49.153482	https://basho-giddyup.s3.amazonaws.com/922.log	riak-1.2.1-83-gd8de021-master
923	t	\N	249	4	2012-12-03 17:07:00.736188	2012-12-03 17:07:00.736188	https://basho-giddyup.s3.amazonaws.com/923.log	riak-1.2.1-83-gd8de021-master
924	f	\N	261	4	2012-12-03 17:07:09.446349	2012-12-03 17:07:09.446349	https://basho-giddyup.s3.amazonaws.com/924.log	riak-1.2.1-83-gd8de021-master
925	t	\N	273	4	2012-12-03 17:09:46.852043	2012-12-03 17:09:46.852043	https://basho-giddyup.s3.amazonaws.com/925.log	riak-1.2.1-83-gd8de021-master
926	f	\N	285	4	2012-12-03 17:18:31.163878	2012-12-03 17:18:31.163878	https://basho-giddyup.s3.amazonaws.com/926.log	riak-1.2.1-83-gd8de021-master
927	t	\N	304	4	2012-12-03 17:55:00.823564	2012-12-03 17:55:00.823564	https://basho-giddyup.s3.amazonaws.com/927.log	riak-1.2.1-83-gd8de021-master
928	t	\N	338	4	2012-12-03 18:27:41.348185	2012-12-03 18:27:41.348185	https://basho-giddyup.s3.amazonaws.com/928.log	riak-1.2.1-83-gd8de021-master
929	t	\N	305	4	2012-12-03 19:04:11.682182	2012-12-03 19:04:11.682182	https://basho-giddyup.s3.amazonaws.com/929.log	riak-1.2.1-83-gd8de021-master
930	t	\N	339	4	2012-12-03 19:42:42.484543	2012-12-03 19:42:42.484543	https://basho-giddyup.s3.amazonaws.com/930.log	riak-1.2.1-83-gd8de021-master
931	t	\N	355	4	2012-12-03 19:44:42.995905	2012-12-03 19:44:42.995905	https://basho-giddyup.s3.amazonaws.com/931.log	riak-1.2.1-83-gd8de021-master
932	t	\N	4	4	2012-12-03 22:12:32.587664	2012-12-03 22:12:32.587664	https://basho-giddyup.s3.amazonaws.com/932.log	riak-1.2.1-81-ge681ace-master
933	f	\N	14	4	2012-12-03 22:13:00.397577	2012-12-03 22:13:00.397577	https://basho-giddyup.s3.amazonaws.com/933.log	riak-1.2.1-81-ge681ace-master
934	t	\N	24	4	2012-12-03 22:14:01.805181	2012-12-03 22:14:01.805181	https://basho-giddyup.s3.amazonaws.com/934.log	riak-1.2.1-81-ge681ace-master
935	t	\N	34	4	2012-12-03 22:20:09.141793	2012-12-03 22:20:09.141793	https://basho-giddyup.s3.amazonaws.com/935.log	riak-1.2.1-81-ge681ace-master
936	f	\N	44	4	2012-12-03 22:20:34.324079	2012-12-03 22:20:34.324079	https://basho-giddyup.s3.amazonaws.com/936.log	riak-1.2.1-81-ge681ace-master
937	t	\N	54	4	2012-12-03 22:21:24.808418	2012-12-03 22:21:24.808418	https://basho-giddyup.s3.amazonaws.com/937.log	riak-1.2.1-81-ge681ace-master
938	t	\N	64	4	2012-12-03 22:26:51.885863	2012-12-03 22:26:51.885863	https://basho-giddyup.s3.amazonaws.com/938.log	riak-1.2.1-81-ge681ace-master
939	t	\N	94	4	2012-12-03 22:27:19.648983	2012-12-03 22:27:19.648983	https://basho-giddyup.s3.amazonaws.com/939.log	riak-1.2.1-81-ge681ace-master
940	f	\N	84	4	2012-12-03 22:27:46.455602	2012-12-03 22:27:46.455602	https://basho-giddyup.s3.amazonaws.com/940.log	riak-1.2.1-81-ge681ace-master
941	f	\N	104	4	2012-12-03 22:33:17.662648	2012-12-03 22:33:17.662648	https://basho-giddyup.s3.amazonaws.com/941.log	riak-1.2.1-81-ge681ace-master
942	t	\N	114	4	2012-12-03 22:38:57.280207	2012-12-03 22:38:57.280207	https://basho-giddyup.s3.amazonaws.com/942.log	riak-1.2.1-81-ge681ace-master
943	t	\N	124	4	2012-12-03 22:39:50.348009	2012-12-03 22:39:50.348009	https://basho-giddyup.s3.amazonaws.com/943.log	riak-1.2.1-81-ge681ace-master
944	t	\N	134	4	2012-12-03 22:42:50.414233	2012-12-03 22:42:50.414233	https://basho-giddyup.s3.amazonaws.com/944.log	riak-1.2.1-81-ge681ace-master
945	t	\N	144	4	2012-12-03 22:43:10.398596	2012-12-03 22:43:10.398596	https://basho-giddyup.s3.amazonaws.com/945.log	riak-1.2.1-81-ge681ace-master
946	t	\N	154	4	2012-12-03 22:44:17.678725	2012-12-03 22:44:17.678725	https://basho-giddyup.s3.amazonaws.com/946.log	riak-1.2.1-81-ge681ace-master
947	t	\N	164	4	2012-12-03 22:46:33.867046	2012-12-03 22:46:33.867046	https://basho-giddyup.s3.amazonaws.com/947.log	riak-1.2.1-81-ge681ace-master
948	t	\N	177	4	2012-12-03 22:46:57.674714	2012-12-03 22:46:57.674714	https://basho-giddyup.s3.amazonaws.com/948.log	riak-1.2.1-81-ge681ace-master
949	t	\N	178	4	2012-12-03 22:47:50.573128	2012-12-03 22:47:50.573128	https://basho-giddyup.s3.amazonaws.com/949.log	riak-1.2.1-81-ge681ace-master
950	t	\N	233	4	2012-12-03 22:48:22.528524	2012-12-03 22:48:22.528524	https://basho-giddyup.s3.amazonaws.com/950.log	riak-1.2.1-81-ge681ace-master
951	t	\N	245	4	2012-12-03 22:50:17.874004	2012-12-03 22:50:17.874004	https://basho-giddyup.s3.amazonaws.com/951.log	riak-1.2.1-81-ge681ace-master
952	f	\N	257	4	2012-12-03 22:50:28.772674	2012-12-03 22:50:28.772674	https://basho-giddyup.s3.amazonaws.com/952.log	riak-1.2.1-81-ge681ace-master
953	t	\N	269	4	2012-12-03 22:52:27.862983	2012-12-03 22:52:27.862983	https://basho-giddyup.s3.amazonaws.com/953.log	riak-1.2.1-81-ge681ace-master
954	f	\N	281	4	2012-12-03 22:53:59.11704	2012-12-03 22:53:59.11704	https://basho-giddyup.s3.amazonaws.com/954.log	riak-1.2.1-81-ge681ace-master
955	t	\N	7	4	2012-12-03 23:09:42.015594	2012-12-03 23:09:42.015594	https://basho-giddyup.s3.amazonaws.com/955.log	riak-1.2.1-83-gd8de021-master
956	f	\N	17	4	2012-12-03 23:10:20.728397	2012-12-03 23:10:20.728397	https://basho-giddyup.s3.amazonaws.com/956.log	riak-1.2.1-83-gd8de021-master
957	t	\N	27	4	2012-12-03 23:11:56.749026	2012-12-03 23:11:56.749026	https://basho-giddyup.s3.amazonaws.com/957.log	riak-1.2.1-83-gd8de021-master
958	t	\N	37	4	2012-12-03 23:13:17.308533	2012-12-03 23:13:17.308533	https://basho-giddyup.s3.amazonaws.com/958.log	riak-1.2.1-83-gd8de021-master
959	t	\N	47	4	2012-12-03 23:14:07.589191	2012-12-03 23:14:07.589191	https://basho-giddyup.s3.amazonaws.com/959.log	riak-1.2.1-83-gd8de021-master
960	t	\N	57	4	2012-12-03 23:15:08.605824	2012-12-03 23:15:08.605824	https://basho-giddyup.s3.amazonaws.com/960.log	riak-1.2.1-83-gd8de021-master
961	t	\N	67	4	2012-12-03 23:20:48.855943	2012-12-03 23:20:48.855943	https://basho-giddyup.s3.amazonaws.com/961.log	riak-1.2.1-83-gd8de021-master
962	t	\N	87	4	2012-12-03 23:22:38.452704	2012-12-03 23:22:38.452704	https://basho-giddyup.s3.amazonaws.com/962.log	riak-1.2.1-83-gd8de021-master
963	t	\N	296	4	2012-12-03 23:26:18.661707	2012-12-03 23:26:18.661707	https://basho-giddyup.s3.amazonaws.com/963.log	riak-1.2.1-81-ge681ace-master
964	f	\N	97	4	2012-12-03 23:26:59.139126	2012-12-03 23:26:59.139126	https://basho-giddyup.s3.amazonaws.com/964.log	riak-1.2.1-83-gd8de021-master
965	f	\N	107	4	2012-12-03 23:27:41.675655	2012-12-03 23:27:41.675655	https://basho-giddyup.s3.amazonaws.com/965.log	riak-1.2.1-83-gd8de021-master
966	f	\N	117	4	2012-12-03 23:36:39.173705	2012-12-03 23:36:39.173705	https://basho-giddyup.s3.amazonaws.com/966.log	riak-1.2.1-83-gd8de021-master
967	t	\N	127	4	2012-12-03 23:40:05.714001	2012-12-03 23:40:05.714001	https://basho-giddyup.s3.amazonaws.com/967.log	riak-1.2.1-83-gd8de021-master
968	t	\N	137	4	2012-12-03 23:42:18.11531	2012-12-03 23:42:18.11531	https://basho-giddyup.s3.amazonaws.com/968.log	riak-1.2.1-83-gd8de021-master
969	t	\N	147	4	2012-12-03 23:47:56.312816	2012-12-03 23:47:56.312816	https://basho-giddyup.s3.amazonaws.com/969.log	riak-1.2.1-83-gd8de021-master
970	t	\N	157	4	2012-12-03 23:49:17.93584	2012-12-03 23:49:17.93584	https://basho-giddyup.s3.amazonaws.com/970.log	riak-1.2.1-83-gd8de021-master
971	t	\N	167	4	2012-12-03 23:52:15.621746	2012-12-03 23:52:15.621746	https://basho-giddyup.s3.amazonaws.com/971.log	riak-1.2.1-83-gd8de021-master
972	t	\N	183	4	2012-12-03 23:58:09.185409	2012-12-03 23:58:09.185409	https://basho-giddyup.s3.amazonaws.com/972.log	riak-1.2.1-83-gd8de021-master
973	t	\N	184	4	2012-12-03 23:59:18.914478	2012-12-03 23:59:18.914478	https://basho-giddyup.s3.amazonaws.com/973.log	riak-1.2.1-83-gd8de021-master
974	t	\N	332	4	2012-12-03 23:59:20.833681	2012-12-03 23:59:20.833681	https://basho-giddyup.s3.amazonaws.com/974.log	riak-1.2.1-81-ge681ace-master
975	t	\N	237	4	2012-12-04 00:00:12.566101	2012-12-04 00:00:12.566101	https://basho-giddyup.s3.amazonaws.com/975.log	riak-1.2.1-83-gd8de021-master
976	t	\N	249	4	2012-12-04 00:02:26.28791	2012-12-04 00:02:26.28791	https://basho-giddyup.s3.amazonaws.com/976.log	riak-1.2.1-83-gd8de021-master
977	f	\N	261	4	2012-12-04 00:02:36.547601	2012-12-04 00:02:36.547601	https://basho-giddyup.s3.amazonaws.com/977.log	riak-1.2.1-83-gd8de021-master
978	t	\N	273	4	2012-12-04 00:05:08.985773	2012-12-04 00:05:08.985773	https://basho-giddyup.s3.amazonaws.com/978.log	riak-1.2.1-83-gd8de021-master
979	f	\N	285	4	2012-12-04 00:09:15.484518	2012-12-04 00:09:15.484518	https://basho-giddyup.s3.amazonaws.com/979.log	riak-1.2.1-83-gd8de021-master
980	t	\N	297	4	2012-12-04 00:38:36.669171	2012-12-04 00:38:36.669171	https://basho-giddyup.s3.amazonaws.com/980.log	riak-1.2.1-81-ge681ace-master
981	f	\N	333	4	2012-12-04 00:39:11.529596	2012-12-04 00:39:11.529596	https://basho-giddyup.s3.amazonaws.com/981.log	riak-1.2.1-81-ge681ace-master
982	f	\N	353	4	2012-12-04 00:39:48.827266	2012-12-04 00:39:48.827266	https://basho-giddyup.s3.amazonaws.com/982.log	riak-1.2.1-81-ge681ace-master
983	t	\N	304	4	2012-12-04 00:42:16.098984	2012-12-04 00:42:16.098984	https://basho-giddyup.s3.amazonaws.com/983.log	riak-1.2.1-83-gd8de021-master
984	t	\N	338	4	2012-12-04 01:12:59.565557	2012-12-04 01:12:59.565557	https://basho-giddyup.s3.amazonaws.com/984.log	riak-1.2.1-83-gd8de021-master
985	t	\N	305	4	2012-12-04 01:48:48.218882	2012-12-04 01:48:48.218882	https://basho-giddyup.s3.amazonaws.com/985.log	riak-1.2.1-83-gd8de021-master
986	t	\N	339	4	2012-12-04 02:25:03.09326	2012-12-04 02:25:03.09326	https://basho-giddyup.s3.amazonaws.com/986.log	riak-1.2.1-83-gd8de021-master
987	t	\N	355	4	2012-12-04 02:27:01.566434	2012-12-04 02:27:01.566434	https://basho-giddyup.s3.amazonaws.com/987.log	riak-1.2.1-83-gd8de021-master
988	t	\N	369	4	2012-12-04 02:27:42.877503	2012-12-04 02:27:42.877503	https://basho-giddyup.s3.amazonaws.com/988.log	riak-1.2.1-83-gd8de021-master
989	t	\N	381	4	2012-12-04 02:33:23.048747	2012-12-04 02:33:23.048747	https://basho-giddyup.s3.amazonaws.com/989.log	riak-1.2.1-83-gd8de021-master
990	f	\N	393	4	2012-12-04 02:34:11.946698	2012-12-04 02:34:11.946698	https://basho-giddyup.s3.amazonaws.com/990.log	riak-1.2.1-83-gd8de021-master
991	t	\N	4	4	2012-12-04 12:06:17.888963	2012-12-04 12:06:17.888963	https://basho-giddyup.s3.amazonaws.com/991.log	riak-1.2.1-81-ge681ace-master
992	f	\N	14	4	2012-12-04 12:06:40.257693	2012-12-04 12:06:40.257693	https://basho-giddyup.s3.amazonaws.com/992.log	riak-1.2.1-81-ge681ace-master
993	t	\N	24	4	2012-12-04 12:07:38.462295	2012-12-04 12:07:38.462295	https://basho-giddyup.s3.amazonaws.com/993.log	riak-1.2.1-81-ge681ace-master
994	t	\N	34	4	2012-12-04 12:08:40.896538	2012-12-04 12:08:40.896538	https://basho-giddyup.s3.amazonaws.com/994.log	riak-1.2.1-81-ge681ace-master
995	t	\N	44	4	2012-12-04 12:09:12.898506	2012-12-04 12:09:12.898506	https://basho-giddyup.s3.amazonaws.com/995.log	riak-1.2.1-81-ge681ace-master
996	t	\N	54	4	2012-12-04 12:09:59.965293	2012-12-04 12:09:59.965293	https://basho-giddyup.s3.amazonaws.com/996.log	riak-1.2.1-81-ge681ace-master
997	t	\N	64	4	2012-12-04 12:10:16.92883	2012-12-04 12:10:16.92883	https://basho-giddyup.s3.amazonaws.com/997.log	riak-1.2.1-81-ge681ace-master
998	t	\N	94	4	2012-12-04 12:16:35.59867	2012-12-04 12:16:35.59867	https://basho-giddyup.s3.amazonaws.com/998.log	riak-1.2.1-81-ge681ace-master
999	t	\N	84	4	2012-12-04 12:18:06.203546	2012-12-04 12:18:06.203546	https://basho-giddyup.s3.amazonaws.com/999.log	riak-1.2.1-81-ge681ace-master
1000	f	\N	104	4	2012-12-04 12:18:30.592557	2012-12-04 12:18:30.592557	https://basho-giddyup.s3.amazonaws.com/1000.log	riak-1.2.1-81-ge681ace-master
1001	f	\N	114	4	2012-12-04 12:27:03.51858	2012-12-04 12:27:03.51858	https://basho-giddyup.s3.amazonaws.com/1001.log	riak-1.2.1-81-ge681ace-master
1002	t	\N	124	4	2012-12-04 12:30:04.942294	2012-12-04 12:30:04.942294	https://basho-giddyup.s3.amazonaws.com/1002.log	riak-1.2.1-81-ge681ace-master
1003	t	\N	134	4	2012-12-04 12:31:55.111681	2012-12-04 12:31:55.111681	https://basho-giddyup.s3.amazonaws.com/1003.log	riak-1.2.1-81-ge681ace-master
1004	t	\N	144	4	2012-12-04 12:32:09.293213	2012-12-04 12:32:09.293213	https://basho-giddyup.s3.amazonaws.com/1004.log	riak-1.2.1-81-ge681ace-master
1005	t	\N	154	4	2012-12-04 12:33:14.150299	2012-12-04 12:33:14.150299	https://basho-giddyup.s3.amazonaws.com/1005.log	riak-1.2.1-81-ge681ace-master
1006	t	\N	164	4	2012-12-04 12:35:31.128891	2012-12-04 12:35:31.128891	https://basho-giddyup.s3.amazonaws.com/1006.log	riak-1.2.1-81-ge681ace-master
1007	t	\N	177	4	2012-12-04 12:35:56.627461	2012-12-04 12:35:56.627461	https://basho-giddyup.s3.amazonaws.com/1007.log	riak-1.2.1-81-ge681ace-master
1008	t	\N	178	4	2012-12-04 12:36:49.018852	2012-12-04 12:36:49.018852	https://basho-giddyup.s3.amazonaws.com/1008.log	riak-1.2.1-81-ge681ace-master
1009	t	\N	233	4	2012-12-04 12:37:20.178221	2012-12-04 12:37:20.178221	https://basho-giddyup.s3.amazonaws.com/1009.log	riak-1.2.1-81-ge681ace-master
1010	f	\N	245	4	2012-12-04 12:39:14.732591	2012-12-04 12:39:14.732591	https://basho-giddyup.s3.amazonaws.com/1010.log	riak-1.2.1-81-ge681ace-master
1011	f	\N	257	4	2012-12-04 12:39:24.996677	2012-12-04 12:39:24.996677	https://basho-giddyup.s3.amazonaws.com/1011.log	riak-1.2.1-81-ge681ace-master
1012	t	\N	269	4	2012-12-04 12:41:27.875544	2012-12-04 12:41:27.875544	https://basho-giddyup.s3.amazonaws.com/1012.log	riak-1.2.1-81-ge681ace-master
1013	f	\N	281	4	2012-12-04 12:42:47.938825	2012-12-04 12:42:47.938825	https://basho-giddyup.s3.amazonaws.com/1013.log	riak-1.2.1-81-ge681ace-master
1014	t	\N	296	4	2012-12-04 13:15:49.561428	2012-12-04 13:15:49.561428	https://basho-giddyup.s3.amazonaws.com/1014.log	riak-1.2.1-81-ge681ace-master
1015	t	\N	332	4	2012-12-04 13:49:09.957014	2012-12-04 13:49:09.957014	https://basho-giddyup.s3.amazonaws.com/1015.log	riak-1.2.1-81-ge681ace-master
1016	t	\N	297	4	2012-12-04 14:30:53.703635	2012-12-04 14:30:53.703635	https://basho-giddyup.s3.amazonaws.com/1016.log	riak-1.2.1-81-ge681ace-master
1017	t	\N	333	4	2012-12-04 15:11:13.056069	2012-12-04 15:11:13.056069	https://basho-giddyup.s3.amazonaws.com/1017.log	riak-1.2.1-81-ge681ace-master
1018	f	\N	353	4	2012-12-04 15:11:54.358899	2012-12-04 15:11:54.358899	https://basho-giddyup.s3.amazonaws.com/1018.log	riak-1.2.1-81-ge681ace-master
1019	t	\N	365	4	2012-12-04 15:12:17.897159	2012-12-04 15:12:17.897159	https://basho-giddyup.s3.amazonaws.com/1019.log	riak-1.2.1-81-ge681ace-master
1020	t	\N	377	4	2012-12-04 15:12:34.760707	2012-12-04 15:12:34.760707	https://basho-giddyup.s3.amazonaws.com/1020.log	riak-1.2.1-81-ge681ace-master
1021	t	\N	389	4	2012-12-04 15:13:07.53877	2012-12-04 15:13:07.53877	https://basho-giddyup.s3.amazonaws.com/1021.log	riak-1.2.1-81-ge681ace-master
1022	t	\N	7	4	2012-12-05 18:59:24.190947	2012-12-05 18:59:24.190947	https://basho-giddyup.s3.amazonaws.com/1022.log	riak-1.2.1-83-gd8de021-master
1023	t	\N	17	4	2012-12-05 19:00:24.848032	2012-12-05 19:00:24.848032	https://basho-giddyup.s3.amazonaws.com/1023.log	riak-1.2.1-83-gd8de021-master
1024	t	\N	27	4	2012-12-05 19:07:22.690915	2012-12-05 19:07:22.690915	https://basho-giddyup.s3.amazonaws.com/1024.log	riak-1.2.1-83-gd8de021-master
1025	t	\N	37	4	2012-12-05 19:08:42.469245	2012-12-05 19:08:42.469245	https://basho-giddyup.s3.amazonaws.com/1025.log	riak-1.2.1-83-gd8de021-master
1026	t	\N	47	4	2012-12-05 19:09:33.010977	2012-12-05 19:09:33.010977	https://basho-giddyup.s3.amazonaws.com/1026.log	riak-1.2.1-83-gd8de021-master
1027	t	\N	57	4	2012-12-05 19:10:20.284691	2012-12-05 19:10:20.284691	https://basho-giddyup.s3.amazonaws.com/1027.log	riak-1.2.1-83-gd8de021-master
1028	t	\N	67	4	2012-12-05 19:10:57.816679	2012-12-05 19:10:57.816679	https://basho-giddyup.s3.amazonaws.com/1028.log	riak-1.2.1-83-gd8de021-master
1029	t	\N	87	4	2012-12-05 19:12:49.666484	2012-12-05 19:12:49.666484	https://basho-giddyup.s3.amazonaws.com/1029.log	riak-1.2.1-83-gd8de021-master
1030	t	\N	97	4	2012-12-05 19:19:27.736162	2012-12-05 19:19:27.736162	https://basho-giddyup.s3.amazonaws.com/1030.log	riak-1.2.1-83-gd8de021-master
1031	f	\N	107	4	2012-12-05 19:20:09.979845	2012-12-05 19:20:09.979845	https://basho-giddyup.s3.amazonaws.com/1031.log	riak-1.2.1-83-gd8de021-master
1032	f	\N	117	4	2012-12-05 19:23:48.57936	2012-12-05 19:23:48.57936	https://basho-giddyup.s3.amazonaws.com/1032.log	riak-1.2.1-83-gd8de021-master
1033	t	\N	127	4	2012-12-05 19:26:45.804386	2012-12-05 19:26:45.804386	https://basho-giddyup.s3.amazonaws.com/1033.log	riak-1.2.1-83-gd8de021-master
1034	t	\N	137	4	2012-12-05 19:34:16.208909	2012-12-05 19:34:16.208909	https://basho-giddyup.s3.amazonaws.com/1034.log	riak-1.2.1-83-gd8de021-master
1035	t	\N	147	4	2012-12-05 19:34:48.458713	2012-12-05 19:34:48.458713	https://basho-giddyup.s3.amazonaws.com/1035.log	riak-1.2.1-83-gd8de021-master
1036	t	\N	157	4	2012-12-05 19:36:14.323201	2012-12-05 19:36:14.323201	https://basho-giddyup.s3.amazonaws.com/1036.log	riak-1.2.1-83-gd8de021-master
1037	t	\N	167	4	2012-12-05 19:39:12.206556	2012-12-05 19:39:12.206556	https://basho-giddyup.s3.amazonaws.com/1037.log	riak-1.2.1-83-gd8de021-master
1038	t	\N	192	4	2012-12-05 19:39:41.660365	2012-12-05 19:39:41.660365	https://basho-giddyup.s3.amazonaws.com/1038.log	riak-1.2.1-83-gd8de021-master
1039	f	\N	193	4	2012-12-05 19:40:14.284209	2012-12-05 19:40:14.284209	https://basho-giddyup.s3.amazonaws.com/1039.log	riak-1.2.1-83-gd8de021-master
1040	t	\N	183	4	2012-12-05 19:45:04.290568	2012-12-05 19:45:04.290568	https://basho-giddyup.s3.amazonaws.com/1040.log	riak-1.2.1-83-gd8de021-master
1041	t	\N	184	4	2012-12-05 19:46:15.916633	2012-12-05 19:46:15.916633	https://basho-giddyup.s3.amazonaws.com/1041.log	riak-1.2.1-83-gd8de021-master
1042	t	\N	237	4	2012-12-05 19:47:11.793942	2012-12-05 19:47:11.793942	https://basho-giddyup.s3.amazonaws.com/1042.log	riak-1.2.1-83-gd8de021-master
1043	f	\N	249	4	2012-12-05 19:49:20.8367	2012-12-05 19:49:20.8367	https://basho-giddyup.s3.amazonaws.com/1043.log	riak-1.2.1-83-gd8de021-master
1044	f	\N	261	4	2012-12-05 19:51:34.920978	2012-12-05 19:51:34.920978	https://basho-giddyup.s3.amazonaws.com/1044.log	riak-1.2.1-83-gd8de021-master
1045	t	\N	273	4	2012-12-05 19:54:07.02559	2012-12-05 19:54:07.02559	https://basho-giddyup.s3.amazonaws.com/1045.log	riak-1.2.1-83-gd8de021-master
1046	f	\N	285	4	2012-12-05 19:57:46.373423	2012-12-05 19:57:46.373423	https://basho-giddyup.s3.amazonaws.com/1046.log	riak-1.2.1-83-gd8de021-master
1047	t	\N	304	4	2012-12-05 20:30:47.391272	2012-12-05 20:30:47.391272	https://basho-giddyup.s3.amazonaws.com/1047.log	riak-1.2.1-83-gd8de021-master
1048	t	\N	9	4	2012-12-05 20:46:53.083052	2012-12-05 20:46:53.083052	https://basho-giddyup.s3.amazonaws.com/1048.log	riak-1.2.1-86-g818abe2-master
1049	t	\N	19	4	2012-12-05 20:49:00.573721	2012-12-05 20:49:00.573721	https://basho-giddyup.s3.amazonaws.com/1049.log	riak-1.2.1-86-g818abe2-master
1050	t	\N	29	4	2012-12-05 21:00:25.550371	2012-12-05 21:00:25.550371	https://basho-giddyup.s3.amazonaws.com/1050.log	riak-1.2.1-86-g818abe2-master
1051	t	\N	338	4	2012-12-05 21:03:41.006016	2012-12-05 21:03:41.006016	https://basho-giddyup.s3.amazonaws.com/1051.log	riak-1.2.1-83-gd8de021-master
1052	t	\N	39	4	2012-12-05 21:07:17.24059	2012-12-05 21:07:17.24059	https://basho-giddyup.s3.amazonaws.com/1052.log	riak-1.2.1-86-g818abe2-master
1053	t	\N	49	4	2012-12-05 21:10:25.059414	2012-12-05 21:10:25.059414	https://basho-giddyup.s3.amazonaws.com/1053.log	riak-1.2.1-86-g818abe2-master
1054	f	\N	59	4	2012-12-05 21:10:34.501755	2012-12-05 21:10:34.501755	https://basho-giddyup.s3.amazonaws.com/1054.log	riak-1.2.1-86-g818abe2-master
1055	t	\N	69	4	2012-12-05 21:13:00.905941	2012-12-05 21:13:00.905941	https://basho-giddyup.s3.amazonaws.com/1055.log	riak-1.2.1-86-g818abe2-master
1056	f	\N	99	4	2012-12-05 21:16:49.009158	2012-12-05 21:16:49.009158	https://basho-giddyup.s3.amazonaws.com/1056.log	riak-1.2.1-86-g818abe2-master
1057	f	\N	109	4	2012-12-05 21:22:16.588011	2012-12-05 21:22:16.588011	https://basho-giddyup.s3.amazonaws.com/1057.log	riak-1.2.1-86-g818abe2-master
1058	f	\N	119	4	2012-12-05 21:29:15.920103	2012-12-05 21:29:15.920103	https://basho-giddyup.s3.amazonaws.com/1058.log	riak-1.2.1-86-g818abe2-master
1059	t	\N	129	4	2012-12-05 21:36:05.853734	2012-12-05 21:36:05.853734	https://basho-giddyup.s3.amazonaws.com/1059.log	riak-1.2.1-86-g818abe2-master
1060	t	\N	305	4	2012-12-05 21:42:40.239335	2012-12-05 21:42:40.239335	https://basho-giddyup.s3.amazonaws.com/1060.log	riak-1.2.1-83-gd8de021-master
1061	t	\N	139	4	2012-12-05 21:48:45.408551	2012-12-05 21:48:45.408551	https://basho-giddyup.s3.amazonaws.com/1061.log	riak-1.2.1-86-g818abe2-master
1062	f	\N	149	4	2012-12-05 21:55:19.732192	2012-12-05 21:55:19.732192	https://basho-giddyup.s3.amazonaws.com/1062.log	riak-1.2.1-86-g818abe2-master
1063	t	\N	159	4	2012-12-05 21:57:27.583665	2012-12-05 21:57:27.583665	https://basho-giddyup.s3.amazonaws.com/1063.log	riak-1.2.1-86-g818abe2-master
1064	f	\N	169	4	2012-12-05 22:02:13.579426	2012-12-05 22:02:13.579426	https://basho-giddyup.s3.amazonaws.com/1064.log	riak-1.2.1-86-g818abe2-master
1065	t	\N	187	4	2012-12-05 22:11:33.074544	2012-12-05 22:11:33.074544	https://basho-giddyup.s3.amazonaws.com/1065.log	riak-1.2.1-86-g818abe2-master
1066	f	\N	188	4	2012-12-05 22:15:51.286716	2012-12-05 22:15:51.286716	https://basho-giddyup.s3.amazonaws.com/1066.log	riak-1.2.1-86-g818abe2-master
1067	t	\N	239	4	2012-12-05 22:18:08.80433	2012-12-05 22:18:08.80433	https://basho-giddyup.s3.amazonaws.com/1067.log	riak-1.2.1-86-g818abe2-master
1068	t	\N	339	4	2012-12-05 22:19:40.540992	2012-12-05 22:19:40.540992	https://basho-giddyup.s3.amazonaws.com/1068.log	riak-1.2.1-83-gd8de021-master
1069	t	\N	355	4	2012-12-05 22:21:40.173567	2012-12-05 22:21:40.173567	https://basho-giddyup.s3.amazonaws.com/1069.log	riak-1.2.1-83-gd8de021-master
1070	t	\N	251	4	2012-12-05 22:21:54.601775	2012-12-05 22:21:54.601775	https://basho-giddyup.s3.amazonaws.com/1070.log	riak-1.2.1-86-g818abe2-master
1071	t	\N	369	4	2012-12-05 22:22:22.455327	2012-12-05 22:22:22.455327	https://basho-giddyup.s3.amazonaws.com/1071.log	riak-1.2.1-83-gd8de021-master
1072	f	\N	263	4	2012-12-05 22:27:21.537339	2012-12-05 22:27:21.537339	https://basho-giddyup.s3.amazonaws.com/1072.log	riak-1.2.1-86-g818abe2-master
1073	t	\N	381	4	2012-12-05 22:28:05.615352	2012-12-05 22:28:05.615352	https://basho-giddyup.s3.amazonaws.com/1073.log	riak-1.2.1-83-gd8de021-master
1074	f	\N	393	4	2012-12-05 22:28:52.587181	2012-12-05 22:28:52.587181	https://basho-giddyup.s3.amazonaws.com/1074.log	riak-1.2.1-83-gd8de021-master
1075	t	\N	275	4	2012-12-05 22:37:11.510129	2012-12-05 22:37:11.510129	https://basho-giddyup.s3.amazonaws.com/1075.log	riak-1.2.1-86-g818abe2-master
1076	f	\N	287	4	2012-12-05 22:38:33.81856	2012-12-05 22:38:33.81856	https://basho-giddyup.s3.amazonaws.com/1076.log	riak-1.2.1-86-g818abe2-master
1077	f	\N	308	4	2012-12-05 22:45:54.498592	2012-12-05 22:45:54.498592	https://basho-giddyup.s3.amazonaws.com/1077.log	riak-1.2.1-86-g818abe2-master
1078	f	\N	342	4	2012-12-05 22:53:33.585858	2012-12-05 22:53:33.585858	https://basho-giddyup.s3.amazonaws.com/1078.log	riak-1.2.1-86-g818abe2-master
1079	f	\N	309	4	2012-12-05 22:57:42.294854	2012-12-05 22:57:42.294854	https://basho-giddyup.s3.amazonaws.com/1079.log	riak-1.2.1-86-g818abe2-master
1080	f	\N	343	4	2012-12-05 23:02:43.105605	2012-12-05 23:02:43.105605	https://basho-giddyup.s3.amazonaws.com/1080.log	riak-1.2.1-86-g818abe2-master
1081	f	\N	89	4	2012-12-05 23:04:35.988003	2012-12-05 23:04:35.988003	https://basho-giddyup.s3.amazonaws.com/1081.log	riak-1.2.1-86-g818abe2-master
1082	f	\N	357	4	2012-12-05 23:05:20.121052	2012-12-05 23:05:20.121052	https://basho-giddyup.s3.amazonaws.com/1082.log	riak-1.2.1-86-g818abe2-master
1083	t	\N	371	4	2012-12-05 23:08:13.525151	2012-12-05 23:08:13.525151	https://basho-giddyup.s3.amazonaws.com/1083.log	riak-1.2.1-86-g818abe2-master
1084	t	\N	383	4	2012-12-05 23:14:37.628457	2012-12-05 23:14:37.628457	https://basho-giddyup.s3.amazonaws.com/1084.log	riak-1.2.1-86-g818abe2-master
1085	f	\N	395	4	2012-12-05 23:17:13.431251	2012-12-05 23:17:13.431251	https://basho-giddyup.s3.amazonaws.com/1085.log	riak-1.2.1-86-g818abe2-master
1086	t	\N	192	4	2012-12-06 17:29:47.879712	2012-12-06 17:29:47.879712	https://basho-giddyup.s3.amazonaws.com/1086.log	riak-1.2.1-88-g92afa63-master
1087	t	\N	193	4	2012-12-06 17:30:26.515054	2012-12-06 17:30:26.515054	https://basho-giddyup.s3.amazonaws.com/1087.log	riak-1.2.1-88-g92afa63-master
1088	t	\N	194	4	2012-12-06 17:31:08.475578	2012-12-06 17:31:08.475578	https://basho-giddyup.s3.amazonaws.com/1088.log	riak-1.2.1-88-g92afa63-master
1089	t	\N	195	4	2012-12-06 17:31:47.725136	2012-12-06 17:31:47.725136	https://basho-giddyup.s3.amazonaws.com/1089.log	riak-1.2.1-88-g92afa63-master
1090	t	\N	196	4	2012-12-06 17:32:13.323834	2012-12-06 17:32:13.323834	https://basho-giddyup.s3.amazonaws.com/1090.log	riak-1.2.1-88-g92afa63-master
1091	t	\N	197	4	2012-12-06 17:33:08.642228	2012-12-06 17:33:08.642228	https://basho-giddyup.s3.amazonaws.com/1091.log	riak-1.2.1-88-g92afa63-master
1092	t	\N	198	4	2012-12-06 17:33:21.218519	2012-12-06 17:33:21.218519	https://basho-giddyup.s3.amazonaws.com/1092.log	riak-1.2.1-88-g92afa63-master
1093	t	\N	201	4	2012-12-06 17:38:32.52776	2012-12-06 17:38:32.52776	https://basho-giddyup.s3.amazonaws.com/1093.log	riak-1.2.1-88-g92afa63-master
1094	t	\N	202	4	2012-12-06 17:40:00.377242	2012-12-06 17:40:00.377242	https://basho-giddyup.s3.amazonaws.com/1094.log	riak-1.2.1-88-g92afa63-master
1095	t	\N	203	4	2012-12-06 17:40:31.930113	2012-12-06 17:40:31.930113	https://basho-giddyup.s3.amazonaws.com/1095.log	riak-1.2.1-88-g92afa63-master
1096	t	\N	204	4	2012-12-06 17:40:56.246974	2012-12-06 17:40:56.246974	https://basho-giddyup.s3.amazonaws.com/1096.log	riak-1.2.1-88-g92afa63-master
1097	t	\N	205	4	2012-12-06 17:43:28.580826	2012-12-06 17:43:28.580826	https://basho-giddyup.s3.amazonaws.com/1097.log	riak-1.2.1-88-g92afa63-master
1098	t	\N	206	4	2012-12-06 17:43:40.486078	2012-12-06 17:43:40.486078	https://basho-giddyup.s3.amazonaws.com/1098.log	riak-1.2.1-88-g92afa63-master
1099	t	\N	207	4	2012-12-06 17:44:42.948141	2012-12-06 17:44:42.948141	https://basho-giddyup.s3.amazonaws.com/1099.log	riak-1.2.1-88-g92afa63-master
1100	t	\N	208	4	2012-12-06 17:47:40.962922	2012-12-06 17:47:40.962922	https://basho-giddyup.s3.amazonaws.com/1100.log	riak-1.2.1-88-g92afa63-master
1101	t	\N	209	4	2012-12-06 17:48:04.731523	2012-12-06 17:48:04.731523	https://basho-giddyup.s3.amazonaws.com/1101.log	riak-1.2.1-88-g92afa63-master
1102	t	\N	210	4	2012-12-06 17:48:29.130191	2012-12-06 17:48:29.130191	https://basho-giddyup.s3.amazonaws.com/1102.log	riak-1.2.1-88-g92afa63-master
1103	t	\N	241	4	2012-12-06 17:49:05.391434	2012-12-06 17:49:05.391434	https://basho-giddyup.s3.amazonaws.com/1103.log	riak-1.2.1-88-g92afa63-master
1104	f	\N	253	4	2012-12-06 17:49:20.459655	2012-12-06 17:49:20.459655	https://basho-giddyup.s3.amazonaws.com/1104.log	riak-1.2.1-88-g92afa63-master
1105	f	\N	265	4	2012-12-06 17:53:03.828336	2012-12-06 17:53:03.828336	https://basho-giddyup.s3.amazonaws.com/1105.log	riak-1.2.1-88-g92afa63-master
1106	t	\N	277	4	2012-12-06 17:54:49.06241	2012-12-06 17:54:49.06241	https://basho-giddyup.s3.amazonaws.com/1106.log	riak-1.2.1-88-g92afa63-master
1107	t	\N	200	4	2012-12-06 17:56:22.800929	2012-12-06 17:56:22.800929	https://basho-giddyup.s3.amazonaws.com/1107.log	riak-1.2.1-88-g92afa63-master
1108	t	\N	289	4	2012-12-06 17:58:19.513393	2012-12-06 17:58:19.513393	https://basho-giddyup.s3.amazonaws.com/1108.log	riak-1.2.1-88-g92afa63-master
1109	t	\N	312	4	2012-12-06 18:33:01.165454	2012-12-06 18:33:01.165454	https://basho-giddyup.s3.amazonaws.com/1109.log	riak-1.2.1-88-g92afa63-master
1110	t	\N	346	4	2012-12-06 19:08:08.836365	2012-12-06 19:08:08.836365	https://basho-giddyup.s3.amazonaws.com/1110.log	riak-1.2.1-88-g92afa63-master
1111	t	\N	313	4	2012-12-06 19:51:36.523604	2012-12-06 19:51:36.523604	https://basho-giddyup.s3.amazonaws.com/1111.log	riak-1.2.1-88-g92afa63-master
1112	f	\N	347	4	2012-12-06 20:35:24.926169	2012-12-06 20:35:24.926169	https://basho-giddyup.s3.amazonaws.com/1112.log	riak-1.2.1-88-g92afa63-master
1113	t	\N	359	4	2012-12-06 20:37:02.69332	2012-12-06 20:37:02.69332	https://basho-giddyup.s3.amazonaws.com/1113.log	riak-1.2.1-88-g92afa63-master
1114	t	\N	373	4	2012-12-06 20:37:19.342954	2012-12-06 20:37:19.342954	https://basho-giddyup.s3.amazonaws.com/1114.log	riak-1.2.1-88-g92afa63-master
1115	t	\N	385	4	2012-12-06 20:37:31.341844	2012-12-06 20:37:31.341844	https://basho-giddyup.s3.amazonaws.com/1115.log	riak-1.2.1-88-g92afa63-master
1116	f	\N	397	4	2012-12-06 20:37:38.452288	2012-12-06 20:37:38.452288	https://basho-giddyup.s3.amazonaws.com/1116.log	riak-1.2.1-88-g92afa63-master
1117	t	\N	285	4	2012-12-07 18:07:40.643854	2012-12-07 18:07:40.643854	https://basho-giddyup.s3.amazonaws.com/1117.log	riak-1.2.1-83-gd8de021-master
1118	t	\N	249	4	2012-12-07 18:11:40.592439	2012-12-07 18:11:40.592439	https://basho-giddyup.s3.amazonaws.com/1118.log	riak-1.2.1-83-gd8de021-master
1119	f	\N	393	4	2012-12-07 18:12:49.577653	2012-12-07 18:12:49.577653	https://basho-giddyup.s3.amazonaws.com/1119.log	riak-1.2.1-83-gd8de021-master
1120	f	\N	261	4	2012-12-07 18:31:44.818748	2012-12-07 18:31:44.818748	https://basho-giddyup.s3.amazonaws.com/1120.log	riak-1.2.1-83-gd8de021-master
1121	f	\N	107	4	2012-12-07 20:25:09.756619	2012-12-07 20:25:09.756619	https://basho-giddyup.s3.amazonaws.com/1121.log	riak-1.2.1-88-g92afa63-master
1122	f	\N	107	4	2012-12-07 20:26:32.529573	2012-12-07 20:26:32.529573	https://basho-giddyup.s3.amazonaws.com/1122.log	riak-1.2.1-88-g92afa63-master
1123	t	\N	107	4	2012-12-07 21:39:12.597373	2012-12-07 21:39:12.597373	https://basho-giddyup.s3.amazonaws.com/1123.log	riak-1.2.1-88-g92afa63-master
1124	f	\N	107	4	2012-12-07 22:57:18.006771	2012-12-07 22:57:18.006771	https://basho-giddyup.s3.amazonaws.com/1124.log	riak-1.2.1-88-g92afa63-master
1125	f	\N	107	4	2012-12-07 23:05:00.031624	2012-12-07 23:05:00.031624	https://basho-giddyup.s3.amazonaws.com/1125.log	riak-1.2.1-88-g92afa63-master
1126	f	\N	107	4	2012-12-07 23:16:16.567639	2012-12-07 23:16:16.567639	https://basho-giddyup.s3.amazonaws.com/1126.log	riak-1.2.1-88-g92afa63-master
1127	t	\N	9	4	2012-12-08 21:23:33.013091	2012-12-08 21:23:33.013091	https://basho-giddyup.s3.amazonaws.com/1127.log	riak-1.2.1-86-g818abe2-master
1128	t	\N	19	4	2012-12-08 21:25:34.40977	2012-12-08 21:25:34.40977	https://basho-giddyup.s3.amazonaws.com/1128.log	riak-1.2.1-86-g818abe2-master
1129	t	\N	29	4	2012-12-08 21:36:50.004874	2012-12-08 21:36:50.004874	https://basho-giddyup.s3.amazonaws.com/1129.log	riak-1.2.1-86-g818abe2-master
1130	t	\N	39	4	2012-12-08 21:43:06.950728	2012-12-08 21:43:06.950728	https://basho-giddyup.s3.amazonaws.com/1130.log	riak-1.2.1-86-g818abe2-master
1131	f	\N	49	4	2012-12-08 21:49:12.497194	2012-12-08 21:49:12.497194	https://basho-giddyup.s3.amazonaws.com/1131.log	riak-1.2.1-86-g818abe2-master
1132	f	\N	59	4	2012-12-08 21:51:17.918358	2012-12-08 21:51:17.918358	https://basho-giddyup.s3.amazonaws.com/1132.log	riak-1.2.1-86-g818abe2-master
1133	t	\N	69	4	2012-12-08 21:53:37.882762	2012-12-08 21:53:37.882762	https://basho-giddyup.s3.amazonaws.com/1133.log	riak-1.2.1-86-g818abe2-master
1134	f	\N	99	4	2012-12-08 21:57:38.588298	2012-12-08 21:57:38.588298	https://basho-giddyup.s3.amazonaws.com/1134.log	riak-1.2.1-86-g818abe2-master
1135	f	\N	109	4	2012-12-08 22:03:05.221534	2012-12-08 22:03:05.221534	https://basho-giddyup.s3.amazonaws.com/1135.log	riak-1.2.1-86-g818abe2-master
1136	f	\N	119	4	2012-12-08 22:09:55.06349	2012-12-08 22:09:55.06349	https://basho-giddyup.s3.amazonaws.com/1136.log	riak-1.2.1-86-g818abe2-master
1137	t	\N	129	4	2012-12-08 22:16:20.673699	2012-12-08 22:16:20.673699	https://basho-giddyup.s3.amazonaws.com/1137.log	riak-1.2.1-86-g818abe2-master
1138	t	\N	139	4	2012-12-08 22:24:02.827634	2012-12-08 22:24:02.827634	https://basho-giddyup.s3.amazonaws.com/1138.log	riak-1.2.1-86-g818abe2-master
1139	t	\N	149	4	2012-12-08 22:30:32.388895	2012-12-08 22:30:32.388895	https://basho-giddyup.s3.amazonaws.com/1139.log	riak-1.2.1-86-g818abe2-master
1140	t	\N	159	4	2012-12-08 22:32:40.253204	2012-12-08 22:32:40.253204	https://basho-giddyup.s3.amazonaws.com/1140.log	riak-1.2.1-86-g818abe2-master
1141	f	\N	169	4	2012-12-08 22:37:12.263747	2012-12-08 22:37:12.263747	https://basho-giddyup.s3.amazonaws.com/1141.log	riak-1.2.1-86-g818abe2-master
1142	t	\N	187	4	2012-12-08 22:46:48.204962	2012-12-08 22:46:48.204962	https://basho-giddyup.s3.amazonaws.com/1142.log	riak-1.2.1-86-g818abe2-master
1143	f	\N	188	4	2012-12-08 22:51:17.421208	2012-12-08 22:51:17.421208	https://basho-giddyup.s3.amazonaws.com/1143.log	riak-1.2.1-86-g818abe2-master
1144	t	\N	239	4	2012-12-08 22:53:45.168974	2012-12-08 22:53:45.168974	https://basho-giddyup.s3.amazonaws.com/1144.log	riak-1.2.1-86-g818abe2-master
1145	t	\N	251	4	2012-12-08 22:57:35.941887	2012-12-08 22:57:35.941887	https://basho-giddyup.s3.amazonaws.com/1145.log	riak-1.2.1-86-g818abe2-master
1146	f	\N	263	4	2012-12-08 23:02:56.851838	2012-12-08 23:02:56.851838	https://basho-giddyup.s3.amazonaws.com/1146.log	riak-1.2.1-86-g818abe2-master
1147	f	\N	275	4	2012-12-08 23:20:39.112341	2012-12-08 23:20:39.112341	https://basho-giddyup.s3.amazonaws.com/1147.log	riak-1.2.1-86-g818abe2-master
1148	f	\N	287	4	2012-12-08 23:23:48.235252	2012-12-08 23:23:48.235252	https://basho-giddyup.s3.amazonaws.com/1148.log	riak-1.2.1-86-g818abe2-master
1149	f	\N	308	4	2012-12-08 23:32:00.220318	2012-12-08 23:32:00.220318	https://basho-giddyup.s3.amazonaws.com/1149.log	riak-1.2.1-86-g818abe2-master
1150	f	\N	309	4	2012-12-08 23:36:42.330745	2012-12-08 23:36:42.330745	https://basho-giddyup.s3.amazonaws.com/1150.log	riak-1.2.1-86-g818abe2-master
1151	f	\N	89	4	2012-12-08 23:38:12.676272	2012-12-08 23:38:12.676272	https://basho-giddyup.s3.amazonaws.com/1151.log	riak-1.2.1-86-g818abe2-master
1152	t	\N	371	4	2012-12-08 23:41:06.098874	2012-12-08 23:41:06.098874	https://basho-giddyup.s3.amazonaws.com/1152.log	riak-1.2.1-86-g818abe2-master
1153	t	\N	383	4	2012-12-08 23:42:35.450126	2012-12-08 23:42:35.450126	https://basho-giddyup.s3.amazonaws.com/1153.log	riak-1.2.1-86-g818abe2-master
1154	f	\N	395	4	2012-12-08 23:45:07.068654	2012-12-08 23:45:07.068654	https://basho-giddyup.s3.amazonaws.com/1154.log	riak-1.2.1-86-g818abe2-master
1155	f	\N	393	4	2012-12-11 13:44:00.428938	2012-12-11 13:44:00.428938	https://basho-giddyup.s3.amazonaws.com/1155.log	riak-1.2.1-88-g92afa63-master
1156	t	\N	393	4	2012-12-11 13:46:50.828488	2012-12-11 13:46:50.828488	https://basho-giddyup.s3.amazonaws.com/1156.log	riak-1.2.1-88-g92afa63-master
1157	t	\N	107	4	2012-12-11 15:01:38.87959	2012-12-11 15:01:38.87959	https://basho-giddyup.s3.amazonaws.com/1157.log	riak-1.2.1-88-g92afa63-master
1158	t	\N	117	4	2012-12-11 15:12:11.088681	2012-12-11 15:12:11.088681	https://basho-giddyup.s3.amazonaws.com/1158.log	riak-1.2.1-88-g92afa63-master
1159	f	\N	261	4	2012-12-11 15:16:13.348614	2012-12-11 15:16:13.348614	https://basho-giddyup.s3.amazonaws.com/1159.log	riak-1.2.1-88-g92afa63-master
1160	f	\N	261	4	2012-12-11 15:26:51.492729	2012-12-11 15:26:51.492729	https://basho-giddyup.s3.amazonaws.com/1160.log	riak-1.2.1-88-g92afa63-master
1161	f	\N	261	4	2012-12-11 15:34:14.302122	2012-12-11 15:34:14.302122	https://basho-giddyup.s3.amazonaws.com/1161.log	riak-1.2.1-88-g92afa63-master
1162	t	\N	261	4	2012-12-11 16:03:11.955914	2012-12-11 16:03:11.955914	https://basho-giddyup.s3.amazonaws.com/1162.log	riak-1.2.1-88-g92afa63-master
1163	t	\N	7	4	2012-12-12 15:21:09.718038	2012-12-12 15:21:09.718038	https://basho-giddyup.s3.amazonaws.com/1163.log	riak-1.2.1-88-g92afa63-master
1164	t	\N	17	4	2012-12-12 15:22:10.897029	2012-12-12 15:22:10.897029	https://basho-giddyup.s3.amazonaws.com/1164.log	riak-1.2.1-88-g92afa63-master
1165	t	\N	27	4	2012-12-12 15:29:10.466041	2012-12-12 15:29:10.466041	https://basho-giddyup.s3.amazonaws.com/1165.log	riak-1.2.1-88-g92afa63-master
1166	t	\N	37	4	2012-12-12 15:30:33.56825	2012-12-12 15:30:33.56825	https://basho-giddyup.s3.amazonaws.com/1166.log	riak-1.2.1-88-g92afa63-master
1167	t	\N	47	4	2012-12-12 15:31:23.878224	2012-12-12 15:31:23.878224	https://basho-giddyup.s3.amazonaws.com/1167.log	riak-1.2.1-88-g92afa63-master
1168	t	\N	57	4	2012-12-12 15:32:14.895738	2012-12-12 15:32:14.895738	https://basho-giddyup.s3.amazonaws.com/1168.log	riak-1.2.1-88-g92afa63-master
1169	t	\N	67	4	2012-12-12 15:37:56.457091	2012-12-12 15:37:56.457091	https://basho-giddyup.s3.amazonaws.com/1169.log	riak-1.2.1-88-g92afa63-master
1170	t	\N	87	4	2012-12-12 15:44:54.85124	2012-12-12 15:44:54.85124	https://basho-giddyup.s3.amazonaws.com/1170.log	riak-1.2.1-88-g92afa63-master
1171	f	\N	9	4	2012-12-12 16:17:19.602103	2012-12-12 16:17:19.602103	https://basho-giddyup.s3.amazonaws.com/1171.log	riak-1.2.1-88-g92afa63-master
1172	t	\N	19	4	2012-12-12 16:23:43.754385	2012-12-12 16:23:43.754385	https://basho-giddyup.s3.amazonaws.com/1172.log	riak-1.2.1-88-g92afa63-master
1173	t	\N	29	4	2012-12-12 16:34:48.197354	2012-12-12 16:34:48.197354	https://basho-giddyup.s3.amazonaws.com/1173.log	riak-1.2.1-88-g92afa63-master
1174	t	\N	39	4	2012-12-12 16:40:27.013303	2012-12-12 16:40:27.013303	https://basho-giddyup.s3.amazonaws.com/1174.log	riak-1.2.1-88-g92afa63-master
1175	t	\N	49	4	2012-12-12 16:43:14.514819	2012-12-12 16:43:14.514819	https://basho-giddyup.s3.amazonaws.com/1175.log	riak-1.2.1-88-g92afa63-master
1176	f	\N	59	4	2012-12-12 16:43:24.158911	2012-12-12 16:43:24.158911	https://basho-giddyup.s3.amazonaws.com/1176.log	riak-1.2.1-88-g92afa63-master
1177	t	\N	69	4	2012-12-12 16:45:36.525282	2012-12-12 16:45:36.525282	https://basho-giddyup.s3.amazonaws.com/1177.log	riak-1.2.1-88-g92afa63-master
1178	t	\N	99	4	2012-12-12 17:03:24.554983	2012-12-12 17:03:24.554983	https://basho-giddyup.s3.amazonaws.com/1178.log	riak-1.2.1-88-g92afa63-master
1179	f	\N	109	4	2012-12-12 17:03:40.400871	2012-12-12 17:03:40.400871	https://basho-giddyup.s3.amazonaws.com/1179.log	riak-1.2.1-88-g92afa63-master
1180	t	\N	119	4	2012-12-12 17:13:02.265335	2012-12-12 17:13:02.265335	https://basho-giddyup.s3.amazonaws.com/1180.log	riak-1.2.1-88-g92afa63-master
1181	t	\N	129	4	2012-12-12 17:17:55.286221	2012-12-12 17:17:55.286221	https://basho-giddyup.s3.amazonaws.com/1181.log	riak-1.2.1-88-g92afa63-master
1182	t	\N	139	4	2012-12-12 17:25:45.859756	2012-12-12 17:25:45.859756	https://basho-giddyup.s3.amazonaws.com/1182.log	riak-1.2.1-88-g92afa63-master
1183	t	\N	149	4	2012-12-12 17:32:15.255914	2012-12-12 17:32:15.255914	https://basho-giddyup.s3.amazonaws.com/1183.log	riak-1.2.1-88-g92afa63-master
1184	t	\N	159	4	2012-12-12 17:34:19.271257	2012-12-12 17:34:19.271257	https://basho-giddyup.s3.amazonaws.com/1184.log	riak-1.2.1-88-g92afa63-master
1185	t	\N	169	4	2012-12-12 17:42:37.592232	2012-12-12 17:42:37.592232	https://basho-giddyup.s3.amazonaws.com/1185.log	riak-1.2.1-88-g92afa63-master
1186	t	\N	187	4	2012-12-12 17:51:34.350451	2012-12-12 17:51:34.350451	https://basho-giddyup.s3.amazonaws.com/1186.log	riak-1.2.1-88-g92afa63-master
1187	t	\N	188	4	2012-12-12 17:59:32.675028	2012-12-12 17:59:32.675028	https://basho-giddyup.s3.amazonaws.com/1187.log	riak-1.2.1-88-g92afa63-master
1188	t	\N	239	4	2012-12-12 18:01:44.776954	2012-12-12 18:01:44.776954	https://basho-giddyup.s3.amazonaws.com/1188.log	riak-1.2.1-88-g92afa63-master
1189	t	\N	251	4	2012-12-12 18:05:31.986338	2012-12-12 18:05:31.986338	https://basho-giddyup.s3.amazonaws.com/1189.log	riak-1.2.1-88-g92afa63-master
1190	f	\N	263	4	2012-12-12 18:13:03.570026	2012-12-12 18:13:03.570026	https://basho-giddyup.s3.amazonaws.com/1190.log	riak-1.2.1-88-g92afa63-master
1191	t	\N	275	4	2012-12-12 18:23:17.920876	2012-12-12 18:23:17.920876	https://basho-giddyup.s3.amazonaws.com/1191.log	riak-1.2.1-88-g92afa63-master
1192	f	\N	287	4	2012-12-12 18:24:28.362413	2012-12-12 18:24:28.362413	https://basho-giddyup.s3.amazonaws.com/1192.log	riak-1.2.1-88-g92afa63-master
1193	f	\N	308	4	2012-12-12 18:32:40.249744	2012-12-12 18:32:40.249744	https://basho-giddyup.s3.amazonaws.com/1193.log	riak-1.2.1-88-g92afa63-master
1194	f	\N	309	4	2012-12-12 18:43:55.092535	2012-12-12 18:43:55.092535	https://basho-giddyup.s3.amazonaws.com/1194.log	riak-1.2.1-88-g92afa63-master
1195	f	\N	89	4	2012-12-12 18:44:52.473058	2012-12-12 18:44:52.473058	https://basho-giddyup.s3.amazonaws.com/1195.log	riak-1.2.1-88-g92afa63-master
1196	t	\N	371	4	2012-12-12 18:47:30.638736	2012-12-12 18:47:30.638736	https://basho-giddyup.s3.amazonaws.com/1196.log	riak-1.2.1-88-g92afa63-master
1197	t	\N	383	4	2012-12-12 18:53:54.605416	2012-12-12 18:53:54.605416	https://basho-giddyup.s3.amazonaws.com/1197.log	riak-1.2.1-88-g92afa63-master
1199	f	\N	407	4	2012-12-12 19:12:00.165703	2012-12-12 19:12:00.165703	https://basho-giddyup.s3.amazonaws.com/1199.log	riak-1.2.1-88-g92afa63-master
1200	t	\N	395	4	2012-12-13 16:54:17.617463	2012-12-13 16:54:17.617463	https://basho-giddyup.s3.amazonaws.com/1200.log	riak-1.2.1-88-g92afa63-master
1201	t	\N	9	4	2012-12-13 17:21:02.108362	2012-12-13 17:21:02.108362	https://basho-giddyup.s3.amazonaws.com/1201.log	riak-1.2.1-88-g92afa63-master
1202	f	\N	287	4	2012-12-13 17:35:55.967156	2012-12-13 17:35:55.967156	https://basho-giddyup.s3.amazonaws.com/1202.log	riak-1.2.1-88-g92afa63-master
1203	f	\N	287	4	2012-12-13 17:47:24.309811	2012-12-13 17:47:24.309811	https://basho-giddyup.s3.amazonaws.com/1203.log	riak-1.2.1-88-g92afa63-master
1204	f	\N	287	4	2012-12-13 18:04:41.115537	2012-12-13 18:04:41.115537	https://basho-giddyup.s3.amazonaws.com/1204.log	riak-1.2.1-88-g92afa63-master
1205	f	\N	287	4	2012-12-13 18:11:35.134762	2012-12-13 18:11:35.134762	https://basho-giddyup.s3.amazonaws.com/1205.log	riak-1.2.1-88-g92afa63-master
1206	f	\N	287	4	2012-12-13 20:16:15.773238	2012-12-13 20:16:15.773238	https://basho-giddyup.s3.amazonaws.com/1206.log	riak-1.2.1-88-g92afa63-master
1207	f	\N	287	4	2012-12-13 20:24:43.601818	2012-12-13 20:24:43.601818	https://basho-giddyup.s3.amazonaws.com/1207.log	riak-1.2.1-88-g92afa63-master
1208	t	\N	287	4	2012-12-13 20:52:43.047334	2012-12-13 20:52:43.047334	https://basho-giddyup.s3.amazonaws.com/1208.log	riak-1.2.1-88-g92afa63-master
1209	t	\N	9	4	2012-12-13 21:23:22.032445	2012-12-13 21:23:22.032445	https://basho-giddyup.s3.amazonaws.com/1209.log	riak-1.2.1-88-g92afa63-master
1210	t	\N	19	4	2012-12-13 21:25:19.378927	2012-12-13 21:25:19.378927	https://basho-giddyup.s3.amazonaws.com/1210.log	riak-1.2.1-88-g92afa63-master
1211	t	\N	29	4	2012-12-13 21:36:58.72121	2012-12-13 21:36:58.72121	https://basho-giddyup.s3.amazonaws.com/1211.log	riak-1.2.1-88-g92afa63-master
1212	t	\N	39	4	2012-12-13 21:43:08.577911	2012-12-13 21:43:08.577911	https://basho-giddyup.s3.amazonaws.com/1212.log	riak-1.2.1-88-g92afa63-master
1213	t	\N	49	4	2012-12-13 21:46:02.289464	2012-12-13 21:46:02.289464	https://basho-giddyup.s3.amazonaws.com/1213.log	riak-1.2.1-88-g92afa63-master
1214	f	\N	59	4	2012-12-13 21:46:09.467501	2012-12-13 21:46:09.467501	https://basho-giddyup.s3.amazonaws.com/1214.log	riak-1.2.1-88-g92afa63-master
1215	t	\N	69	4	2012-12-13 21:48:32.135513	2012-12-13 21:48:32.135513	https://basho-giddyup.s3.amazonaws.com/1215.log	riak-1.2.1-88-g92afa63-master
1216	t	\N	99	4	2012-12-13 22:06:21.877776	2012-12-13 22:06:21.877776	https://basho-giddyup.s3.amazonaws.com/1216.log	riak-1.2.1-88-g92afa63-master
1217	f	\N	109	4	2012-12-13 22:06:34.297394	2012-12-13 22:06:34.297394	https://basho-giddyup.s3.amazonaws.com/1217.log	riak-1.2.1-88-g92afa63-master
1218	t	\N	119	4	2012-12-13 22:11:00.851266	2012-12-13 22:11:00.851266	https://basho-giddyup.s3.amazonaws.com/1218.log	riak-1.2.1-88-g92afa63-master
1219	t	\N	129	4	2012-12-13 22:20:17.57375	2012-12-13 22:20:17.57375	https://basho-giddyup.s3.amazonaws.com/1219.log	riak-1.2.1-88-g92afa63-master
1220	t	\N	139	4	2012-12-13 22:26:45.674276	2012-12-13 22:26:45.674276	https://basho-giddyup.s3.amazonaws.com/1220.log	riak-1.2.1-88-g92afa63-master
1221	t	\N	149	4	2012-12-13 22:33:09.43847	2012-12-13 22:33:09.43847	https://basho-giddyup.s3.amazonaws.com/1221.log	riak-1.2.1-88-g92afa63-master
1222	t	\N	159	4	2012-12-13 22:35:13.939298	2012-12-13 22:35:13.939298	https://basho-giddyup.s3.amazonaws.com/1222.log	riak-1.2.1-88-g92afa63-master
1223	t	\N	169	4	2012-12-13 22:44:11.652272	2012-12-13 22:44:11.652272	https://basho-giddyup.s3.amazonaws.com/1223.log	riak-1.2.1-88-g92afa63-master
1224	t	\N	187	4	2012-12-13 22:53:05.914956	2012-12-13 22:53:05.914956	https://basho-giddyup.s3.amazonaws.com/1224.log	riak-1.2.1-88-g92afa63-master
1225	t	\N	188	4	2012-12-13 23:00:42.460401	2012-12-13 23:00:42.460401	https://basho-giddyup.s3.amazonaws.com/1225.log	riak-1.2.1-88-g92afa63-master
1226	t	\N	239	4	2012-12-13 23:07:46.785025	2012-12-13 23:07:46.785025	https://basho-giddyup.s3.amazonaws.com/1226.log	riak-1.2.1-88-g92afa63-master
1227	t	\N	251	4	2012-12-13 23:11:26.357867	2012-12-13 23:11:26.357867	https://basho-giddyup.s3.amazonaws.com/1227.log	riak-1.2.1-88-g92afa63-master
1228	f	\N	263	4	2012-12-13 23:18:26.495338	2012-12-13 23:18:26.495338	https://basho-giddyup.s3.amazonaws.com/1228.log	riak-1.2.1-88-g92afa63-master
1229	t	\N	275	4	2012-12-13 23:27:20.378897	2012-12-13 23:27:20.378897	https://basho-giddyup.s3.amazonaws.com/1229.log	riak-1.2.1-88-g92afa63-master
1230	f	\N	287	4	2012-12-13 23:32:08.436841	2012-12-13 23:32:08.436841	https://basho-giddyup.s3.amazonaws.com/1230.log	riak-1.2.1-88-g92afa63-master
1231	f	\N	308	4	2012-12-13 23:39:59.177836	2012-12-13 23:39:59.177836	https://basho-giddyup.s3.amazonaws.com/1231.log	riak-1.2.1-88-g92afa63-master
1232	f	\N	309	4	2012-12-13 23:50:53.12841	2012-12-13 23:50:53.12841	https://basho-giddyup.s3.amazonaws.com/1232.log	riak-1.2.1-88-g92afa63-master
1233	f	\N	89	4	2012-12-13 23:51:57.523453	2012-12-13 23:51:57.523453	https://basho-giddyup.s3.amazonaws.com/1233.log	riak-1.2.1-88-g92afa63-master
1234	t	\N	371	4	2012-12-13 23:54:38.481273	2012-12-13 23:54:38.481273	https://basho-giddyup.s3.amazonaws.com/1234.log	riak-1.2.1-88-g92afa63-master
1235	t	\N	383	4	2012-12-14 00:01:58.6099	2012-12-14 00:01:58.6099	https://basho-giddyup.s3.amazonaws.com/1235.log	riak-1.2.1-88-g92afa63-master
1236	t	\N	395	4	2012-12-14 00:05:39.607268	2012-12-14 00:05:39.607268	https://basho-giddyup.s3.amazonaws.com/1236.log	riak-1.2.1-88-g92afa63-master
1237	f	\N	407	4	2012-12-14 00:14:20.77841	2012-12-14 00:14:20.77841	https://basho-giddyup.s3.amazonaws.com/1237.log	riak-1.2.1-88-g92afa63-master
1238	t	\N	287	4	2012-12-14 15:19:42.431923	2012-12-14 15:19:42.431923	https://basho-giddyup.s3.amazonaws.com/1238.log	riak-1.2.1-88-g92afa63-master
1239	f	\N	287	4	2012-12-14 15:36:42.086827	2012-12-14 15:36:42.086827	https://basho-giddyup.s3.amazonaws.com/1239.log	riak-1.2.1-88-g92afa63-master
1240	t	\N	7	4	2012-12-17 18:26:36.505315	2012-12-17 18:26:36.505315	https://basho-giddyup.s3.amazonaws.com/1240.log	riak-1.2.1-90-gd4414a7-master
1241	t	\N	17	4	2012-12-17 18:27:36.50474	2012-12-17 18:27:36.50474	https://basho-giddyup.s3.amazonaws.com/1241.log	riak-1.2.1-90-gd4414a7-master
1242	t	\N	27	4	2012-12-17 18:29:28.327371	2012-12-17 18:29:28.327371	https://basho-giddyup.s3.amazonaws.com/1242.log	riak-1.2.1-90-gd4414a7-master
1243	t	\N	37	4	2012-12-17 18:30:51.419078	2012-12-17 18:30:51.419078	https://basho-giddyup.s3.amazonaws.com/1243.log	riak-1.2.1-90-gd4414a7-master
1244	t	\N	47	4	2012-12-17 18:31:39.399881	2012-12-17 18:31:39.399881	https://basho-giddyup.s3.amazonaws.com/1244.log	riak-1.2.1-90-gd4414a7-master
1245	t	\N	57	4	2012-12-17 18:32:30.409767	2012-12-17 18:32:30.409767	https://basho-giddyup.s3.amazonaws.com/1245.log	riak-1.2.1-90-gd4414a7-master
1246	t	\N	67	4	2012-12-17 18:33:02.636402	2012-12-17 18:33:02.636402	https://basho-giddyup.s3.amazonaws.com/1246.log	riak-1.2.1-90-gd4414a7-master
1247	t	\N	9	4	2012-12-17 18:34:24.016346	2012-12-17 18:34:24.016346	https://basho-giddyup.s3.amazonaws.com/1247.log	riak-1.2.1-90-gd4414a7-master
1248	t	\N	87	4	2012-12-17 18:34:54.335893	2012-12-17 18:34:54.335893	https://basho-giddyup.s3.amazonaws.com/1248.log	riak-1.2.1-90-gd4414a7-master
1249	t	\N	19	4	2012-12-17 18:36:21.522242	2012-12-17 18:36:21.522242	https://basho-giddyup.s3.amazonaws.com/1249.log	riak-1.2.1-90-gd4414a7-master
1250	t	\N	97	4	2012-12-17 18:41:39.376704	2012-12-17 18:41:39.376704	https://basho-giddyup.s3.amazonaws.com/1250.log	riak-1.2.1-90-gd4414a7-master
1251	f	\N	107	4	2012-12-17 18:42:21.572743	2012-12-17 18:42:21.572743	https://basho-giddyup.s3.amazonaws.com/1251.log	riak-1.2.1-90-gd4414a7-master
1252	t	\N	29	4	2012-12-17 18:42:22.600568	2012-12-17 18:42:22.600568	https://basho-giddyup.s3.amazonaws.com/1252.log	riak-1.2.1-90-gd4414a7-master
1253	t	\N	39	4	2012-12-17 18:48:07.661618	2012-12-17 18:48:07.661618	https://basho-giddyup.s3.amazonaws.com/1253.log	riak-1.2.1-90-gd4414a7-master
1254	f	\N	117	4	2012-12-17 18:48:15.987328	2012-12-17 18:48:15.987328	https://basho-giddyup.s3.amazonaws.com/1254.log	riak-1.2.1-90-gd4414a7-master
1255	t	\N	127	4	2012-12-17 18:49:38.634133	2012-12-17 18:49:38.634133	https://basho-giddyup.s3.amazonaws.com/1255.log	riak-1.2.1-90-gd4414a7-master
1256	t	\N	137	4	2012-12-17 18:51:51.441456	2012-12-17 18:51:51.441456	https://basho-giddyup.s3.amazonaws.com/1256.log	riak-1.2.1-90-gd4414a7-master
1257	t	\N	147	4	2012-12-17 18:52:23.354541	2012-12-17 18:52:23.354541	https://basho-giddyup.s3.amazonaws.com/1257.log	riak-1.2.1-90-gd4414a7-master
1258	t	\N	157	4	2012-12-17 18:53:43.898271	2012-12-17 18:53:43.898271	https://basho-giddyup.s3.amazonaws.com/1258.log	riak-1.2.1-90-gd4414a7-master
1259	t	\N	49	4	2012-12-17 18:56:04.226028	2012-12-17 18:56:04.226028	https://basho-giddyup.s3.amazonaws.com/1259.log	riak-1.2.1-90-gd4414a7-master
1260	f	\N	59	4	2012-12-17 18:56:12.064937	2012-12-17 18:56:12.064937	https://basho-giddyup.s3.amazonaws.com/1260.log	riak-1.2.1-90-gd4414a7-master
1261	t	\N	167	4	2012-12-17 18:56:19.532815	2012-12-17 18:56:19.532815	https://basho-giddyup.s3.amazonaws.com/1261.log	riak-1.2.1-90-gd4414a7-master
1262	t	\N	183	4	2012-12-17 18:57:07.414219	2012-12-17 18:57:07.414219	https://basho-giddyup.s3.amazonaws.com/1262.log	riak-1.2.1-90-gd4414a7-master
1263	f	\N	184	4	2012-12-17 18:58:11.21712	2012-12-17 18:58:11.21712	https://basho-giddyup.s3.amazonaws.com/1263.log	riak-1.2.1-90-gd4414a7-master
1264	t	\N	69	4	2012-12-17 18:58:23.919706	2012-12-17 18:58:23.919706	https://basho-giddyup.s3.amazonaws.com/1264.log	riak-1.2.1-90-gd4414a7-master
1265	t	\N	237	4	2012-12-17 18:59:04.882963	2012-12-17 18:59:04.882963	https://basho-giddyup.s3.amazonaws.com/1265.log	riak-1.2.1-90-gd4414a7-master
1266	t	\N	249	4	2012-12-17 19:01:34.526911	2012-12-17 19:01:34.526911	https://basho-giddyup.s3.amazonaws.com/1266.log	riak-1.2.1-90-gd4414a7-master
1267	t	\N	261	4	2012-12-17 19:07:16.186947	2012-12-17 19:07:16.186947	https://basho-giddyup.s3.amazonaws.com/1267.log	riak-1.2.1-90-gd4414a7-master
1268	t	\N	273	4	2012-12-17 19:10:17.586229	2012-12-17 19:10:17.586229	https://basho-giddyup.s3.amazonaws.com/1268.log	riak-1.2.1-90-gd4414a7-master
1269	t	\N	285	4	2012-12-17 19:13:47.854984	2012-12-17 19:13:47.854984	https://basho-giddyup.s3.amazonaws.com/1269.log	riak-1.2.1-90-gd4414a7-master
1270	t	\N	99	4	2012-12-17 19:15:29.009925	2012-12-17 19:15:29.009925	https://basho-giddyup.s3.amazonaws.com/1270.log	riak-1.2.1-90-gd4414a7-master
1271	f	\N	109	4	2012-12-17 19:15:42.585388	2012-12-17 19:15:42.585388	https://basho-giddyup.s3.amazonaws.com/1271.log	riak-1.2.1-90-gd4414a7-master
1272	f	\N	119	4	2012-12-17 19:24:56.533378	2012-12-17 19:24:56.533378	https://basho-giddyup.s3.amazonaws.com/1272.log	riak-1.2.1-90-gd4414a7-master
1273	t	\N	129	4	2012-12-17 19:29:29.684478	2012-12-17 19:29:29.684478	https://basho-giddyup.s3.amazonaws.com/1273.log	riak-1.2.1-90-gd4414a7-master
1274	t	\N	139	4	2012-12-17 19:35:50.560578	2012-12-17 19:35:50.560578	https://basho-giddyup.s3.amazonaws.com/1274.log	riak-1.2.1-90-gd4414a7-master
1275	t	\N	149	4	2012-12-17 19:37:14.482895	2012-12-17 19:37:14.482895	https://basho-giddyup.s3.amazonaws.com/1275.log	riak-1.2.1-90-gd4414a7-master
1276	t	\N	159	4	2012-12-17 19:39:17.997648	2012-12-17 19:39:17.997648	https://basho-giddyup.s3.amazonaws.com/1276.log	riak-1.2.1-90-gd4414a7-master
1277	t	\N	304	4	2012-12-17 19:46:37.264831	2012-12-17 19:46:37.264831	https://basho-giddyup.s3.amazonaws.com/1277.log	riak-1.2.1-90-gd4414a7-master
1278	t	\N	338	4	2012-12-17 20:21:51.203856	2012-12-17 20:21:51.203856	https://basho-giddyup.s3.amazonaws.com/1278.log	riak-1.2.1-90-gd4414a7-master
1279	t	\N	305	4	2012-12-17 21:00:21.747012	2012-12-17 21:00:21.747012	https://basho-giddyup.s3.amazonaws.com/1279.log	riak-1.2.1-90-gd4414a7-master
1280	t	\N	339	4	2012-12-17 21:38:39.208507	2012-12-17 21:38:39.208507	https://basho-giddyup.s3.amazonaws.com/1280.log	riak-1.2.1-90-gd4414a7-master
1281	t	\N	355	4	2012-12-17 21:45:42.172581	2012-12-17 21:45:42.172581	https://basho-giddyup.s3.amazonaws.com/1281.log	riak-1.2.1-90-gd4414a7-master
1282	t	\N	369	4	2012-12-17 21:46:24.696242	2012-12-17 21:46:24.696242	https://basho-giddyup.s3.amazonaws.com/1282.log	riak-1.2.1-90-gd4414a7-master
1283	t	\N	381	4	2012-12-17 21:46:57.039257	2012-12-17 21:46:57.039257	https://basho-giddyup.s3.amazonaws.com/1283.log	riak-1.2.1-90-gd4414a7-master
1284	t	\N	393	4	2012-12-17 21:48:03.354588	2012-12-17 21:48:03.354588	https://basho-giddyup.s3.amazonaws.com/1284.log	riak-1.2.1-90-gd4414a7-master
1285	f	\N	405	4	2012-12-17 21:50:55.985092	2012-12-17 21:50:55.985092	https://basho-giddyup.s3.amazonaws.com/1285.log	riak-1.2.1-90-gd4414a7-master
1286	t	\N	4	4	2012-12-19 16:28:23.775297	2012-12-19 16:28:23.775297	https://basho-giddyup.s3.amazonaws.com/1286.log	riak-1.2.1-94-gc7e849b-master
1287	t	\N	14	4	2012-12-19 16:29:17.055779	2012-12-19 16:29:17.055779	https://basho-giddyup.s3.amazonaws.com/1287.log	riak-1.2.1-94-gc7e849b-master
1288	t	\N	24	4	2012-12-19 16:31:07.534657	2012-12-19 16:31:07.534657	https://basho-giddyup.s3.amazonaws.com/1288.log	riak-1.2.1-94-gc7e849b-master
1289	t	\N	34	4	2012-12-19 16:32:40.410217	2012-12-19 16:32:40.410217	https://basho-giddyup.s3.amazonaws.com/1289.log	riak-1.2.1-94-gc7e849b-master
1290	t	\N	44	4	2012-12-19 16:33:27.015981	2012-12-19 16:33:27.015981	https://basho-giddyup.s3.amazonaws.com/1290.log	riak-1.2.1-94-gc7e849b-master
1291	t	\N	54	4	2012-12-19 16:34:11.298292	2012-12-19 16:34:11.298292	https://basho-giddyup.s3.amazonaws.com/1291.log	riak-1.2.1-94-gc7e849b-master
1292	t	\N	64	4	2012-12-19 16:34:44.95426	2012-12-19 16:34:44.95426	https://basho-giddyup.s3.amazonaws.com/1292.log	riak-1.2.1-94-gc7e849b-master
1293	t	\N	94	4	2012-12-19 16:42:45.333399	2012-12-19 16:42:45.333399	https://basho-giddyup.s3.amazonaws.com/1293.log	riak-1.2.1-94-gc7e849b-master
1294	t	\N	84	4	2012-12-19 16:50:22.009798	2012-12-19 16:50:22.009798	https://basho-giddyup.s3.amazonaws.com/1294.log	riak-1.2.1-94-gc7e849b-master
1295	f	\N	104	4	2012-12-19 16:50:57.55028	2012-12-19 16:50:57.55028	https://basho-giddyup.s3.amazonaws.com/1295.log	riak-1.2.1-94-gc7e849b-master
1296	f	\N	114	4	2012-12-19 16:57:23.689432	2012-12-19 16:57:23.689432	https://basho-giddyup.s3.amazonaws.com/1296.log	riak-1.2.1-94-gc7e849b-master
1297	t	\N	124	4	2012-12-19 16:58:30.898876	2012-12-19 16:58:30.898876	https://basho-giddyup.s3.amazonaws.com/1297.log	riak-1.2.1-94-gc7e849b-master
1298	t	\N	134	4	2012-12-19 17:00:53.474409	2012-12-19 17:00:53.474409	https://basho-giddyup.s3.amazonaws.com/1298.log	riak-1.2.1-94-gc7e849b-master
1299	t	\N	144	4	2012-12-19 17:01:21.325539	2012-12-19 17:01:21.325539	https://basho-giddyup.s3.amazonaws.com/1299.log	riak-1.2.1-94-gc7e849b-master
1300	t	\N	154	4	2012-12-19 17:02:38.922881	2012-12-19 17:02:38.922881	https://basho-giddyup.s3.amazonaws.com/1300.log	riak-1.2.1-94-gc7e849b-master
1301	t	\N	164	4	2012-12-19 17:05:27.603329	2012-12-19 17:05:27.603329	https://basho-giddyup.s3.amazonaws.com/1301.log	riak-1.2.1-94-gc7e849b-master
1302	t	\N	177	4	2012-12-19 17:11:56.810351	2012-12-19 17:11:56.810351	https://basho-giddyup.s3.amazonaws.com/1302.log	riak-1.2.1-94-gc7e849b-master
1303	t	\N	178	4	2012-12-19 17:13:12.339405	2012-12-19 17:13:12.339405	https://basho-giddyup.s3.amazonaws.com/1303.log	riak-1.2.1-94-gc7e849b-master
1304	t	\N	233	4	2012-12-19 17:14:03.661872	2012-12-19 17:14:03.661872	https://basho-giddyup.s3.amazonaws.com/1304.log	riak-1.2.1-94-gc7e849b-master
1305	t	\N	245	4	2012-12-19 17:16:36.383162	2012-12-19 17:16:36.383162	https://basho-giddyup.s3.amazonaws.com/1305.log	riak-1.2.1-94-gc7e849b-master
1306	t	\N	257	4	2012-12-19 17:22:19.19808	2012-12-19 17:22:19.19808	https://basho-giddyup.s3.amazonaws.com/1306.log	riak-1.2.1-94-gc7e849b-master
1307	t	\N	269	4	2012-12-19 17:24:49.903894	2012-12-19 17:24:49.903894	https://basho-giddyup.s3.amazonaws.com/1307.log	riak-1.2.1-94-gc7e849b-master
1308	t	\N	281	4	2012-12-19 17:28:47.135858	2012-12-19 17:28:47.135858	https://basho-giddyup.s3.amazonaws.com/1308.log	riak-1.2.1-94-gc7e849b-master
1309	t	\N	296	4	2012-12-19 18:02:45.111521	2012-12-19 18:02:45.111521	https://basho-giddyup.s3.amazonaws.com/1309.log	riak-1.2.1-94-gc7e849b-master
1310	f	\N	211	4	2012-12-19 18:07:08.655502	2012-12-19 18:07:08.655502	https://basho-giddyup.s3.amazonaws.com/1310.log	riak-1.2.1-94-g1015619-master
1311	t	\N	212	4	2012-12-19 18:07:45.062263	2012-12-19 18:07:45.062263	https://basho-giddyup.s3.amazonaws.com/1311.log	riak-1.2.1-94-g1015619-master
1312	t	\N	213	4	2012-12-19 18:08:36.209186	2012-12-19 18:08:36.209186	https://basho-giddyup.s3.amazonaws.com/1312.log	riak-1.2.1-94-g1015619-master
1313	t	\N	214	4	2012-12-19 18:09:33.638351	2012-12-19 18:09:33.638351	https://basho-giddyup.s3.amazonaws.com/1313.log	riak-1.2.1-94-g1015619-master
1314	t	\N	215	4	2012-12-19 18:09:54.851991	2012-12-19 18:09:54.851991	https://basho-giddyup.s3.amazonaws.com/1314.log	riak-1.2.1-94-g1015619-master
1315	t	\N	216	4	2012-12-19 18:10:43.012482	2012-12-19 18:10:43.012482	https://basho-giddyup.s3.amazonaws.com/1315.log	riak-1.2.1-94-g1015619-master
1316	t	\N	217	4	2012-12-19 18:10:52.741783	2012-12-19 18:10:52.741783	https://basho-giddyup.s3.amazonaws.com/1316.log	riak-1.2.1-94-g1015619-master
1317	f	\N	220	4	2012-12-19 18:11:54.1781	2012-12-19 18:11:54.1781	https://basho-giddyup.s3.amazonaws.com/1317.log	riak-1.2.1-94-g1015619-master
1318	f	\N	221	4	2012-12-19 18:12:07.492111	2012-12-19 18:12:07.492111	https://basho-giddyup.s3.amazonaws.com/1318.log	riak-1.2.1-94-g1015619-master
1319	t	\N	222	4	2012-12-19 18:12:42.468469	2012-12-19 18:12:42.468469	https://basho-giddyup.s3.amazonaws.com/1319.log	riak-1.2.1-94-g1015619-master
1320	t	\N	223	4	2012-12-19 18:13:22.378635	2012-12-19 18:13:22.378635	https://basho-giddyup.s3.amazonaws.com/1320.log	riak-1.2.1-94-g1015619-master
1322	t	\N	225	4	2012-12-19 18:15:55.800272	2012-12-19 18:15:55.800272	https://basho-giddyup.s3.amazonaws.com/1322.log	riak-1.2.1-94-g1015619-master
1323	f	\N	226	4	2012-12-19 18:16:25.416954	2012-12-19 18:16:25.416954	https://basho-giddyup.s3.amazonaws.com/1323.log	riak-1.2.1-94-g1015619-master
1324	t	\N	227	4	2012-12-19 18:19:18.188554	2012-12-19 18:19:18.188554	https://basho-giddyup.s3.amazonaws.com/1324.log	riak-1.2.1-94-g1015619-master
1325	f	\N	228	4	2012-12-19 18:19:53.31224	2012-12-19 18:19:53.31224	https://basho-giddyup.s3.amazonaws.com/1325.log	riak-1.2.1-94-g1015619-master
1326	f	\N	229	4	2012-12-19 18:20:23.906807	2012-12-19 18:20:23.906807	https://basho-giddyup.s3.amazonaws.com/1326.log	riak-1.2.1-94-g1015619-master
1327	f	\N	235	4	2012-12-19 18:20:51.172096	2012-12-19 18:20:51.172096	https://basho-giddyup.s3.amazonaws.com/1327.log	riak-1.2.1-94-g1015619-master
1328	t	\N	247	4	2012-12-19 18:22:31.927772	2012-12-19 18:22:31.927772	https://basho-giddyup.s3.amazonaws.com/1328.log	riak-1.2.1-94-g1015619-master
1329	f	\N	259	4	2012-12-19 18:22:56.37633	2012-12-19 18:22:56.37633	https://basho-giddyup.s3.amazonaws.com/1329.log	riak-1.2.1-94-g1015619-master
1330	f	\N	271	4	2012-12-19 18:23:10.491144	2012-12-19 18:23:10.491144	https://basho-giddyup.s3.amazonaws.com/1330.log	riak-1.2.1-94-g1015619-master
1331	f	\N	219	4	2012-12-19 18:23:40.368539	2012-12-19 18:23:40.368539	https://basho-giddyup.s3.amazonaws.com/1331.log	riak-1.2.1-94-g1015619-master
1332	f	\N	283	4	2012-12-19 18:26:28.409831	2012-12-19 18:26:28.409831	https://basho-giddyup.s3.amazonaws.com/1332.log	riak-1.2.1-94-g1015619-master
1333	f	\N	2	4	2012-12-19 18:27:27.993157	2012-12-19 18:27:27.993157	https://basho-giddyup.s3.amazonaws.com/1333.log	riak-1.2.1-94-g1015619-master
1334	t	\N	12	4	2012-12-19 18:33:19.524021	2012-12-19 18:33:19.524021	https://basho-giddyup.s3.amazonaws.com/1334.log	riak-1.2.1-94-g1015619-master
1335	t	\N	22	4	2012-12-19 18:35:12.458072	2012-12-19 18:35:12.458072	https://basho-giddyup.s3.amazonaws.com/1335.log	riak-1.2.1-94-g1015619-master
1336	t	\N	332	4	2012-12-19 18:36:26.135308	2012-12-19 18:36:26.135308	https://basho-giddyup.s3.amazonaws.com/1336.log	riak-1.2.1-94-gc7e849b-master
1337	t	\N	32	4	2012-12-19 18:36:32.458798	2012-12-19 18:36:32.458798	https://basho-giddyup.s3.amazonaws.com/1337.log	riak-1.2.1-94-g1015619-master
1338	t	\N	42	4	2012-12-19 18:37:18.727221	2012-12-19 18:37:18.727221	https://basho-giddyup.s3.amazonaws.com/1338.log	riak-1.2.1-94-g1015619-master
1339	t	\N	52	4	2012-12-19 18:38:05.077734	2012-12-19 18:38:05.077734	https://basho-giddyup.s3.amazonaws.com/1339.log	riak-1.2.1-94-g1015619-master
1340	t	\N	62	4	2012-12-19 18:38:36.110672	2012-12-19 18:38:36.110672	https://basho-giddyup.s3.amazonaws.com/1340.log	riak-1.2.1-94-g1015619-master
1341	t	\N	92	4	2012-12-19 18:45:44.356547	2012-12-19 18:45:44.356547	https://basho-giddyup.s3.amazonaws.com/1341.log	riak-1.2.1-94-g1015619-master
1342	t	\N	82	4	2012-12-19 18:47:34.337585	2012-12-19 18:47:34.337585	https://basho-giddyup.s3.amazonaws.com/1342.log	riak-1.2.1-94-g1015619-master
1343	f	\N	102	4	2012-12-19 18:48:11.503072	2012-12-19 18:48:11.503072	https://basho-giddyup.s3.amazonaws.com/1343.log	riak-1.2.1-94-g1015619-master
1344	t	\N	112	4	2012-12-19 18:54:30.097268	2012-12-19 18:54:30.097268	https://basho-giddyup.s3.amazonaws.com/1344.log	riak-1.2.1-94-g1015619-master
1345	t	\N	122	4	2012-12-19 18:56:10.678836	2012-12-19 18:56:10.678836	https://basho-giddyup.s3.amazonaws.com/1345.log	riak-1.2.1-94-g1015619-master
1346	t	\N	132	4	2012-12-19 18:58:21.512465	2012-12-19 18:58:21.512465	https://basho-giddyup.s3.amazonaws.com/1346.log	riak-1.2.1-94-g1015619-master
1347	t	\N	142	4	2012-12-19 18:58:49.373694	2012-12-19 18:58:49.373694	https://basho-giddyup.s3.amazonaws.com/1347.log	riak-1.2.1-94-g1015619-master
1348	t	\N	300	4	2012-12-19 18:59:24.548673	2012-12-19 18:59:24.548673	https://basho-giddyup.s3.amazonaws.com/1348.log	riak-1.2.1-94-g1015619-master
1349	t	\N	152	4	2012-12-19 19:00:08.446687	2012-12-19 19:00:08.446687	https://basho-giddyup.s3.amazonaws.com/1349.log	riak-1.2.1-94-g1015619-master
1350	f	\N	297	4	2012-12-19 19:05:29.503035	2012-12-19 19:05:29.503035	https://basho-giddyup.s3.amazonaws.com/1350.log	riak-1.2.1-94-gc7e849b-master
1351	t	\N	334	4	2012-12-19 19:32:43.691545	2012-12-19 19:32:43.691545	https://basho-giddyup.s3.amazonaws.com/1351.log	riak-1.2.1-94-g1015619-master
1352	t	\N	3	4	2012-12-19 19:38:08.516394	2012-12-19 19:38:08.516394	https://basho-giddyup.s3.amazonaws.com/1352.log	riak-1.2.1-94-g1015619-master
1353	t	\N	13	4	2012-12-19 19:39:25.827663	2012-12-19 19:39:25.827663	https://basho-giddyup.s3.amazonaws.com/1353.log	riak-1.2.1-94-g1015619-master
1354	t	\N	23	4	2012-12-19 19:41:46.436542	2012-12-19 19:41:46.436542	https://basho-giddyup.s3.amazonaws.com/1354.log	riak-1.2.1-94-g1015619-master
1355	t	\N	33	4	2012-12-19 19:43:10.655514	2012-12-19 19:43:10.655514	https://basho-giddyup.s3.amazonaws.com/1355.log	riak-1.2.1-94-g1015619-master
1356	t	\N	43	4	2012-12-19 19:44:10.52432	2012-12-19 19:44:10.52432	https://basho-giddyup.s3.amazonaws.com/1356.log	riak-1.2.1-94-g1015619-master
1357	t	\N	53	4	2012-12-19 19:45:10.403384	2012-12-19 19:45:10.403384	https://basho-giddyup.s3.amazonaws.com/1357.log	riak-1.2.1-94-g1015619-master
1358	t	\N	63	4	2012-12-19 19:46:03.275103	2012-12-19 19:46:03.275103	https://basho-giddyup.s3.amazonaws.com/1358.log	riak-1.2.1-94-g1015619-master
1359	t	\N	333	4	2012-12-19 19:46:55.202168	2012-12-19 19:46:55.202168	https://basho-giddyup.s3.amazonaws.com/1359.log	riak-1.2.1-94-gc7e849b-master
1360	t	\N	353	4	2012-12-19 19:48:51.843812	2012-12-19 19:48:51.843812	https://basho-giddyup.s3.amazonaws.com/1360.log	riak-1.2.1-94-gc7e849b-master
1361	t	\N	365	4	2012-12-19 19:49:32.379898	2012-12-19 19:49:32.379898	https://basho-giddyup.s3.amazonaws.com/1361.log	riak-1.2.1-94-gc7e849b-master
1362	t	\N	93	4	2012-12-19 19:53:21.833365	2012-12-19 19:53:21.833365	https://basho-giddyup.s3.amazonaws.com/1362.log	riak-1.2.1-94-g1015619-master
1363	t	\N	377	4	2012-12-19 19:55:34.113002	2012-12-19 19:55:34.113002	https://basho-giddyup.s3.amazonaws.com/1363.log	riak-1.2.1-94-gc7e849b-master
1364	t	\N	389	4	2012-12-19 19:56:23.741852	2012-12-19 19:56:23.741852	https://basho-giddyup.s3.amazonaws.com/1364.log	riak-1.2.1-94-gc7e849b-master
1365	f	\N	401	4	2012-12-19 20:00:19.806115	2012-12-19 20:00:19.806115	https://basho-giddyup.s3.amazonaws.com/1365.log	riak-1.2.1-94-gc7e849b-master
1366	t	\N	83	4	2012-12-19 20:01:00.447531	2012-12-19 20:01:00.447531	https://basho-giddyup.s3.amazonaws.com/1366.log	riak-1.2.1-94-g1015619-master
1367	f	\N	103	4	2012-12-19 20:01:43.044063	2012-12-19 20:01:43.044063	https://basho-giddyup.s3.amazonaws.com/1367.log	riak-1.2.1-94-g1015619-master
1368	t	\N	113	4	2012-12-19 20:02:45.098113	2012-12-19 20:02:45.098113	https://basho-giddyup.s3.amazonaws.com/1368.log	riak-1.2.1-94-g1015619-master
1369	t	\N	123	4	2012-12-19 20:04:08.251941	2012-12-19 20:04:08.251941	https://basho-giddyup.s3.amazonaws.com/1369.log	riak-1.2.1-94-g1015619-master
1370	t	\N	7	4	2012-12-19 20:04:50.136579	2012-12-19 20:04:50.136579	https://basho-giddyup.s3.amazonaws.com/1370.log	riak-1.2.1-94-g1015619-master
1371	t	\N	17	4	2012-12-19 20:06:08.126838	2012-12-19 20:06:08.126838	https://basho-giddyup.s3.amazonaws.com/1371.log	riak-1.2.1-94-g1015619-master
1372	t	\N	133	4	2012-12-19 20:06:29.364476	2012-12-19 20:06:29.364476	https://basho-giddyup.s3.amazonaws.com/1372.log	riak-1.2.1-94-g1015619-master
1373	t	\N	143	4	2012-12-19 20:12:49.94724	2012-12-19 20:12:49.94724	https://basho-giddyup.s3.amazonaws.com/1373.log	riak-1.2.1-94-g1015619-master
1374	t	\N	27	4	2012-12-19 20:13:26.668823	2012-12-19 20:13:26.668823	https://basho-giddyup.s3.amazonaws.com/1374.log	riak-1.2.1-94-g1015619-master
1375	t	\N	153	4	2012-12-19 20:14:13.475741	2012-12-19 20:14:13.475741	https://basho-giddyup.s3.amazonaws.com/1375.log	riak-1.2.1-94-g1015619-master
1376	t	\N	37	4	2012-12-19 20:14:46.219696	2012-12-19 20:14:46.219696	https://basho-giddyup.s3.amazonaws.com/1376.log	riak-1.2.1-94-g1015619-master
1377	t	\N	47	4	2012-12-19 20:15:43.581436	2012-12-19 20:15:43.581436	https://basho-giddyup.s3.amazonaws.com/1377.log	riak-1.2.1-94-g1015619-master
1378	t	\N	57	4	2012-12-19 20:16:32.722326	2012-12-19 20:16:32.722326	https://basho-giddyup.s3.amazonaws.com/1378.log	riak-1.2.1-94-g1015619-master
1379	t	\N	163	4	2012-12-19 20:16:57.525275	2012-12-19 20:16:57.525275	https://basho-giddyup.s3.amazonaws.com/1379.log	riak-1.2.1-94-g1015619-master
1380	t	\N	67	4	2012-12-19 20:17:26.351046	2012-12-19 20:17:26.351046	https://basho-giddyup.s3.amazonaws.com/1380.log	riak-1.2.1-94-g1015619-master
1381	t	\N	175	4	2012-12-19 20:17:41.148249	2012-12-19 20:17:41.148249	https://basho-giddyup.s3.amazonaws.com/1381.log	riak-1.2.1-94-g1015619-master
1382	t	\N	301	4	2012-12-19 20:18:03.393198	2012-12-19 20:18:03.393198	https://basho-giddyup.s3.amazonaws.com/1382.log	riak-1.2.1-94-g1015619-master
1383	t	\N	176	4	2012-12-19 20:18:49.579754	2012-12-19 20:18:49.579754	https://basho-giddyup.s3.amazonaws.com/1383.log	riak-1.2.1-94-g1015619-master
1384	t	\N	87	4	2012-12-19 20:19:19.232098	2012-12-19 20:19:19.232098	https://basho-giddyup.s3.amazonaws.com/1384.log	riak-1.2.1-94-g1015619-master
1385	t	\N	232	4	2012-12-19 20:19:56.571218	2012-12-19 20:19:56.571218	https://basho-giddyup.s3.amazonaws.com/1385.log	riak-1.2.1-94-g1015619-master
1386	t	\N	244	4	2012-12-19 20:22:29.193534	2012-12-19 20:22:29.193534	https://basho-giddyup.s3.amazonaws.com/1386.log	riak-1.2.1-94-g1015619-master
1387	t	\N	97	4	2012-12-19 20:26:36.677782	2012-12-19 20:26:36.677782	https://basho-giddyup.s3.amazonaws.com/1387.log	riak-1.2.1-94-g1015619-master
1388	f	\N	107	4	2012-12-19 20:27:19.719232	2012-12-19 20:27:19.719232	https://basho-giddyup.s3.amazonaws.com/1388.log	riak-1.2.1-94-g1015619-master
1389	t	\N	117	4	2012-12-19 20:28:18.237718	2012-12-19 20:28:18.237718	https://basho-giddyup.s3.amazonaws.com/1389.log	riak-1.2.1-94-g1015619-master
1390	t	\N	256	4	2012-12-19 20:28:27.669465	2012-12-19 20:28:27.669465	https://basho-giddyup.s3.amazonaws.com/1390.log	riak-1.2.1-94-g1015619-master
1391	t	\N	127	4	2012-12-19 20:34:50.560029	2012-12-19 20:34:50.560029	https://basho-giddyup.s3.amazonaws.com/1391.log	riak-1.2.1-94-g1015619-master
1393	t	\N	268	4	2012-12-19 20:37:41.722328	2012-12-19 20:37:41.722328	https://basho-giddyup.s3.amazonaws.com/1393.log	riak-1.2.1-94-g1015619-master
1394	t	\N	147	4	2012-12-19 20:37:45.710996	2012-12-19 20:37:45.710996	https://basho-giddyup.s3.amazonaws.com/1394.log	riak-1.2.1-94-g1015619-master
1395	f	\N	280	4	2012-12-19 20:37:49.373837	2012-12-19 20:37:49.373837	https://basho-giddyup.s3.amazonaws.com/1395.log	riak-1.2.1-94-g1015619-master
1396	t	\N	157	4	2012-12-19 20:39:13.75233	2012-12-19 20:39:13.75233	https://basho-giddyup.s3.amazonaws.com/1396.log	riak-1.2.1-94-g1015619-master
1397	t	\N	167	4	2012-12-19 20:42:42.240865	2012-12-19 20:42:42.240865	https://basho-giddyup.s3.amazonaws.com/1397.log	riak-1.2.1-94-g1015619-master
1398	t	\N	183	4	2012-12-19 20:43:26.832719	2012-12-19 20:43:26.832719	https://basho-giddyup.s3.amazonaws.com/1398.log	riak-1.2.1-94-g1015619-master
1399	t	\N	184	4	2012-12-19 20:44:23.961091	2012-12-19 20:44:23.961091	https://basho-giddyup.s3.amazonaws.com/1399.log	riak-1.2.1-94-g1015619-master
1400	t	\N	237	4	2012-12-19 20:45:22.408718	2012-12-19 20:45:22.408718	https://basho-giddyup.s3.amazonaws.com/1400.log	riak-1.2.1-94-g1015619-master
1401	t	\N	249	4	2012-12-19 20:47:47.518137	2012-12-19 20:47:47.518137	https://basho-giddyup.s3.amazonaws.com/1401.log	riak-1.2.1-94-g1015619-master
1402	f	\N	335	4	2012-12-19 20:49:18.7129	2012-12-19 20:49:18.7129	https://basho-giddyup.s3.amazonaws.com/1402.log	riak-1.2.1-94-g1015619-master
1403	t	\N	360	4	2012-12-19 20:51:56.313538	2012-12-19 20:51:56.313538	https://basho-giddyup.s3.amazonaws.com/1403.log	riak-1.2.1-94-g1015619-master
1404	t	\N	367	4	2012-12-19 20:52:28.16036	2012-12-19 20:52:28.16036	https://basho-giddyup.s3.amazonaws.com/1404.log	riak-1.2.1-94-g1015619-master
1405	t	\N	379	4	2012-12-19 20:52:52.759052	2012-12-19 20:52:52.759052	https://basho-giddyup.s3.amazonaws.com/1405.log	riak-1.2.1-94-g1015619-master
1406	t	\N	261	4	2012-12-19 20:53:26.654816	2012-12-19 20:53:26.654816	https://basho-giddyup.s3.amazonaws.com/1406.log	riak-1.2.1-94-g1015619-master
1407	t	\N	391	4	2012-12-19 20:53:47.839112	2012-12-19 20:53:47.839112	https://basho-giddyup.s3.amazonaws.com/1407.log	riak-1.2.1-94-g1015619-master
1408	t	\N	273	4	2012-12-19 20:57:14.407293	2012-12-19 20:57:14.407293	https://basho-giddyup.s3.amazonaws.com/1408.log	riak-1.2.1-94-g1015619-master
1409	t	\N	403	4	2012-12-19 20:58:35.595381	2012-12-19 20:58:35.595381	https://basho-giddyup.s3.amazonaws.com/1409.log	riak-1.2.1-94-g1015619-master
1410	t	\N	285	4	2012-12-19 21:00:39.908684	2012-12-19 21:00:39.908684	https://basho-giddyup.s3.amazonaws.com/1410.log	riak-1.2.1-94-g1015619-master
1411	f	\N	294	4	2012-12-19 21:02:16.591006	2012-12-19 21:02:16.591006	https://basho-giddyup.s3.amazonaws.com/1411.log	riak-1.2.1-94-g1015619-master
1412	t	\N	304	4	2012-12-19 21:35:57.836064	2012-12-19 21:35:57.836064	https://basho-giddyup.s3.amazonaws.com/1412.log	riak-1.2.1-94-g1015619-master
1413	t	\N	330	4	2012-12-19 21:41:16.144383	2012-12-19 21:41:16.144383	https://basho-giddyup.s3.amazonaws.com/1413.log	riak-1.2.1-94-g1015619-master
1414	f	\N	295	4	2012-12-19 21:59:51.021577	2012-12-19 21:59:51.021577	https://basho-giddyup.s3.amazonaws.com/1414.log	riak-1.2.1-94-g1015619-master
1415	t	\N	338	4	2012-12-19 22:11:26.706798	2012-12-19 22:11:26.706798	https://basho-giddyup.s3.amazonaws.com/1415.log	riak-1.2.1-94-g1015619-master
1416	t	\N	305	4	2012-12-19 22:47:10.488822	2012-12-19 22:47:10.488822	https://basho-giddyup.s3.amazonaws.com/1416.log	riak-1.2.1-94-g1015619-master
1417	t	\N	331	4	2012-12-19 22:48:06.72348	2012-12-19 22:48:06.72348	https://basho-giddyup.s3.amazonaws.com/1417.log	riak-1.2.1-94-g1015619-master
1418	t	\N	352	4	2012-12-19 22:50:00.588903	2012-12-19 22:50:00.588903	https://basho-giddyup.s3.amazonaws.com/1418.log	riak-1.2.1-94-g1015619-master
1419	t	\N	364	4	2012-12-19 22:50:41.545284	2012-12-19 22:50:41.545284	https://basho-giddyup.s3.amazonaws.com/1419.log	riak-1.2.1-94-g1015619-master
1420	t	\N	376	4	2012-12-19 22:51:14.227996	2012-12-19 22:51:14.227996	https://basho-giddyup.s3.amazonaws.com/1420.log	riak-1.2.1-94-g1015619-master
1421	t	\N	388	4	2012-12-19 22:52:09.015179	2012-12-19 22:52:09.015179	https://basho-giddyup.s3.amazonaws.com/1421.log	riak-1.2.1-94-g1015619-master
1422	t	\N	400	4	2012-12-19 22:59:33.417904	2012-12-19 22:59:33.417904	https://basho-giddyup.s3.amazonaws.com/1422.log	riak-1.2.1-94-g1015619-master
1423	t	\N	339	4	2012-12-19 23:25:46.138925	2012-12-19 23:25:46.138925	https://basho-giddyup.s3.amazonaws.com/1423.log	riak-1.2.1-94-g1015619-master
1424	t	\N	355	4	2012-12-19 23:33:17.278382	2012-12-19 23:33:17.278382	https://basho-giddyup.s3.amazonaws.com/1424.log	riak-1.2.1-94-g1015619-master
1425	t	\N	369	4	2012-12-19 23:33:57.454508	2012-12-19 23:33:57.454508	https://basho-giddyup.s3.amazonaws.com/1425.log	riak-1.2.1-94-g1015619-master
1426	t	\N	381	4	2012-12-19 23:40:04.309503	2012-12-19 23:40:04.309503	https://basho-giddyup.s3.amazonaws.com/1426.log	riak-1.2.1-94-g1015619-master
1427	t	\N	393	4	2012-12-19 23:41:16.90104	2012-12-19 23:41:16.90104	https://basho-giddyup.s3.amazonaws.com/1427.log	riak-1.2.1-94-g1015619-master
1428	t	\N	405	4	2012-12-19 23:46:52.53259	2012-12-19 23:46:52.53259	https://basho-giddyup.s3.amazonaws.com/1428.log	riak-1.2.1-94-g1015619-master
1429	t	\N	235	4	2012-12-20 16:46:45.285439	2012-12-20 16:46:45.285439	https://basho-giddyup.s3.amazonaws.com/1429.log	riak-1.2.1-94-g1015619-master
1430	f	\N	283	4	2012-12-20 16:52:35.967392	2012-12-20 16:52:35.967392	https://basho-giddyup.s3.amazonaws.com/1430.log	riak-1.2.1-94-g1015619-master
1431	f	\N	211	4	2012-12-20 17:09:46.81111	2012-12-20 17:09:46.81111	https://basho-giddyup.s3.amazonaws.com/1431.log	riak-1.2.1-94-g1015619-master
1432	t	\N	211	7	2012-12-20 18:43:33.468908	2012-12-20 18:43:33.468908	https://basho-giddyup.s3.amazonaws.com/1432.log	riak-1.3.0pre1-master
1433	t	\N	7	7	2012-12-20 18:43:34.339358	2012-12-20 18:43:34.339358	https://basho-giddyup.s3.amazonaws.com/1433.log	riak-1.3.0pre1-master
1434	t	\N	2	7	2012-12-20 18:44:00.229445	2012-12-20 18:44:00.229445	https://basho-giddyup.s3.amazonaws.com/1434.log	riak-1.3.0pre1-master
1435	t	\N	3	7	2012-12-20 18:44:18.447964	2012-12-20 18:44:18.447964	https://basho-giddyup.s3.amazonaws.com/1435.log	riak-1.3.0pre1-master
1436	f	\N	4	7	2012-12-20 18:44:28.926163	2012-12-20 18:44:28.926163	https://basho-giddyup.s3.amazonaws.com/1436.log	riak-1.3.0pre1-master
1437	t	\N	212	7	2012-12-20 18:44:48.684347	2012-12-20 18:44:48.684347	https://basho-giddyup.s3.amazonaws.com/1437.log	riak-1.3.0pre1-master
1438	t	\N	17	7	2012-12-20 18:44:57.250018	2012-12-20 18:44:57.250018	https://basho-giddyup.s3.amazonaws.com/1438.log	riak-1.3.0pre1-master
1439	t	\N	12	7	2012-12-20 18:45:23.433284	2012-12-20 18:45:23.433284	https://basho-giddyup.s3.amazonaws.com/1439.log	riak-1.3.0pre1-master
1440	t	\N	14	7	2012-12-20 18:45:40.911613	2012-12-20 18:45:40.911613	https://basho-giddyup.s3.amazonaws.com/1440.log	riak-1.3.0pre1-master
1441	t	\N	13	7	2012-12-20 18:45:44.554758	2012-12-20 18:45:44.554758	https://basho-giddyup.s3.amazonaws.com/1441.log	riak-1.3.0pre1-master
1442	t	\N	27	7	2012-12-20 18:46:54.119524	2012-12-20 18:46:54.119524	https://basho-giddyup.s3.amazonaws.com/1442.log	riak-1.3.0pre1-master
1443	t	\N	24	7	2012-12-20 18:47:46.475581	2012-12-20 18:47:46.475581	https://basho-giddyup.s3.amazonaws.com/1443.log	riak-1.3.0pre1-master
1444	t	\N	22	7	2012-12-20 18:47:53.667101	2012-12-20 18:47:53.667101	https://basho-giddyup.s3.amazonaws.com/1444.log	riak-1.3.0pre1-master
1445	t	\N	37	7	2012-12-20 18:48:11.898167	2012-12-20 18:48:11.898167	https://basho-giddyup.s3.amazonaws.com/1445.log	riak-1.3.0pre1-master
1446	t	\N	23	7	2012-12-20 18:48:12.867004	2012-12-20 18:48:12.867004	https://basho-giddyup.s3.amazonaws.com/1446.log	riak-1.3.0pre1-master
1447	t	\N	34	7	2012-12-20 18:49:06.87469	2012-12-20 18:49:06.87469	https://basho-giddyup.s3.amazonaws.com/1447.log	riak-1.3.0pre1-master
1448	f	\N	47	7	2012-12-20 18:49:08.16883	2012-12-20 18:49:08.16883	https://basho-giddyup.s3.amazonaws.com/1448.log	riak-1.3.0pre1-master
1449	t	\N	32	7	2012-12-20 18:49:30.450066	2012-12-20 18:49:30.450066	https://basho-giddyup.s3.amazonaws.com/1449.log	riak-1.3.0pre1-master
1450	t	\N	33	7	2012-12-20 18:49:47.790559	2012-12-20 18:49:47.790559	https://basho-giddyup.s3.amazonaws.com/1450.log	riak-1.3.0pre1-master
1451	f	\N	44	7	2012-12-20 18:50:04.489184	2012-12-20 18:50:04.489184	https://basho-giddyup.s3.amazonaws.com/1451.log	riak-1.3.0pre1-master
1452	t	\N	57	7	2012-12-20 18:50:16.2881	2012-12-20 18:50:16.2881	https://basho-giddyup.s3.amazonaws.com/1452.log	riak-1.3.0pre1-master
1453	f	\N	42	7	2012-12-20 18:50:32.074066	2012-12-20 18:50:32.074066	https://basho-giddyup.s3.amazonaws.com/1453.log	riak-1.3.0pre1-master
1454	t	\N	54	7	2012-12-20 18:50:50.217393	2012-12-20 18:50:50.217393	https://basho-giddyup.s3.amazonaws.com/1454.log	riak-1.3.0pre1-master
1455	f	\N	43	7	2012-12-20 18:50:51.711063	2012-12-20 18:50:51.711063	https://basho-giddyup.s3.amazonaws.com/1455.log	riak-1.3.0pre1-master
1456	t	\N	67	7	2012-12-20 18:51:10.505251	2012-12-20 18:51:10.505251	https://basho-giddyup.s3.amazonaws.com/1456.log	riak-1.3.0pre1-master
1457	t	\N	52	7	2012-12-20 18:51:21.93147	2012-12-20 18:51:21.93147	https://basho-giddyup.s3.amazonaws.com/1457.log	riak-1.3.0pre1-master
1458	t	\N	64	7	2012-12-20 18:51:42.001094	2012-12-20 18:51:42.001094	https://basho-giddyup.s3.amazonaws.com/1458.log	riak-1.3.0pre1-master
1459	t	\N	53	7	2012-12-20 18:51:42.883203	2012-12-20 18:51:42.883203	https://basho-giddyup.s3.amazonaws.com/1459.log	riak-1.3.0pre1-master
1460	t	\N	62	7	2012-12-20 18:52:19.39157	2012-12-20 18:52:19.39157	https://basho-giddyup.s3.amazonaws.com/1460.log	riak-1.3.0pre1-master
1461	t	\N	63	7	2012-12-20 18:52:40.462354	2012-12-20 18:52:40.462354	https://basho-giddyup.s3.amazonaws.com/1461.log	riak-1.3.0pre1-master
1462	t	\N	213	7	2012-12-20 18:53:09.712498	2012-12-20 18:53:09.712498	https://basho-giddyup.s3.amazonaws.com/1462.log	riak-1.3.0pre1-master
1463	t	\N	9	7	2012-12-20 18:54:17.296189	2012-12-20 18:54:17.296189	https://basho-giddyup.s3.amazonaws.com/1463.log	riak-1.3.0pre1-master
1464	t	\N	214	7	2012-12-20 18:54:32.742824	2012-12-20 18:54:32.742824	https://basho-giddyup.s3.amazonaws.com/1464.log	riak-1.3.0pre1-master
1465	f	\N	215	7	2012-12-20 18:55:31.492128	2012-12-20 18:55:31.492128	https://basho-giddyup.s3.amazonaws.com/1465.log	riak-1.3.0pre1-master
1466	t	\N	216	7	2012-12-20 18:56:23.044748	2012-12-20 18:56:23.044748	https://basho-giddyup.s3.amazonaws.com/1466.log	riak-1.3.0pre1-master
1467	t	\N	217	7	2012-12-20 18:57:06.681822	2012-12-20 18:57:06.681822	https://basho-giddyup.s3.amazonaws.com/1467.log	riak-1.3.0pre1-master
1468	t	\N	19	7	2012-12-20 18:57:07.649425	2012-12-20 18:57:07.649425	https://basho-giddyup.s3.amazonaws.com/1468.log	riak-1.3.0pre1-master
1469	t	\N	87	7	2012-12-20 18:58:32.765241	2012-12-20 18:58:32.765241	https://basho-giddyup.s3.amazonaws.com/1469.log	riak-1.3.0pre1-master
1470	f	\N	220	7	2012-12-20 18:58:44.993352	2012-12-20 18:58:44.993352	https://basho-giddyup.s3.amazonaws.com/1470.log	riak-1.3.0pre1-master
1471	f	\N	221	7	2012-12-20 18:59:18.048341	2012-12-20 18:59:18.048341	https://basho-giddyup.s3.amazonaws.com/1471.log	riak-1.3.0pre1-master
1472	t	\N	94	7	2012-12-20 18:59:21.311877	2012-12-20 18:59:21.311877	https://basho-giddyup.s3.amazonaws.com/1472.log	riak-1.3.0pre1-master
1473	t	\N	92	7	2012-12-20 18:59:41.105845	2012-12-20 18:59:41.105845	https://basho-giddyup.s3.amazonaws.com/1473.log	riak-1.3.0pre1-master
1474	t	\N	93	7	2012-12-20 19:00:09.633248	2012-12-20 19:00:09.633248	https://basho-giddyup.s3.amazonaws.com/1474.log	riak-1.3.0pre1-master
1475	t	\N	222	7	2012-12-20 19:00:22.518379	2012-12-20 19:00:22.518379	https://basho-giddyup.s3.amazonaws.com/1475.log	riak-1.3.0pre1-master
1476	t	\N	84	7	2012-12-20 19:01:11.226855	2012-12-20 19:01:11.226855	https://basho-giddyup.s3.amazonaws.com/1476.log	riak-1.3.0pre1-master
1477	f	\N	83	7	2012-12-20 19:01:13.036992	2012-12-20 19:01:13.036992	https://basho-giddyup.s3.amazonaws.com/1477.log	riak-1.3.0pre1-master
1478	t	\N	223	7	2012-12-20 19:01:18.808891	2012-12-20 19:01:18.808891	https://basho-giddyup.s3.amazonaws.com/1478.log	riak-1.3.0pre1-master
1479	t	\N	82	7	2012-12-20 19:01:40.892556	2012-12-20 19:01:40.892556	https://basho-giddyup.s3.amazonaws.com/1479.log	riak-1.3.0pre1-master
1480	f	\N	104	7	2012-12-20 19:01:48.014262	2012-12-20 19:01:48.014262	https://basho-giddyup.s3.amazonaws.com/1480.log	riak-1.3.0pre1-master
1481	t	\N	114	7	2012-12-20 19:02:48.824377	2012-12-20 19:02:48.824377	https://basho-giddyup.s3.amazonaws.com/1481.log	riak-1.3.0pre1-master
1482	t	\N	224	7	2012-12-20 19:03:29.652344	2012-12-20 19:03:29.652344	https://basho-giddyup.s3.amazonaws.com/1482.log	riak-1.3.0pre1-master
1483	t	\N	124	7	2012-12-20 19:03:54.341712	2012-12-20 19:03:54.341712	https://basho-giddyup.s3.amazonaws.com/1483.log	riak-1.3.0pre1-master
1484	t	\N	225	7	2012-12-20 19:04:06.115002	2012-12-20 19:04:06.115002	https://basho-giddyup.s3.amazonaws.com/1484.log	riak-1.3.0pre1-master
1485	t	\N	29	7	2012-12-20 19:04:25.976999	2012-12-20 19:04:25.976999	https://basho-giddyup.s3.amazonaws.com/1485.log	riak-1.3.0pre1-master
1486	f	\N	226	7	2012-12-20 19:04:46.799586	2012-12-20 19:04:46.799586	https://basho-giddyup.s3.amazonaws.com/1486.log	riak-1.3.0pre1-master
1487	t	\N	97	7	2012-12-20 19:05:36.21312	2012-12-20 19:05:36.21312	https://basho-giddyup.s3.amazonaws.com/1487.log	riak-1.3.0pre1-master
1488	f	\N	107	7	2012-12-20 19:06:18.416152	2012-12-20 19:06:18.416152	https://basho-giddyup.s3.amazonaws.com/1488.log	riak-1.3.0pre1-master
1489	t	\N	227	7	2012-12-20 19:07:16.672599	2012-12-20 19:07:16.672599	https://basho-giddyup.s3.amazonaws.com/1489.log	riak-1.3.0pre1-master
1490	t	\N	117	7	2012-12-20 19:07:31.176156	2012-12-20 19:07:31.176156	https://basho-giddyup.s3.amazonaws.com/1490.log	riak-1.3.0pre1-master
1491	f	\N	103	7	2012-12-20 19:07:49.876319	2012-12-20 19:07:49.876319	https://basho-giddyup.s3.amazonaws.com/1491.log	riak-1.3.0pre1-master
1492	f	\N	228	7	2012-12-20 19:08:11.935335	2012-12-20 19:08:11.935335	https://basho-giddyup.s3.amazonaws.com/1492.log	riak-1.3.0pre1-master
1493	t	\N	127	7	2012-12-20 19:08:40.318588	2012-12-20 19:08:40.318588	https://basho-giddyup.s3.amazonaws.com/1493.log	riak-1.3.0pre1-master
1494	f	\N	229	7	2012-12-20 19:08:58.538221	2012-12-20 19:08:58.538221	https://basho-giddyup.s3.amazonaws.com/1494.log	riak-1.3.0pre1-master
1495	t	\N	113	7	2012-12-20 19:09:02.092943	2012-12-20 19:09:02.092943	https://basho-giddyup.s3.amazonaws.com/1495.log	riak-1.3.0pre1-master
1496	f	\N	235	7	2012-12-20 19:09:41.099202	2012-12-20 19:09:41.099202	https://basho-giddyup.s3.amazonaws.com/1496.log	riak-1.3.0pre1-master
1497	t	\N	137	7	2012-12-20 19:10:32.987358	2012-12-20 19:10:32.987358	https://basho-giddyup.s3.amazonaws.com/1497.log	riak-1.3.0pre1-master
1498	t	\N	123	7	2012-12-20 19:10:45.323401	2012-12-20 19:10:45.323401	https://basho-giddyup.s3.amazonaws.com/1498.log	riak-1.3.0pre1-master
1499	t	\N	102	7	2012-12-20 19:11:02.101324	2012-12-20 19:11:02.101324	https://basho-giddyup.s3.amazonaws.com/1499.log	riak-1.3.0pre1-master
1500	t	\N	147	7	2012-12-20 19:11:16.764238	2012-12-20 19:11:16.764238	https://basho-giddyup.s3.amazonaws.com/1500.log	riak-1.3.0pre1-master
1501	t	\N	134	7	2012-12-20 19:11:22.760627	2012-12-20 19:11:22.760627	https://basho-giddyup.s3.amazonaws.com/1501.log	riak-1.3.0pre1-master
1502	t	\N	39	7	2012-12-20 19:11:23.701348	2012-12-20 19:11:23.701348	https://basho-giddyup.s3.amazonaws.com/1502.log	riak-1.3.0pre1-master
1503	f	\N	247	7	2012-12-20 19:11:34.992934	2012-12-20 19:11:34.992934	https://basho-giddyup.s3.amazonaws.com/1503.log	riak-1.3.0pre1-master
1504	t	\N	144	7	2012-12-20 19:12:01.001918	2012-12-20 19:12:01.001918	https://basho-giddyup.s3.amazonaws.com/1504.log	riak-1.3.0pre1-master
1505	f	\N	259	7	2012-12-20 19:12:03.752667	2012-12-20 19:12:03.752667	https://basho-giddyup.s3.amazonaws.com/1505.log	riak-1.3.0pre1-master
1506	f	\N	271	7	2012-12-20 19:12:24.290199	2012-12-20 19:12:24.290199	https://basho-giddyup.s3.amazonaws.com/1506.log	riak-1.3.0pre1-master
1507	t	\N	157	7	2012-12-20 19:12:40.047642	2012-12-20 19:12:40.047642	https://basho-giddyup.s3.amazonaws.com/1507.log	riak-1.3.0pre1-master
1508	t	\N	133	7	2012-12-20 19:12:57.36738	2012-12-20 19:12:57.36738	https://basho-giddyup.s3.amazonaws.com/1508.log	riak-1.3.0pre1-master
1509	t	\N	154	7	2012-12-20 19:13:19.666985	2012-12-20 19:13:19.666985	https://basho-giddyup.s3.amazonaws.com/1509.log	riak-1.3.0pre1-master
1510	t	\N	143	7	2012-12-20 19:13:44.387098	2012-12-20 19:13:44.387098	https://basho-giddyup.s3.amazonaws.com/1510.log	riak-1.3.0pre1-master
1511	t	\N	219	7	2012-12-20 19:14:10.265479	2012-12-20 19:14:10.265479	https://basho-giddyup.s3.amazonaws.com/1511.log	riak-1.3.0pre1-master
1512	f	\N	49	7	2012-12-20 19:14:54.834152	2012-12-20 19:14:54.834152	https://basho-giddyup.s3.amazonaws.com/1512.log	riak-1.3.0pre1-master
1513	f	\N	59	7	2012-12-20 19:15:02.5333	2012-12-20 19:15:02.5333	https://basho-giddyup.s3.amazonaws.com/1513.log	riak-1.3.0pre1-master
1514	t	\N	153	7	2012-12-20 19:15:11.598366	2012-12-20 19:15:11.598366	https://basho-giddyup.s3.amazonaws.com/1514.log	riak-1.3.0pre1-master
1515	t	\N	167	7	2012-12-20 19:15:28.288327	2012-12-20 19:15:28.288327	https://basho-giddyup.s3.amazonaws.com/1515.log	riak-1.3.0pre1-master
1516	t	\N	164	7	2012-12-20 19:16:14.298989	2012-12-20 19:16:14.298989	https://basho-giddyup.s3.amazonaws.com/1516.log	riak-1.3.0pre1-master
1517	t	\N	183	7	2012-12-20 19:16:15.218618	2012-12-20 19:16:15.218618	https://basho-giddyup.s3.amazonaws.com/1517.log	riak-1.3.0pre1-master
1518	t	\N	177	7	2012-12-20 19:17:03.925344	2012-12-20 19:17:03.925344	https://basho-giddyup.s3.amazonaws.com/1518.log	riak-1.3.0pre1-master
1519	t	\N	184	7	2012-12-20 19:17:21.435726	2012-12-20 19:17:21.435726	https://basho-giddyup.s3.amazonaws.com/1519.log	riak-1.3.0pre1-master
1520	f	\N	283	7	2012-12-20 19:17:28.227983	2012-12-20 19:17:28.227983	https://basho-giddyup.s3.amazonaws.com/1520.log	riak-1.3.0pre1-master
1521	f	\N	112	7	2012-12-20 19:17:36.142178	2012-12-20 19:17:36.142178	https://basho-giddyup.s3.amazonaws.com/1521.log	riak-1.3.0pre1-master
1522	t	\N	163	7	2012-12-20 19:18:10.860545	2012-12-20 19:18:10.860545	https://basho-giddyup.s3.amazonaws.com/1522.log	riak-1.3.0pre1-master
1523	t	\N	178	7	2012-12-20 19:18:14.59929	2012-12-20 19:18:14.59929	https://basho-giddyup.s3.amazonaws.com/1523.log	riak-1.3.0pre1-master
1524	f	\N	319	7	2012-12-20 19:18:21.226054	2012-12-20 19:18:21.226054	https://basho-giddyup.s3.amazonaws.com/1524.log	riak-1.3.0pre1-master
1525	t	\N	69	7	2012-12-20 19:18:29.148468	2012-12-20 19:18:29.148468	https://basho-giddyup.s3.amazonaws.com/1525.log	riak-1.3.0pre1-master
1526	t	\N	122	7	2012-12-20 19:18:54.353494	2012-12-20 19:18:54.353494	https://basho-giddyup.s3.amazonaws.com/1526.log	riak-1.3.0pre1-master
1527	t	\N	175	7	2012-12-20 19:19:01.782712	2012-12-20 19:19:01.782712	https://basho-giddyup.s3.amazonaws.com/1527.log	riak-1.3.0pre1-master
1528	t	\N	176	7	2012-12-20 19:20:35.30604	2012-12-20 19:20:35.30604	https://basho-giddyup.s3.amazonaws.com/1528.log	riak-1.3.0pre1-master
1529	t	\N	132	7	2012-12-20 19:21:26.912801	2012-12-20 19:21:26.912801	https://basho-giddyup.s3.amazonaws.com/1529.log	riak-1.3.0pre1-master
1530	t	\N	237	7	2012-12-20 19:23:37.707103	2012-12-20 19:23:37.707103	https://basho-giddyup.s3.amazonaws.com/1530.log	riak-1.3.0pre1-master
1531	t	\N	233	7	2012-12-20 19:24:47.966134	2012-12-20 19:24:47.966134	https://basho-giddyup.s3.amazonaws.com/1531.log	riak-1.3.0pre1-master
1532	f	\N	249	7	2012-12-20 19:25:59.206868	2012-12-20 19:25:59.206868	https://basho-giddyup.s3.amazonaws.com/1532.log	riak-1.3.0pre1-master
1533	t	\N	232	7	2012-12-20 19:26:54.091818	2012-12-20 19:26:54.091818	https://basho-giddyup.s3.amazonaws.com/1533.log	riak-1.3.0pre1-master
1534	f	\N	245	7	2012-12-20 19:27:11.541543	2012-12-20 19:27:11.541543	https://basho-giddyup.s3.amazonaws.com/1534.log	riak-1.3.0pre1-master
1535	t	\N	142	7	2012-12-20 19:28:05.515356	2012-12-20 19:28:05.515356	https://basho-giddyup.s3.amazonaws.com/1535.log	riak-1.3.0pre1-master
1536	t	\N	152	7	2012-12-20 19:29:36.127229	2012-12-20 19:29:36.127229	https://basho-giddyup.s3.amazonaws.com/1536.log	riak-1.3.0pre1-master
1537	f	\N	244	7	2012-12-20 19:29:49.599059	2012-12-20 19:29:49.599059	https://basho-giddyup.s3.amazonaws.com/1537.log	riak-1.3.0pre1-master
1538	t	\N	261	7	2012-12-20 19:31:29.609844	2012-12-20 19:31:29.609844	https://basho-giddyup.s3.amazonaws.com/1538.log	riak-1.3.0pre1-master
1539	f	\N	256	7	2012-12-20 19:32:33.212216	2012-12-20 19:32:33.212216	https://basho-giddyup.s3.amazonaws.com/1539.log	riak-1.3.0pre1-master
1540	f	\N	257	7	2012-12-20 19:32:35.890298	2012-12-20 19:32:35.890298	https://basho-giddyup.s3.amazonaws.com/1540.log	riak-1.3.0pre1-master
1541	t	\N	162	7	2012-12-20 19:32:52.451795	2012-12-20 19:32:52.451795	https://basho-giddyup.s3.amazonaws.com/1541.log	riak-1.3.0pre1-master
1542	t	\N	173	7	2012-12-20 19:33:49.331301	2012-12-20 19:33:49.331301	https://basho-giddyup.s3.amazonaws.com/1542.log	riak-1.3.0pre1-master
1543	t	\N	174	7	2012-12-20 19:35:20.826686	2012-12-20 19:35:20.826686	https://basho-giddyup.s3.amazonaws.com/1543.log	riak-1.3.0pre1-master
1544	t	\N	269	7	2012-12-20 19:36:13.963742	2012-12-20 19:36:13.963742	https://basho-giddyup.s3.amazonaws.com/1544.log	riak-1.3.0pre1-master
1545	t	\N	231	7	2012-12-20 19:36:23.84949	2012-12-20 19:36:23.84949	https://basho-giddyup.s3.amazonaws.com/1545.log	riak-1.3.0pre1-master
1546	f	\N	243	7	2012-12-20 19:38:36.491705	2012-12-20 19:38:36.491705	https://basho-giddyup.s3.amazonaws.com/1546.log	riak-1.3.0pre1-master
1547	t	\N	99	7	2012-12-20 19:39:16.962322	2012-12-20 19:39:16.962322	https://basho-giddyup.s3.amazonaws.com/1547.log	riak-1.3.0pre1-master
1548	f	\N	109	7	2012-12-20 19:39:31.125061	2012-12-20 19:39:31.125061	https://basho-giddyup.s3.amazonaws.com/1548.log	riak-1.3.0pre1-master
1549	f	\N	281	7	2012-12-20 19:40:25.7349	2012-12-20 19:40:25.7349	https://basho-giddyup.s3.amazonaws.com/1549.log	riak-1.3.0pre1-master
1550	t	\N	273	7	2012-12-20 19:40:51.243588	2012-12-20 19:40:51.243588	https://basho-giddyup.s3.amazonaws.com/1550.log	riak-1.3.0pre1-master
1551	t	\N	317	7	2012-12-20 19:41:15.44905	2012-12-20 19:41:15.44905	https://basho-giddyup.s3.amazonaws.com/1551.log	riak-1.3.0pre1-master
1552	t	\N	268	7	2012-12-20 19:41:59.854357	2012-12-20 19:41:59.854357	https://basho-giddyup.s3.amazonaws.com/1552.log	riak-1.3.0pre1-master
1553	f	\N	280	7	2012-12-20 19:42:08.572385	2012-12-20 19:42:08.572385	https://basho-giddyup.s3.amazonaws.com/1553.log	riak-1.3.0pre1-master
1554	t	\N	316	7	2012-12-20 19:43:10.318635	2012-12-20 19:43:10.318635	https://basho-giddyup.s3.amazonaws.com/1554.log	riak-1.3.0pre1-master
1555	f	\N	255	7	2012-12-20 19:43:31.507147	2012-12-20 19:43:31.507147	https://basho-giddyup.s3.amazonaws.com/1555.log	riak-1.3.0pre1-master
1556	f	\N	285	7	2012-12-20 19:44:12.474087	2012-12-20 19:44:12.474087	https://basho-giddyup.s3.amazonaws.com/1556.log	riak-1.3.0pre1-master
1557	t	\N	321	7	2012-12-20 19:45:00.103905	2012-12-20 19:45:00.103905	https://basho-giddyup.s3.amazonaws.com/1557.log	riak-1.3.0pre1-master
1558	t	\N	119	7	2012-12-20 19:45:21.852845	2012-12-20 19:45:21.852845	https://basho-giddyup.s3.amazonaws.com/1558.log	riak-1.3.0pre1-master
1559	t	\N	129	7	2012-12-20 19:50:38.645911	2012-12-20 19:50:38.645911	https://basho-giddyup.s3.amazonaws.com/1559.log	riak-1.3.0pre1-master
1560	t	\N	267	7	2012-12-20 19:52:25.960887	2012-12-20 19:52:25.960887	https://basho-giddyup.s3.amazonaws.com/1560.log	riak-1.3.0pre1-master
1561	t	\N	300	7	2012-12-20 19:53:38.003974	2012-12-20 19:53:38.003974	https://basho-giddyup.s3.amazonaws.com/1561.log	riak-1.3.0pre1-master
1562	f	\N	279	7	2012-12-20 19:53:47.187321	2012-12-20 19:53:47.187321	https://basho-giddyup.s3.amazonaws.com/1562.log	riak-1.3.0pre1-master
1563	t	\N	315	7	2012-12-20 19:54:53.706838	2012-12-20 19:54:53.706838	https://basho-giddyup.s3.amazonaws.com/1563.log	riak-1.3.0pre1-master
1564	t	\N	139	7	2012-12-20 19:57:55.332488	2012-12-20 19:57:55.332488	https://basho-giddyup.s3.amazonaws.com/1564.log	riak-1.3.0pre1-master
1565	t	\N	149	7	2012-12-20 19:59:43.112723	2012-12-20 19:59:43.112723	https://basho-giddyup.s3.amazonaws.com/1565.log	riak-1.3.0pre1-master
1566	t	\N	159	7	2012-12-20 20:01:59.816602	2012-12-20 20:01:59.816602	https://basho-giddyup.s3.amazonaws.com/1566.log	riak-1.3.0pre1-master
1567	t	\N	304	7	2012-12-20 20:16:11.825173	2012-12-20 20:16:11.825173	https://basho-giddyup.s3.amazonaws.com/1567.log	riak-1.3.0pre1-master
1568	t	\N	294	7	2012-12-20 20:18:49.24788	2012-12-20 20:18:49.24788	https://basho-giddyup.s3.amazonaws.com/1568.log	riak-1.3.0pre1-master
1569	t	\N	296	7	2012-12-20 20:23:09.257998	2012-12-20 20:23:09.257998	https://basho-giddyup.s3.amazonaws.com/1569.log	riak-1.3.0pre1-master
1570	t	\N	334	7	2012-12-20 20:27:10.403482	2012-12-20 20:27:10.403482	https://basho-giddyup.s3.amazonaws.com/1570.log	riak-1.3.0pre1-master
1571	t	\N	292	7	2012-12-20 20:28:23.549574	2012-12-20 20:28:23.549574	https://basho-giddyup.s3.amazonaws.com/1571.log	riak-1.3.0pre1-master
1572	t	\N	332	7	2012-12-20 20:55:55.826853	2012-12-20 20:55:55.826853	https://basho-giddyup.s3.amazonaws.com/1572.log	riak-1.3.0pre1-master
1573	t	\N	330	7	2012-12-20 21:01:46.098688	2012-12-20 21:01:46.098688	https://basho-giddyup.s3.amazonaws.com/1573.log	riak-1.3.0pre1-master
1574	t	\N	328	7	2012-12-20 21:02:20.280064	2012-12-20 21:02:20.280064	https://basho-giddyup.s3.amazonaws.com/1574.log	riak-1.3.0pre1-master
1575	t	\N	301	7	2012-12-20 21:09:20.66878	2012-12-20 21:09:20.66878	https://basho-giddyup.s3.amazonaws.com/1575.log	riak-1.3.0pre1-master
1576	t	\N	297	7	2012-12-20 21:43:08.132445	2012-12-20 21:43:08.132445	https://basho-giddyup.s3.amazonaws.com/1576.log	riak-1.3.0pre1-master
1577	t	\N	293	7	2012-12-20 21:49:53.753432	2012-12-20 21:49:53.753432	https://basho-giddyup.s3.amazonaws.com/1577.log	riak-1.3.0pre1-master
1578	t	\N	335	7	2012-12-20 21:51:12.806688	2012-12-20 21:51:12.806688	https://basho-giddyup.s3.amazonaws.com/1578.log	riak-1.3.0pre1-master
1579	t	\N	295	7	2012-12-20 21:53:03.386325	2012-12-20 21:53:03.386325	https://basho-giddyup.s3.amazonaws.com/1579.log	riak-1.3.0pre1-master
1580	t	\N	360	7	2012-12-20 21:53:57.575136	2012-12-20 21:53:57.575136	https://basho-giddyup.s3.amazonaws.com/1580.log	riak-1.3.0pre1-master
1581	t	\N	367	7	2012-12-20 21:54:46.514482	2012-12-20 21:54:46.514482	https://basho-giddyup.s3.amazonaws.com/1581.log	riak-1.3.0pre1-master
1582	t	\N	379	7	2012-12-20 21:55:19.208084	2012-12-20 21:55:19.208084	https://basho-giddyup.s3.amazonaws.com/1582.log	riak-1.3.0pre1-master
1583	t	\N	391	7	2012-12-20 21:56:13.65017	2012-12-20 21:56:13.65017	https://basho-giddyup.s3.amazonaws.com/1583.log	riak-1.3.0pre1-master
1584	t	\N	403	7	2012-12-20 22:03:31.299905	2012-12-20 22:03:31.299905	https://basho-giddyup.s3.amazonaws.com/1584.log	riak-1.3.0pre1-master
1586	t	\N	329	7	2012-12-20 22:32:38.048869	2012-12-20 22:32:38.048869	https://basho-giddyup.s3.amazonaws.com/1586.log	riak-1.3.0pre1-master
1587	t	\N	353	7	2012-12-20 22:34:19.185728	2012-12-20 22:34:19.185728	https://basho-giddyup.s3.amazonaws.com/1587.log	riak-1.3.0pre1-master
1588	t	\N	351	7	2012-12-20 22:34:24.510331	2012-12-20 22:34:24.510331	https://basho-giddyup.s3.amazonaws.com/1588.log	riak-1.3.0pre1-master
1589	t	\N	365	7	2012-12-20 22:34:58.509329	2012-12-20 22:34:58.509329	https://basho-giddyup.s3.amazonaws.com/1589.log	riak-1.3.0pre1-master
1590	t	\N	363	7	2012-12-20 22:35:01.061933	2012-12-20 22:35:01.061933	https://basho-giddyup.s3.amazonaws.com/1590.log	riak-1.3.0pre1-master
1591	t	\N	377	7	2012-12-20 22:35:27.269155	2012-12-20 22:35:27.269155	https://basho-giddyup.s3.amazonaws.com/1591.log	riak-1.3.0pre1-master
1592	t	\N	375	7	2012-12-20 22:35:30.632288	2012-12-20 22:35:30.632288	https://basho-giddyup.s3.amazonaws.com/1592.log	riak-1.3.0pre1-master
1593	t	\N	389	7	2012-12-20 22:36:15.879248	2012-12-20 22:36:15.879248	https://basho-giddyup.s3.amazonaws.com/1593.log	riak-1.3.0pre1-master
1594	t	\N	387	7	2012-12-20 22:36:38.579375	2012-12-20 22:36:38.579375	https://basho-giddyup.s3.amazonaws.com/1594.log	riak-1.3.0pre1-master
1595	t	\N	331	7	2012-12-20 22:40:10.066637	2012-12-20 22:40:10.066637	https://basho-giddyup.s3.amazonaws.com/1595.log	riak-1.3.0pre1-master
1596	t	\N	399	7	2012-12-20 22:41:56.814198	2012-12-20 22:41:56.814198	https://basho-giddyup.s3.amazonaws.com/1596.log	riak-1.3.0pre1-master
1597	t	\N	401	7	2012-12-20 22:43:36.393015	2012-12-20 22:43:36.393015	https://basho-giddyup.s3.amazonaws.com/1597.log	riak-1.3.0pre1-master
1598	t	\N	352	7	2012-12-20 22:47:47.704504	2012-12-20 22:47:47.704504	https://basho-giddyup.s3.amazonaws.com/1598.log	riak-1.3.0pre1-master
1599	t	\N	364	7	2012-12-20 22:48:29.794863	2012-12-20 22:48:29.794863	https://basho-giddyup.s3.amazonaws.com/1599.log	riak-1.3.0pre1-master
1600	t	\N	376	7	2012-12-20 22:49:04.176168	2012-12-20 22:49:04.176168	https://basho-giddyup.s3.amazonaws.com/1600.log	riak-1.3.0pre1-master
1601	t	\N	388	7	2012-12-20 22:50:03.910236	2012-12-20 22:50:03.910236	https://basho-giddyup.s3.amazonaws.com/1601.log	riak-1.3.0pre1-master
1602	t	\N	400	7	2012-12-20 22:57:08.314892	2012-12-20 22:57:08.314892	https://basho-giddyup.s3.amazonaws.com/1602.log	riak-1.3.0pre1-master
1603	t	\N	9	7	2012-12-20 23:42:55.991508	2012-12-20 23:42:55.991508	https://basho-giddyup.s3.amazonaws.com/1603.log	riak-1.3.0pre1-master
1604	t	\N	19	7	2012-12-20 23:45:15.325505	2012-12-20 23:45:15.325505	https://basho-giddyup.s3.amazonaws.com/1604.log	riak-1.3.0pre1-master
1605	t	\N	29	7	2012-12-20 23:51:16.792679	2012-12-20 23:51:16.792679	https://basho-giddyup.s3.amazonaws.com/1605.log	riak-1.3.0pre1-master
1606	t	\N	39	7	2012-12-20 23:56:39.268111	2012-12-20 23:56:39.268111	https://basho-giddyup.s3.amazonaws.com/1606.log	riak-1.3.0pre1-master
1607	f	\N	49	7	2012-12-20 23:59:47.751871	2012-12-20 23:59:47.751871	https://basho-giddyup.s3.amazonaws.com/1607.log	riak-1.3.0pre1-master
1608	f	\N	59	7	2012-12-20 23:59:55.817469	2012-12-20 23:59:55.817469	https://basho-giddyup.s3.amazonaws.com/1608.log	riak-1.3.0pre1-master
1609	t	\N	69	7	2012-12-21 00:03:28.203332	2012-12-21 00:03:28.203332	https://basho-giddyup.s3.amazonaws.com/1609.log	riak-1.3.0pre1-master
1610	t	\N	99	7	2012-12-21 00:21:41.829814	2012-12-21 00:21:41.829814	https://basho-giddyup.s3.amazonaws.com/1610.log	riak-1.3.0pre1-master
1611	f	\N	109	7	2012-12-21 00:21:56.223193	2012-12-21 00:21:56.223193	https://basho-giddyup.s3.amazonaws.com/1611.log	riak-1.3.0pre1-master
1612	f	\N	119	7	2012-12-21 00:31:51.278839	2012-12-21 00:31:51.278839	https://basho-giddyup.s3.amazonaws.com/1612.log	riak-1.3.0pre1-master
1613	t	\N	129	7	2012-12-21 00:36:40.095632	2012-12-21 00:36:40.095632	https://basho-giddyup.s3.amazonaws.com/1613.log	riak-1.3.0pre1-master
1614	t	\N	139	7	2012-12-21 00:48:28.175856	2012-12-21 00:48:28.175856	https://basho-giddyup.s3.amazonaws.com/1614.log	riak-1.3.0pre1-master
1615	f	\N	149	7	2012-12-21 00:50:00.595589	2012-12-21 00:50:00.595589	https://basho-giddyup.s3.amazonaws.com/1615.log	riak-1.3.0pre1-master
1616	t	\N	159	7	2012-12-21 00:52:02.025578	2012-12-21 00:52:02.025578	https://basho-giddyup.s3.amazonaws.com/1616.log	riak-1.3.0pre1-master
1617	t	\N	169	7	2012-12-21 01:00:35.163065	2012-12-21 01:00:35.163065	https://basho-giddyup.s3.amazonaws.com/1617.log	riak-1.3.0pre1-master
1618	t	\N	187	7	2012-12-21 01:11:08.044693	2012-12-21 01:11:08.044693	https://basho-giddyup.s3.amazonaws.com/1618.log	riak-1.3.0pre1-master
1619	t	\N	188	7	2012-12-21 01:18:26.280047	2012-12-21 01:18:26.280047	https://basho-giddyup.s3.amazonaws.com/1619.log	riak-1.3.0pre1-master
1620	t	\N	239	7	2012-12-21 01:20:27.193978	2012-12-21 01:20:27.193978	https://basho-giddyup.s3.amazonaws.com/1620.log	riak-1.3.0pre1-master
1621	f	\N	251	7	2012-12-21 01:24:05.31112	2012-12-21 01:24:05.31112	https://basho-giddyup.s3.amazonaws.com/1621.log	riak-1.3.0pre1-master
1622	f	\N	263	7	2012-12-21 01:30:55.33973	2012-12-21 01:30:55.33973	https://basho-giddyup.s3.amazonaws.com/1622.log	riak-1.3.0pre1-master
1623	t	\N	275	7	2012-12-21 01:40:42.018681	2012-12-21 01:40:42.018681	https://basho-giddyup.s3.amazonaws.com/1623.log	riak-1.3.0pre1-master
1624	f	\N	287	7	2012-12-21 01:51:33.298912	2012-12-21 01:51:33.298912	https://basho-giddyup.s3.amazonaws.com/1624.log	riak-1.3.0pre1-master
1625	t	\N	323	7	2012-12-21 01:55:56.606153	2012-12-21 01:55:56.606153	https://basho-giddyup.s3.amazonaws.com/1625.log	riak-1.3.0pre1-master
1626	f	\N	308	7	2012-12-21 01:58:48.572019	2012-12-21 01:58:48.572019	https://basho-giddyup.s3.amazonaws.com/1626.log	riak-1.3.0pre1-master
1627	f	\N	309	7	2012-12-21 02:10:26.783571	2012-12-21 02:10:26.783571	https://basho-giddyup.s3.amazonaws.com/1627.log	riak-1.3.0pre1-master
1628	f	\N	89	7	2012-12-21 02:11:39.50524	2012-12-21 02:11:39.50524	https://basho-giddyup.s3.amazonaws.com/1628.log	riak-1.3.0pre1-master
1629	t	\N	371	7	2012-12-21 02:14:06.281434	2012-12-21 02:14:06.281434	https://basho-giddyup.s3.amazonaws.com/1629.log	riak-1.3.0pre1-master
1630	t	\N	383	7	2012-12-21 02:21:04.602285	2012-12-21 02:21:04.602285	https://basho-giddyup.s3.amazonaws.com/1630.log	riak-1.3.0pre1-master
1631	t	\N	395	7	2012-12-21 02:23:46.750932	2012-12-21 02:23:46.750932	https://basho-giddyup.s3.amazonaws.com/1631.log	riak-1.3.0pre1-master
1632	t	\N	407	7	2012-12-21 02:42:27.971959	2012-12-21 02:42:27.971959	https://basho-giddyup.s3.amazonaws.com/1632.log	riak-1.3.0pre1-master
1633	t	\N	235	7	2012-12-21 17:05:25.376541	2012-12-21 17:05:25.376541	https://basho-giddyup.s3.amazonaws.com/1633.log	riak-1.3.0pre1-master
1634	t	\N	391	7	2012-12-21 17:08:34.431567	2012-12-21 17:08:34.431567	https://basho-giddyup.s3.amazonaws.com/1634.log	riak-1.3.0pre1-master
1635	f	\N	259	7	2012-12-21 17:12:11.441437	2012-12-21 17:12:11.441437	https://basho-giddyup.s3.amazonaws.com/1635.log	riak-1.3.0pre1-master
1636	f	\N	259	7	2012-12-21 18:16:38.820071	2012-12-21 18:16:38.820071	https://basho-giddyup.s3.amazonaws.com/1636.log	riak-1.3.0pre1-master
1637	f	\N	259	7	2012-12-21 19:11:20.425279	2012-12-21 19:11:20.425279	https://basho-giddyup.s3.amazonaws.com/1637.log	riak-1.3.0pre1-master
1638	t	\N	211	7	2012-12-21 19:24:23.456935	2012-12-21 19:24:23.456935	https://basho-giddyup.s3.amazonaws.com/1638.log	riak-1.3.0pre1-master
1639	f	\N	212	7	2012-12-21 19:25:21.95094	2012-12-21 19:25:21.95094	https://basho-giddyup.s3.amazonaws.com/1639.log	riak-1.3.0pre1-master
1640	t	\N	213	7	2012-12-21 19:27:42.189157	2012-12-21 19:27:42.189157	https://basho-giddyup.s3.amazonaws.com/1640.log	riak-1.3.0pre1-master
1641	t	\N	214	7	2012-12-21 19:29:03.956573	2012-12-21 19:29:03.956573	https://basho-giddyup.s3.amazonaws.com/1641.log	riak-1.3.0pre1-master
1642	f	\N	215	7	2012-12-21 19:29:59.72567	2012-12-21 19:29:59.72567	https://basho-giddyup.s3.amazonaws.com/1642.log	riak-1.3.0pre1-master
1643	t	\N	216	7	2012-12-21 19:30:51.90439	2012-12-21 19:30:51.90439	https://basho-giddyup.s3.amazonaws.com/1643.log	riak-1.3.0pre1-master
1644	t	\N	217	7	2012-12-21 19:31:44.377094	2012-12-21 19:31:44.377094	https://basho-giddyup.s3.amazonaws.com/1644.log	riak-1.3.0pre1-master
1645	t	\N	220	7	2012-12-21 19:39:06.635612	2012-12-21 19:39:06.635612	https://basho-giddyup.s3.amazonaws.com/1645.log	riak-1.3.0pre1-master
1646	t	\N	221	7	2012-12-21 19:54:13.979437	2012-12-21 19:54:13.979437	https://basho-giddyup.s3.amazonaws.com/1646.log	riak-1.3.0pre1-master
1647	t	\N	222	7	2012-12-21 20:00:59.754085	2012-12-21 20:00:59.754085	https://basho-giddyup.s3.amazonaws.com/1647.log	riak-1.3.0pre1-master
1648	t	\N	223	7	2012-12-21 20:02:48.740805	2012-12-21 20:02:48.740805	https://basho-giddyup.s3.amazonaws.com/1648.log	riak-1.3.0pre1-master
1649	t	\N	224	7	2012-12-21 20:05:10.292395	2012-12-21 20:05:10.292395	https://basho-giddyup.s3.amazonaws.com/1649.log	riak-1.3.0pre1-master
1650	t	\N	225	7	2012-12-21 20:05:49.343052	2012-12-21 20:05:49.343052	https://basho-giddyup.s3.amazonaws.com/1650.log	riak-1.3.0pre1-master
1651	t	\N	226	7	2012-12-21 20:07:08.705217	2012-12-21 20:07:08.705217	https://basho-giddyup.s3.amazonaws.com/1651.log	riak-1.3.0pre1-master
1652	t	\N	227	7	2012-12-21 20:09:58.026828	2012-12-21 20:09:58.026828	https://basho-giddyup.s3.amazonaws.com/1652.log	riak-1.3.0pre1-master
1653	t	\N	228	7	2012-12-21 20:11:14.920415	2012-12-21 20:11:14.920415	https://basho-giddyup.s3.amazonaws.com/1653.log	riak-1.3.0pre1-master
1654	t	\N	229	7	2012-12-21 20:12:01.0655	2012-12-21 20:12:01.0655	https://basho-giddyup.s3.amazonaws.com/1654.log	riak-1.3.0pre1-master
1655	t	\N	235	7	2012-12-21 20:12:56.825125	2012-12-21 20:12:56.825125	https://basho-giddyup.s3.amazonaws.com/1655.log	riak-1.3.0pre1-master
1656	f	\N	247	7	2012-12-21 20:15:17.728229	2012-12-21 20:15:17.728229	https://basho-giddyup.s3.amazonaws.com/1656.log	riak-1.3.0pre1-master
1657	f	\N	259	7	2012-12-21 20:20:18.537163	2012-12-21 20:20:18.537163	https://basho-giddyup.s3.amazonaws.com/1657.log	riak-1.3.0pre1-master
1658	t	\N	271	7	2012-12-21 20:24:11.117321	2012-12-21 20:24:11.117321	https://basho-giddyup.s3.amazonaws.com/1658.log	riak-1.3.0pre1-master
1659	t	\N	219	7	2012-12-21 20:26:07.780539	2012-12-21 20:26:07.780539	https://basho-giddyup.s3.amazonaws.com/1659.log	riak-1.3.0pre1-master
1660	f	\N	283	7	2012-12-21 20:29:04.425087	2012-12-21 20:29:04.425087	https://basho-giddyup.s3.amazonaws.com/1660.log	riak-1.3.0pre1-master
1661	t	\N	319	7	2012-12-21 20:29:59.484945	2012-12-21 20:29:59.484945	https://basho-giddyup.s3.amazonaws.com/1661.log	riak-1.3.0pre1-master
1662	t	\N	300	7	2012-12-21 21:04:47.534169	2012-12-21 21:04:47.534169	https://basho-giddyup.s3.amazonaws.com/1662.log	riak-1.3.0pre1-master
1663	t	\N	334	7	2012-12-21 21:37:14.431585	2012-12-21 21:37:14.431585	https://basho-giddyup.s3.amazonaws.com/1663.log	riak-1.3.0pre1-master
1664	t	\N	301	7	2012-12-21 22:20:44.305155	2012-12-21 22:20:44.305155	https://basho-giddyup.s3.amazonaws.com/1664.log	riak-1.3.0pre1-master
1665	f	\N	335	7	2012-12-21 22:48:27.529878	2012-12-21 22:48:27.529878	https://basho-giddyup.s3.amazonaws.com/1665.log	riak-1.3.0pre1-master
1666	t	\N	360	7	2012-12-21 22:50:30.234859	2012-12-21 22:50:30.234859	https://basho-giddyup.s3.amazonaws.com/1666.log	riak-1.3.0pre1-master
1667	t	\N	367	7	2012-12-21 22:51:10.376728	2012-12-21 22:51:10.376728	https://basho-giddyup.s3.amazonaws.com/1667.log	riak-1.3.0pre1-master
1668	t	\N	379	7	2012-12-21 22:51:39.280688	2012-12-21 22:51:39.280688	https://basho-giddyup.s3.amazonaws.com/1668.log	riak-1.3.0pre1-master
1669	t	\N	391	7	2012-12-21 22:52:34.688865	2012-12-21 22:52:34.688865	https://basho-giddyup.s3.amazonaws.com/1669.log	riak-1.3.0pre1-master
1670	t	\N	403	7	2012-12-21 22:58:59.06188	2012-12-21 22:58:59.06188	https://basho-giddyup.s3.amazonaws.com/1670.log	riak-1.3.0pre1-master
\.


--
-- Name: test_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('test_results_id_seq', 1670, true);


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tests (id, name, tags) FROM stdin;
1	gh_riak_core_154	"platform"=>"ubuntu-1004-32"
2	gh_riak_core_154	"platform"=>"ubuntu-1004-64"
3	gh_riak_core_154	"platform"=>"ubuntu-1104-64"
4	gh_riak_core_154	"platform"=>"ubuntu-1204-64"
6	gh_riak_core_154	"platform"=>"centos-5-64"
7	gh_riak_core_154	"platform"=>"centos-6-64"
8	gh_riak_core_154	"platform"=>"solaris-10u9-64"
9	gh_riak_core_154	"platform"=>"freebsd-9-64"
10	gh_riak_core_154	"platform"=>"smartos-64"
11	gh_riak_core_155	"platform"=>"ubuntu-1004-32"
12	gh_riak_core_155	"platform"=>"ubuntu-1004-64"
13	gh_riak_core_155	"platform"=>"ubuntu-1104-64"
14	gh_riak_core_155	"platform"=>"ubuntu-1204-64"
16	gh_riak_core_155	"platform"=>"centos-5-64"
17	gh_riak_core_155	"platform"=>"centos-6-64"
18	gh_riak_core_155	"platform"=>"solaris-10u9-64"
19	gh_riak_core_155	"platform"=>"freebsd-9-64"
20	gh_riak_core_155	"platform"=>"smartos-64"
21	gh_riak_core_176	"platform"=>"ubuntu-1004-32"
22	gh_riak_core_176	"platform"=>"ubuntu-1004-64"
23	gh_riak_core_176	"platform"=>"ubuntu-1104-64"
24	gh_riak_core_176	"platform"=>"ubuntu-1204-64"
26	gh_riak_core_176	"platform"=>"centos-5-64"
27	gh_riak_core_176	"platform"=>"centos-6-64"
28	gh_riak_core_176	"platform"=>"solaris-10u9-64"
29	gh_riak_core_176	"platform"=>"freebsd-9-64"
30	gh_riak_core_176	"platform"=>"smartos-64"
31	mapred_verify_rt	"platform"=>"ubuntu-1004-32"
32	mapred_verify_rt	"platform"=>"ubuntu-1004-64"
33	mapred_verify_rt	"platform"=>"ubuntu-1104-64"
34	mapred_verify_rt	"platform"=>"ubuntu-1204-64"
36	mapred_verify_rt	"platform"=>"centos-5-64"
37	mapred_verify_rt	"platform"=>"centos-6-64"
38	mapred_verify_rt	"platform"=>"solaris-10u9-64"
39	mapred_verify_rt	"platform"=>"freebsd-9-64"
40	mapred_verify_rt	"platform"=>"smartos-64"
41	riaknostic_rt	"platform"=>"ubuntu-1004-32"
42	riaknostic_rt	"platform"=>"ubuntu-1004-64"
43	riaknostic_rt	"platform"=>"ubuntu-1104-64"
44	riaknostic_rt	"platform"=>"ubuntu-1204-64"
46	riaknostic_rt	"platform"=>"centos-5-64"
47	riaknostic_rt	"platform"=>"centos-6-64"
48	riaknostic_rt	"platform"=>"solaris-10u9-64"
49	riaknostic_rt	"platform"=>"freebsd-9-64"
50	riaknostic_rt	"platform"=>"smartos-64"
51	rolling_capabilities	"platform"=>"ubuntu-1004-32"
52	rolling_capabilities	"platform"=>"ubuntu-1004-64"
53	rolling_capabilities	"platform"=>"ubuntu-1104-64"
54	rolling_capabilities	"platform"=>"ubuntu-1204-64"
56	rolling_capabilities	"platform"=>"centos-5-64"
57	rolling_capabilities	"platform"=>"centos-6-64"
58	rolling_capabilities	"platform"=>"solaris-10u9-64"
59	rolling_capabilities	"platform"=>"freebsd-9-64"
60	rolling_capabilities	"platform"=>"smartos-64"
61	rt_basic_test	"platform"=>"ubuntu-1004-32"
62	rt_basic_test	"platform"=>"ubuntu-1004-64"
63	rt_basic_test	"platform"=>"ubuntu-1104-64"
64	rt_basic_test	"platform"=>"ubuntu-1204-64"
66	rt_basic_test	"platform"=>"centos-5-64"
67	rt_basic_test	"platform"=>"centos-6-64"
68	rt_basic_test	"platform"=>"solaris-10u9-64"
69	rt_basic_test	"platform"=>"freebsd-9-64"
70	rt_basic_test	"platform"=>"smartos-64"
91	verify_build_cluster	"platform"=>"ubuntu-1004-32"
92	verify_build_cluster	"platform"=>"ubuntu-1004-64"
93	verify_build_cluster	"platform"=>"ubuntu-1104-64"
94	verify_build_cluster	"platform"=>"ubuntu-1204-64"
5	gh_riak_core_154	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
15	gh_riak_core_155	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
25	gh_riak_core_176	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
35	mapred_verify_rt	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
45	riaknostic_rt	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
55	rolling_capabilities	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
65	rt_basic_test	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
81	verify_basic_upgrade	"platform"=>"ubuntu-1004-32", "upgrade_version"=>"previous"
82	verify_basic_upgrade	"platform"=>"ubuntu-1004-64", "upgrade_version"=>"previous"
83	verify_basic_upgrade	"platform"=>"ubuntu-1104-64", "upgrade_version"=>"previous"
84	verify_basic_upgrade	"platform"=>"ubuntu-1204-64", "upgrade_version"=>"previous"
86	verify_basic_upgrade	"platform"=>"centos-5-64", "upgrade_version"=>"previous"
87	verify_basic_upgrade	"platform"=>"centos-6-64", "upgrade_version"=>"previous"
96	verify_build_cluster	"platform"=>"centos-5-64"
97	verify_build_cluster	"platform"=>"centos-6-64"
98	verify_build_cluster	"platform"=>"solaris-10u9-64"
99	verify_build_cluster	"platform"=>"freebsd-9-64"
100	verify_build_cluster	"platform"=>"smartos-64"
101	verify_capabilities	"platform"=>"ubuntu-1004-32"
102	verify_capabilities	"platform"=>"ubuntu-1004-64"
103	verify_capabilities	"platform"=>"ubuntu-1104-64"
104	verify_capabilities	"platform"=>"ubuntu-1204-64"
106	verify_capabilities	"platform"=>"centos-5-64"
107	verify_capabilities	"platform"=>"centos-6-64"
108	verify_capabilities	"platform"=>"solaris-10u9-64"
109	verify_capabilities	"platform"=>"freebsd-9-64"
110	verify_capabilities	"platform"=>"smartos-64"
111	verify_claimant	"platform"=>"ubuntu-1004-32"
112	verify_claimant	"platform"=>"ubuntu-1004-64"
113	verify_claimant	"platform"=>"ubuntu-1104-64"
114	verify_claimant	"platform"=>"ubuntu-1204-64"
116	verify_claimant	"platform"=>"centos-5-64"
117	verify_claimant	"platform"=>"centos-6-64"
118	verify_claimant	"platform"=>"solaris-10u9-64"
119	verify_claimant	"platform"=>"freebsd-9-64"
120	verify_claimant	"platform"=>"smartos-64"
121	verify_down	"platform"=>"ubuntu-1004-32"
122	verify_down	"platform"=>"ubuntu-1004-64"
123	verify_down	"platform"=>"ubuntu-1104-64"
124	verify_down	"platform"=>"ubuntu-1204-64"
126	verify_down	"platform"=>"centos-5-64"
127	verify_down	"platform"=>"centos-6-64"
128	verify_down	"platform"=>"solaris-10u9-64"
129	verify_down	"platform"=>"freebsd-9-64"
130	verify_down	"platform"=>"smartos-64"
131	verify_leave	"platform"=>"ubuntu-1004-32"
132	verify_leave	"platform"=>"ubuntu-1004-64"
133	verify_leave	"platform"=>"ubuntu-1104-64"
134	verify_leave	"platform"=>"ubuntu-1204-64"
136	verify_leave	"platform"=>"centos-5-64"
137	verify_leave	"platform"=>"centos-6-64"
138	verify_leave	"platform"=>"solaris-10u9-64"
139	verify_leave	"platform"=>"freebsd-9-64"
140	verify_leave	"platform"=>"smartos-64"
141	verify_riak_lager	"platform"=>"ubuntu-1004-32"
142	verify_riak_lager	"platform"=>"ubuntu-1004-64"
143	verify_riak_lager	"platform"=>"ubuntu-1104-64"
144	verify_riak_lager	"platform"=>"ubuntu-1204-64"
146	verify_riak_lager	"platform"=>"centos-5-64"
147	verify_riak_lager	"platform"=>"centos-6-64"
148	verify_riak_lager	"platform"=>"solaris-10u9-64"
149	verify_riak_lager	"platform"=>"freebsd-9-64"
150	verify_riak_lager	"platform"=>"smartos-64"
151	verify_riak_stats	"platform"=>"ubuntu-1004-32"
152	verify_riak_stats	"platform"=>"ubuntu-1004-64"
153	verify_riak_stats	"platform"=>"ubuntu-1104-64"
154	verify_riak_stats	"platform"=>"ubuntu-1204-64"
156	verify_riak_stats	"platform"=>"centos-5-64"
157	verify_riak_stats	"platform"=>"centos-6-64"
158	verify_riak_stats	"platform"=>"solaris-10u9-64"
159	verify_riak_stats	"platform"=>"freebsd-9-64"
160	verify_riak_stats	"platform"=>"smartos-64"
161	verify_staged_clustering	"platform"=>"ubuntu-1004-32"
162	verify_staged_clustering	"platform"=>"ubuntu-1004-64"
163	verify_staged_clustering	"platform"=>"ubuntu-1104-64"
164	verify_staged_clustering	"platform"=>"ubuntu-1204-64"
166	verify_staged_clustering	"platform"=>"centos-5-64"
167	verify_staged_clustering	"platform"=>"centos-6-64"
168	verify_staged_clustering	"platform"=>"solaris-10u9-64"
169	verify_staged_clustering	"platform"=>"freebsd-9-64"
170	verify_staged_clustering	"platform"=>"smartos-64"
171	secondary_index_tests	"backend"=>"memory", "platform"=>"ubuntu-1004-32"
172	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-32"
173	secondary_index_tests	"backend"=>"memory", "platform"=>"ubuntu-1004-64"
174	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-64"
175	secondary_index_tests	"backend"=>"memory", "platform"=>"ubuntu-1104-64"
176	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"ubuntu-1104-64"
177	secondary_index_tests	"backend"=>"memory", "platform"=>"ubuntu-1204-64"
178	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"ubuntu-1204-64"
181	secondary_index_tests	"backend"=>"memory", "platform"=>"centos-5-64"
182	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"centos-5-64"
183	secondary_index_tests	"backend"=>"memory", "platform"=>"centos-6-64"
184	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"centos-6-64"
185	secondary_index_tests	"backend"=>"memory", "platform"=>"solaris-10u9-64"
186	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"solaris-10u9-64"
187	secondary_index_tests	"backend"=>"memory", "platform"=>"freebsd-9-64"
188	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"freebsd-9-64"
189	secondary_index_tests	"backend"=>"memory", "platform"=>"smartos-64"
190	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"smartos-64"
191	repl_test	"platform"=>"ubuntu-1104-64"
192	gh_riak_core_154	"platform"=>"osx-64"
193	gh_riak_core_155	"platform"=>"osx-64"
194	gh_riak_core_176	"platform"=>"osx-64"
195	mapred_verify_rt	"platform"=>"osx-64"
196	riaknostic_rt	"platform"=>"osx-64"
197	rolling_capabilities	"platform"=>"osx-64"
198	rt_basic_test	"platform"=>"osx-64"
201	verify_build_cluster	"platform"=>"osx-64"
202	verify_capabilities	"platform"=>"osx-64"
203	verify_claimant	"platform"=>"osx-64"
204	verify_down	"platform"=>"osx-64"
205	verify_leave	"platform"=>"osx-64"
206	verify_riak_lager	"platform"=>"osx-64"
207	verify_riak_stats	"platform"=>"osx-64"
208	verify_staged_clustering	"platform"=>"osx-64"
209	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"osx-64"
210	secondary_index_tests	"backend"=>"memory", "platform"=>"osx-64"
211	gh_riak_core_154	"platform"=>"fedora-17-64"
212	gh_riak_core_155	"platform"=>"fedora-17-64"
213	gh_riak_core_176	"platform"=>"fedora-17-64"
214	mapred_verify_rt	"platform"=>"fedora-17-64"
215	riaknostic_rt	"platform"=>"fedora-17-64"
216	rolling_capabilities	"platform"=>"fedora-17-64"
217	rt_basic_test	"platform"=>"fedora-17-64"
220	verify_build_cluster	"platform"=>"fedora-17-64"
221	verify_capabilities	"platform"=>"fedora-17-64"
222	verify_claimant	"platform"=>"fedora-17-64"
223	verify_down	"platform"=>"fedora-17-64"
224	verify_leave	"platform"=>"fedora-17-64"
225	verify_riak_lager	"platform"=>"fedora-17-64"
226	verify_riak_stats	"platform"=>"fedora-17-64"
227	verify_staged_clustering	"platform"=>"fedora-17-64"
228	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"fedora-17-64"
229	secondary_index_tests	"backend"=>"memory", "platform"=>"fedora-17-64"
230	basic_command_line	"platform"=>"ubuntu-1004-32"
231	basic_command_line	"platform"=>"ubuntu-1004-64"
232	basic_command_line	"platform"=>"ubuntu-1104-64"
233	basic_command_line	"platform"=>"ubuntu-1204-64"
235	basic_command_line	"platform"=>"fedora-17-64"
236	basic_command_line	"platform"=>"centos-5-64"
237	basic_command_line	"platform"=>"centos-6-64"
238	basic_command_line	"platform"=>"solaris-10u9-64"
239	basic_command_line	"platform"=>"freebsd-9-64"
240	basic_command_line	"platform"=>"smartos-64"
241	basic_command_line	"platform"=>"osx-64"
242	client_java_verify	"platform"=>"ubuntu-1004-32"
243	client_java_verify	"platform"=>"ubuntu-1004-64"
244	client_java_verify	"platform"=>"ubuntu-1104-64"
245	client_java_verify	"platform"=>"ubuntu-1204-64"
247	client_java_verify	"platform"=>"fedora-17-64"
248	client_java_verify	"platform"=>"centos-5-64"
249	client_java_verify	"platform"=>"centos-6-64"
250	client_java_verify	"platform"=>"solaris-10u9-64"
251	client_java_verify	"platform"=>"freebsd-9-64"
252	client_java_verify	"platform"=>"smartos-64"
253	client_java_verify	"platform"=>"osx-64"
254	partition_repair	"platform"=>"ubuntu-1004-32"
255	partition_repair	"platform"=>"ubuntu-1004-64"
256	partition_repair	"platform"=>"ubuntu-1104-64"
257	partition_repair	"platform"=>"ubuntu-1204-64"
259	partition_repair	"platform"=>"fedora-17-64"
260	partition_repair	"platform"=>"centos-5-64"
261	partition_repair	"platform"=>"centos-6-64"
262	partition_repair	"platform"=>"solaris-10u9-64"
263	partition_repair	"platform"=>"freebsd-9-64"
264	partition_repair	"platform"=>"smartos-64"
265	partition_repair	"platform"=>"osx-64"
266	verify_listkeys	"platform"=>"ubuntu-1004-32"
267	verify_listkeys	"platform"=>"ubuntu-1004-64"
268	verify_listkeys	"platform"=>"ubuntu-1104-64"
269	verify_listkeys	"platform"=>"ubuntu-1204-64"
271	verify_listkeys	"platform"=>"fedora-17-64"
272	verify_listkeys	"platform"=>"centos-5-64"
273	verify_listkeys	"platform"=>"centos-6-64"
274	verify_listkeys	"platform"=>"solaris-10u9-64"
275	verify_listkeys	"platform"=>"freebsd-9-64"
276	verify_listkeys	"platform"=>"smartos-64"
277	verify_listkeys	"platform"=>"osx-64"
278	client_ruby_verify	"backend"=>"memory", "platform"=>"ubuntu-1004-32"
200	verify_basic_upgrade	"platform"=>"osx-64", "upgrade_version"=>"previous"
219	verify_basic_upgrade	"platform"=>"fedora-17-64", "upgrade_version"=>"previous"
279	client_ruby_verify	"backend"=>"memory", "platform"=>"ubuntu-1004-64"
280	client_ruby_verify	"backend"=>"memory", "platform"=>"ubuntu-1104-64"
281	client_ruby_verify	"backend"=>"memory", "platform"=>"ubuntu-1204-64"
283	client_ruby_verify	"backend"=>"memory", "platform"=>"fedora-17-64"
284	client_ruby_verify	"backend"=>"memory", "platform"=>"centos-5-64"
285	client_ruby_verify	"backend"=>"memory", "platform"=>"centos-6-64"
286	client_ruby_verify	"backend"=>"memory", "platform"=>"solaris-10u9-64"
287	client_ruby_verify	"backend"=>"memory", "platform"=>"freebsd-9-64"
288	client_ruby_verify	"backend"=>"memory", "platform"=>"smartos-64"
289	client_ruby_verify	"backend"=>"memory", "platform"=>"osx-64"
314	verify_reset_bucket_props	"platform"=>"ubuntu-1004-32", "min_version"=>"1.3.0"
315	verify_reset_bucket_props	"platform"=>"ubuntu-1004-64", "min_version"=>"1.3.0"
316	verify_reset_bucket_props	"platform"=>"ubuntu-1104-64", "min_version"=>"1.3.0"
317	verify_reset_bucket_props	"platform"=>"ubuntu-1204-64", "min_version"=>"1.3.0"
319	verify_reset_bucket_props	"platform"=>"fedora-17-64", "min_version"=>"1.3.0"
320	verify_reset_bucket_props	"platform"=>"centos-5-64", "min_version"=>"1.3.0"
321	verify_reset_bucket_props	"platform"=>"centos-6-64", "min_version"=>"1.3.0"
322	verify_reset_bucket_props	"platform"=>"solaris-10u9-64", "min_version"=>"1.3.0"
323	verify_reset_bucket_props	"platform"=>"freebsd-9-64", "min_version"=>"1.3.0"
324	verify_reset_bucket_props	"platform"=>"smartos-64", "min_version"=>"1.3.0"
325	verify_reset_bucket_props	"platform"=>"osx-64", "min_version"=>"1.3.0"
234	basic_command_line	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
246	client_java_verify	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
282	client_ruby_verify	"backend"=>"memory", "platform"=>"fedora-15-64", "max_version"=>"1.2.99"
258	partition_repair	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
180	secondary_index_tests	"backend"=>"eleveldb", "platform"=>"fedora-15-64", "max_version"=>"1.2.99"
179	secondary_index_tests	"backend"=>"memory", "platform"=>"fedora-15-64", "max_version"=>"1.2.99"
95	verify_build_cluster	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
105	verify_capabilities	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
115	verify_claimant	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
125	verify_down	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
135	verify_leave	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
270	verify_listkeys	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
318	verify_reset_bucket_props	"platform"=>"fedora-15-64", "max_version"=>"1.2.99", "min_version"=>"1.3.0"
145	verify_riak_lager	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
155	verify_riak_stats	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
165	verify_staged_clustering	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
290	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1004-32", "upgrade_version"=>"previous"
326	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1004-32", "upgrade_version"=>"legacy"
291	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-32", "upgrade_version"=>"previous"
327	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-32", "upgrade_version"=>"legacy"
292	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1004-64", "upgrade_version"=>"previous"
328	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1004-64", "upgrade_version"=>"legacy"
293	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-64", "upgrade_version"=>"previous"
329	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-64", "upgrade_version"=>"legacy"
294	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1104-64", "upgrade_version"=>"previous"
330	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1104-64", "upgrade_version"=>"legacy"
295	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1104-64", "upgrade_version"=>"previous"
331	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1104-64", "upgrade_version"=>"legacy"
296	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1204-64", "upgrade_version"=>"previous"
332	loaded_upgrade	"backend"=>"bitcask", "platform"=>"ubuntu-1204-64", "upgrade_version"=>"legacy"
297	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1204-64", "upgrade_version"=>"previous"
333	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"ubuntu-1204-64", "upgrade_version"=>"legacy"
300	loaded_upgrade	"backend"=>"bitcask", "platform"=>"fedora-17-64", "upgrade_version"=>"previous"
334	loaded_upgrade	"backend"=>"bitcask", "platform"=>"fedora-17-64", "upgrade_version"=>"legacy"
301	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"fedora-17-64", "upgrade_version"=>"previous"
335	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"fedora-17-64", "upgrade_version"=>"legacy"
302	loaded_upgrade	"backend"=>"bitcask", "platform"=>"centos-5-64", "upgrade_version"=>"previous"
336	loaded_upgrade	"backend"=>"bitcask", "platform"=>"centos-5-64", "upgrade_version"=>"legacy"
303	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"centos-5-64", "upgrade_version"=>"previous"
337	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"centos-5-64", "upgrade_version"=>"legacy"
304	loaded_upgrade	"backend"=>"bitcask", "platform"=>"centos-6-64", "upgrade_version"=>"previous"
338	loaded_upgrade	"backend"=>"bitcask", "platform"=>"centos-6-64", "upgrade_version"=>"legacy"
305	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"centos-6-64", "upgrade_version"=>"previous"
339	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"centos-6-64", "upgrade_version"=>"legacy"
306	loaded_upgrade	"backend"=>"bitcask", "platform"=>"solaris-10u9-64", "upgrade_version"=>"previous"
340	loaded_upgrade	"backend"=>"bitcask", "platform"=>"solaris-10u9-64", "upgrade_version"=>"legacy"
307	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"solaris-10u9-64", "upgrade_version"=>"previous"
341	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"solaris-10u9-64", "upgrade_version"=>"legacy"
308	loaded_upgrade	"backend"=>"bitcask", "platform"=>"freebsd-9-64", "upgrade_version"=>"previous"
309	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"freebsd-9-64", "upgrade_version"=>"previous"
310	loaded_upgrade	"backend"=>"bitcask", "platform"=>"smartos-64", "upgrade_version"=>"previous"
344	loaded_upgrade	"backend"=>"bitcask", "platform"=>"smartos-64", "upgrade_version"=>"legacy"
311	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"smartos-64", "upgrade_version"=>"previous"
345	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"smartos-64", "upgrade_version"=>"legacy"
312	loaded_upgrade	"backend"=>"bitcask", "platform"=>"osx-64", "upgrade_version"=>"previous"
346	loaded_upgrade	"backend"=>"bitcask", "platform"=>"osx-64", "upgrade_version"=>"legacy"
313	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"osx-64", "upgrade_version"=>"previous"
347	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"osx-64", "upgrade_version"=>"legacy"
299	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"fedora-15-64", "max_version"=>"1.2.99", "upgrade_version"=>"previous"
348	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"fedora-15-64", "max_version"=>"1.2.99", "upgrade_version"=>"legacy"
298	loaded_upgrade	"backend"=>"bitcask", "platform"=>"fedora-15-64", "max_version"=>"1.2.99", "upgrade_version"=>"previous"
349	loaded_upgrade	"backend"=>"bitcask", "platform"=>"fedora-15-64", "max_version"=>"1.2.99", "upgrade_version"=>"legacy"
350	verify_basic_upgrade	"platform"=>"ubuntu-1004-32", "upgrade_version"=>"legacy"
351	verify_basic_upgrade	"platform"=>"ubuntu-1004-64", "upgrade_version"=>"legacy"
352	verify_basic_upgrade	"platform"=>"ubuntu-1104-64", "upgrade_version"=>"legacy"
353	verify_basic_upgrade	"platform"=>"ubuntu-1204-64", "upgrade_version"=>"legacy"
354	verify_basic_upgrade	"platform"=>"centos-5-64", "upgrade_version"=>"legacy"
355	verify_basic_upgrade	"platform"=>"centos-6-64", "upgrade_version"=>"legacy"
88	verify_basic_upgrade	"platform"=>"solaris-10u9-64", "upgrade_version"=>"previous"
356	verify_basic_upgrade	"platform"=>"solaris-10u9-64", "upgrade_version"=>"legacy"
89	verify_basic_upgrade	"platform"=>"freebsd-9-64", "upgrade_version"=>"previous"
90	verify_basic_upgrade	"platform"=>"smartos-64", "upgrade_version"=>"previous"
358	verify_basic_upgrade	"platform"=>"smartos-64", "upgrade_version"=>"legacy"
359	verify_basic_upgrade	"platform"=>"osx-64", "upgrade_version"=>"legacy"
360	verify_basic_upgrade	"platform"=>"fedora-17-64", "upgrade_version"=>"legacy"
85	verify_basic_upgrade	"platform"=>"fedora-15-64", "max_version"=>"1.2.99", "upgrade_version"=>"previous"
361	verify_basic_upgrade	"platform"=>"fedora-15-64", "max_version"=>"1.2.99", "upgrade_version"=>"legacy"
362	verify_busy_dist_port	"platform"=>"ubuntu-1004-32"
363	verify_busy_dist_port	"platform"=>"ubuntu-1004-64"
364	verify_busy_dist_port	"platform"=>"ubuntu-1104-64"
365	verify_busy_dist_port	"platform"=>"ubuntu-1204-64"
366	verify_busy_dist_port	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
367	verify_busy_dist_port	"platform"=>"fedora-17-64"
368	verify_busy_dist_port	"platform"=>"centos-5-64"
369	verify_busy_dist_port	"platform"=>"centos-6-64"
370	verify_busy_dist_port	"platform"=>"solaris-10u9-64"
371	verify_busy_dist_port	"platform"=>"freebsd-9-64"
372	verify_busy_dist_port	"platform"=>"smartos-64"
373	verify_busy_dist_port	"platform"=>"osx-64"
374	verify_commit_hooks	"platform"=>"ubuntu-1004-32"
375	verify_commit_hooks	"platform"=>"ubuntu-1004-64"
376	verify_commit_hooks	"platform"=>"ubuntu-1104-64"
377	verify_commit_hooks	"platform"=>"ubuntu-1204-64"
378	verify_commit_hooks	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
379	verify_commit_hooks	"platform"=>"fedora-17-64"
380	verify_commit_hooks	"platform"=>"centos-5-64"
381	verify_commit_hooks	"platform"=>"centos-6-64"
382	verify_commit_hooks	"platform"=>"solaris-10u9-64"
383	verify_commit_hooks	"platform"=>"freebsd-9-64"
384	verify_commit_hooks	"platform"=>"smartos-64"
385	verify_commit_hooks	"platform"=>"osx-64"
386	client_python_verify	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-32"
387	client_python_verify	"backend"=>"eleveldb", "platform"=>"ubuntu-1004-64"
388	client_python_verify	"backend"=>"eleveldb", "platform"=>"ubuntu-1104-64"
389	client_python_verify	"backend"=>"eleveldb", "platform"=>"ubuntu-1204-64"
390	client_python_verify	"backend"=>"eleveldb", "platform"=>"fedora-15-64", "max_version"=>"1.2.99"
391	client_python_verify	"backend"=>"eleveldb", "platform"=>"fedora-17-64"
392	client_python_verify	"backend"=>"eleveldb", "platform"=>"centos-5-64"
393	client_python_verify	"backend"=>"eleveldb", "platform"=>"centos-6-64"
394	client_python_verify	"backend"=>"eleveldb", "platform"=>"solaris-10u9-64"
395	client_python_verify	"backend"=>"eleveldb", "platform"=>"freebsd-9-64"
396	client_python_verify	"backend"=>"eleveldb", "platform"=>"smartos-64"
397	client_python_verify	"backend"=>"eleveldb", "platform"=>"osx-64"
342	loaded_upgrade	"backend"=>"bitcask", "platform"=>"freebsd-9-64", "min_version"=>"1.4.0", "upgrade_version"=>"legacy"
343	loaded_upgrade	"backend"=>"eleveldb", "platform"=>"freebsd-9-64", "min_version"=>"1.4.0", "upgrade_version"=>"legacy"
357	verify_basic_upgrade	"platform"=>"freebsd-9-64", "min_version"=>"1.4.0", "upgrade_version"=>"legacy"
398	verify_backup_restore	"platform"=>"ubuntu-1004-32"
399	verify_backup_restore	"platform"=>"ubuntu-1004-64"
400	verify_backup_restore	"platform"=>"ubuntu-1104-64"
401	verify_backup_restore	"platform"=>"ubuntu-1204-64"
402	verify_backup_restore	"platform"=>"fedora-15-64", "max_version"=>"1.2.99"
403	verify_backup_restore	"platform"=>"fedora-17-64"
404	verify_backup_restore	"platform"=>"centos-5-64"
405	verify_backup_restore	"platform"=>"centos-6-64"
406	verify_backup_restore	"platform"=>"solaris-10u9-64"
407	verify_backup_restore	"platform"=>"freebsd-9-64"
408	verify_backup_restore	"platform"=>"smartos-64"
409	verify_backup_restore	"platform"=>"osx-64"
\.


--
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tests_id_seq', 409, true);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: scorecards_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY scorecards
    ADD CONSTRAINT scorecards_pkey PRIMARY KEY (id);


--
-- Name: test_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY test_results
    ADD CONSTRAINT test_results_pkey PRIMARY KEY (id);


--
-- Name: tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: index_projects_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_name ON projects USING btree (name);


--
-- Name: index_projects_tests_on_project_id_and_test_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_tests_on_project_id_and_test_id ON projects_tests USING btree (project_id, test_id);


--
-- Name: index_scorecards_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_scorecards_on_project_id ON scorecards USING btree (project_id);


--
-- Name: index_test_results_on_scorecard_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_test_results_on_scorecard_id ON test_results USING btree (scorecard_id);


--
-- Name: index_tests_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tests_on_name ON tests USING btree (name);


--
-- Name: tests_tags_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX tests_tags_index ON tests USING gin (tags);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

