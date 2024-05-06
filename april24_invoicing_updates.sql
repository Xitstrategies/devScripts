use fp_TTI;

/**
 * This script will set the Notes(special_comments) on invoices produced for this months invoices.
 * It will also set the boilerplates for the customer profiles, based on the invoices that have been produced.
 *
 * office_code_id
 * TYO - 21319
 * LYS - 20170
 * BL3 - 1
 * HKG - 3
 * SHA - 6
 * TPE - 8
 * TIFFA - 21730
 * INDITECH - 9
 */

SET @invoice_date = date(date_format(now(), '%Y-%m-01')) - interval 1 day;

-- USD to EUR :: 36
update fp_TTI.GL_Header
set special_comments = 'This statement is for services from 04/01/2024 through 04/30/2024.
Due Date April 30, 2024
Exchange rate used: European Central Bank, April 29, 2024 (Exchange rate closing) 1.072

Notice:  Payments 60 days past due will result in automatic account suspension with a $250.00 reinstatement charge.
Reinstatement will not occur until payment has been received in our office.'
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and EXISTS (select 1 from fp_TTI.Fgl where GL_Header.gl_header_id = Fgl.gl_header_id and Fgl.detail_currency != GL_Header.currency and (Fgl.detail_currency = 'EUR' or GL_Header.currency = 'EUR'))
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'LYS-HQ');

-- THB :: 2 invoices
update fp_TTI.GL_Header
set special_comments = 'This statement is for services from 04/01/2024 through 04/30/2024.
Exchange rate used: Bank of Thailand April 29, 2024 (Exchange Rate Closing) 37.038
Due Date April 30, 2024

Notice:  Payments 60 days past due will result in automatic account suspension with a $250.00 reinstatement charge.
Reinstatement will not occur until payment has been received in our office.'
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and EXISTS (select 1 from fp_TTI.Fgl where GL_Header.gl_header_id = Fgl.gl_header_id and Fgl.detail_currency != GL_Header.currency and (Fgl.detail_currency = 'THB' or GL_Header.currency = 'THB'))
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TIFFA' and account_suffix = 'BKK-HQ');

-- CAD :: 0 invoices
update fp_TTI.GL_Header
set special_comments = 'This statement is for services from 04/01/2024 through 04/30/2024.
Exchange rate used: Bank of Canada April 29, 2024 (Exchange Rate Closing) 1.3668
Due Date April 30, 2024

Notice:  Payments 60 days past due will result in automatic account suspension with a $250.00 reinstatement charge.
Reinstatement will not occur until payment has been received in our office.'
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= '2024-01-01' -- @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and EXISTS (select 1 from fp_TTI.Fgl where GL_Header.gl_header_id = Fgl.gl_header_id and Fgl.detail_currency != GL_Header.currency and (Fgl.detail_currency = 'CAD' or GL_Header.currency = 'CAD'))
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'BL3-HQ');

/*
-- CNY :: 0 invoices
update fp_TTI.GL_Header
set special_comments = ''
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and EXISTS (select 1 from fp_TTI.Fgl where GL_Header.gl_header_id = Fgl.gl_header_id and Fgl.detail_currency != GL_Header.currency and (Fgl.detail_currency = 'CNY' or GL_Header.currency = 'CNY'))
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'SHA-HQ');

-- HKD :: 0 invoices
update fp_TTI.GL_Header
set special_comments = ''
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and EXISTS (select 1 from fp_TTI.Fgl where GL_Header.gl_header_id = Fgl.gl_header_id and Fgl.detail_currency != GL_Header.currency and (Fgl.detail_currency = 'HKD' or GL_Header.currency = 'HKD'))
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'HKG-HQ');
*/

-- JPY :: 31 invoices
update fp_TTI.GL_Header
set special_comments = 'This statement is for services from 04/01/2024 through 04/30/2024.
Due Date April 30, 2024
Exchange rate used: Bank of Japan April 29, 2024 (Exchange Rate Closing) 156.70

Notice:  Payments 60 days past due will result in automatic account suspension with a $250.00 reinstatement charge.
Reinstatement will not occur until payment has been received in our office.'
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and EXISTS (select 1 from fp_TTI.Fgl where GL_Header.gl_header_id = Fgl.gl_header_id and Fgl.detail_currency != GL_Header.currency and (Fgl.detail_currency = 'JPY' or GL_Header.currency = 'JPY'))
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'TYO-HQ');

-- all line items match header :: 170
update fp_TTI.GL_Header
set special_comments = 'This statement is for services from 04/01/2024 through 04/30/2024.
Due Date April 30, 2024

Notice:  Payments 60 days past due will result in automatic account suspension with a $250.00 reinstatement charge.
Reinstatement will not occur until payment has been received in our office.'
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and NOT EXISTS (select 1 from fp_TTI.Fgl where GL_Header.gl_header_id = Fgl.gl_header_id and Fgl.detail_currency != GL_Header.currency)
and GL_Header.office_code_id in (select uid from fp_TTI.ttacct where (account_code = 'TTI' and account_suffix in ( 'LYS-HQ', 'BL3-HQ', 'TYO-HQ' )) or account_code = 'TIFFA');

-- AMC/Norbert :: 2
update fp_TTI.GL_Header
set special_comments = 'Cette declaration couvre nos prestations pour la pÈriode du 01/04/2024 au 30/04/2024.
 rËglement: 30 jours date de facture, soit ‡ rÈgler au Avril 30, 2024.

Important : Tout facture echue a 60 jours fera líobjet díune suspension de compte automatique.
La reactivation du compte ne pourra avoir lieu quía reception du reglement et sera facturee 250 USD.'
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and GL_Header.vendorcust_id in (16587, 17683);

-- JASF qualifier invoices :: 225
update fp_TTI.GL_Header
set special_comments = 'Invoice is available for payment approval via the JAS TOL
Trade Tech netting code is: USTTI'
where GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.status != 'Voided'
and GL_Header.printed_date = '0000-00-00'
and GL_Header.vendorcust_id in (select ttacct.uid from fp_TTI.ttacct where ttacct.billing_qualifier != 'JASF');

SET @LYS_USD_boilerplateId = (select gl_bp_id from fp_TTI.GL_Boilerplate where bp_title like 'Lyon USD%');
SET @LYS_EUR_boilerplateId = (select gl_bp_id from fp_TTI.GL_Boilerplate where bp_title like 'Lyon EUR%');
SET @BL3_USD_EN_boilerplateId = (select gl_bp_id from fp_TTI.GL_Boilerplate where bp_title like 'Banner%English');
SET @BL3_USD_FR_boilerplateId = (select gl_bp_id from fp_TTI.GL_Boilerplate where bp_title like 'Banner%French');
SET @TYO_boilerplateId = (select gl_bp_id from fp_TTI.GL_Boilerplate where bp_title = 'Japan - YEN');

-- LYS USD :: dup
insert into fp_TTI.Profile_Location_Boilerplates (profile_location_id, gl_bp_id)
(select Profile_Location.profile_location_id, @LYS_USD_boilerplateId
from fp_TTI.GL_Header
left outer join fp_TTI.Profile_Location on GL_Header.vendorcust_id = Profile_Location.data_source_record
left outer join fp_TTI.Profile_Location_Boilerplates on Profile_Location.profile_location_id = Profile_Location_Boilerplates.profile_location_id
where GL_Header.vendorcust_id = Profile_Location.data_source_record -- data_source_record is the ttacct.uid
and GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.currency = 'USD'
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'LYS-HQ')
and Profile_Location_Boilerplates.profile_location_boilerplate_id is null
group by 1,2);

-- LYS EUR
insert into fp_TTI.Profile_Location_Boilerplates (profile_location_id, gl_bp_id)
(select Profile_Location.profile_location_id, @LYS_EUR_boilerplateId
from fp_TTI.GL_Header
left outer join fp_TTI.Profile_Location on GL_Header.vendorcust_id = Profile_Location.data_source_record
left outer join fp_TTI.Profile_Location_Boilerplates on Profile_Location.profile_location_id = Profile_Location_Boilerplates.profile_location_id
where GL_Header.vendorcust_id = Profile_Location.data_source_record -- data_source_record is the ttacct.uid
and GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.currency = 'EUR'
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'LYS-HQ')
and Profile_Location_Boilerplates.profile_location_boilerplate_id is null
group by 1,2);

-- BL3 English
insert into fp_TTI.Profile_Location_Boilerplates (profile_location_id, gl_bp_id)
(select Profile_Location.profile_location_id, @BL3_USD_EN_boilerplateId
from fp_TTI.GL_Header
left outer join fp_TTI.Profile_Location on GL_Header.vendorcust_id = Profile_Location.data_source_record
left outer join fp_TTI.Profile_Location_Boilerplates on Profile_Location.profile_location_id = Profile_Location_Boilerplates.profile_location_id
where GL_Header.vendorcust_id = Profile_Location.data_source_record -- data_source_record is the ttacct.uid
and GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.currency = 'USD'
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'BL3-HQ')
and GL_Header.vendorcust_id not in (select ttacct.uid from fp_TTI.ttacct where ttacct.billing_qualifier = 'JASF')
and Profile_Location_Boilerplates.profile_location_boilerplate_id is null
group by 1,2);

-- BL3 French, AMC/Norbert
insert into fp_TTI.Profile_Location_Boilerplates (profile_location_id, gl_bp_id)
(select Profile_Location.profile_location_id, @BL3_USD_FR_boilerplateId
from fp_TTI.Profile_Location
left outer join fp_TTI.Profile_Location_Boilerplates on Profile_Location.profile_location_id = Profile_Location_Boilerplates.profile_location_id
where Profile_Location.data_source_record in (16587, 17683)
and Profile_Location_Boilerplates.profile_location_boilerplate_id is null
group by 1,2);

-- TYO
insert into fp_TTI.Profile_Location_Boilerplates (profile_location_id, gl_bp_id)
(select Profile_Location.profile_location_id, @TYO_boilerplateId
from fp_TTI.GL_Header
left outer join fp_TTI.Profile_Location on GL_Header.vendorcust_id = Profile_Location.data_source_record
left outer join fp_TTI.Profile_Location_Boilerplates on Profile_Location.profile_location_id = Profile_Location_Boilerplates.profile_location_id
where GL_Header.vendorcust_id = Profile_Location.data_source_record -- data_source_record is the ttacct.uid
and GL_Header.screen = 'INVOICE'
and GL_Header.invoice_date >= @invoice_date
and GL_Header.currency = 'JPY'
and GL_Header.office_code_id = (select uid from fp_TTI.ttacct where account_code = 'TTI' and account_suffix = 'TYO-HQ')
and Profile_Location_Boilerplates.profile_location_boilerplate_id is null
group by 1,2);

