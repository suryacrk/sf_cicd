/**
 * @description Tests for SampleCiCdService. Covers every line and branch: 09-29 8:30 PM
 * null/blank inputs, single-record DML, bulk DML (200 records) and SOQL.
 * A unique name prefix keeps the tests independent of existing org data.
 */
@isTest
private class SampleCiCdTest {

    private static final String PREFIX = 'zzCICD ';

    @TestSetup
    static void setup() {
        insert new List<Account>{
            new Account(Name = PREFIX + 'Setup One'),
            new Account(Name = PREFIX + 'Setup Two')
        };
    }

    @isTest
    static void testAdd() {
        Assert.areEqual(5, SampleCiCdService.add(2, 3), 'Should add two numbers');
        Assert.areEqual(0, SampleCiCdService.add(null, 3), 'Null first arg returns 0');
        Assert.areEqual(0, SampleCiCdService.add(2, null), 'Null second arg returns 0');
        Assert.areEqual(0, SampleCiCdService.add(null, null), 'Both null returns 0');
    }

    @isTest
    static void testClassifyNumber() {
        Assert.areEqual('UNKNOWN', SampleCiCdService.classifyNumber(null));
        Assert.areEqual('NEGATIVE', SampleCiCdService.classifyNumber(-5));
        Assert.areEqual('ZERO', SampleCiCdService.classifyNumber(0));
        Assert.areEqual('POSITIVE', SampleCiCdService.classifyNumber(10));
    }

    @isTest
    static void testFormatGreeting() {
        Assert.areEqual('Hello, Guest!', SampleCiCdService.formatGreeting(null));
        Assert.areEqual('Hello, Guest!', SampleCiCdService.formatGreeting(''));
        Assert.areEqual('Hello, Guest!', SampleCiCdService.formatGreeting('   '));
        Assert.areEqual('Hello, Ajay!', SampleCiCdService.formatGreeting('  Ajay '));
    }

    @isTest
    static void testCreateAccountsHandlesEmptyInput() {
        Assert.areEqual(0, SampleCiCdService.createAccounts(null).size(), 'null list');
        Assert.areEqual(0, SampleCiCdService.createAccounts(new List<String>()).size(), 'empty list');
        Assert.areEqual(
            0,
            SampleCiCdService.createAccounts(new List<String>{ ' ', null }).size(),
            'all-blank names must not trigger DML'
        );
    }

    @isTest
    static void testCreateAccountsSkipsBlankNames() {
        Test.startTest();
        List<Account> created = SampleCiCdService.createAccounts(
            new List<String>{ PREFIX + 'Bulk A', ' ', null, ' ' + PREFIX + 'Bulk B ' }
        );
        Test.stopTest();

        Assert.areEqual(2, created.size(), 'Blank and null names should be skipped');
        Assert.areEqual(2, SampleCiCdService.countAccountsByPrefix(PREFIX + 'Bulk'));
    }

    @isTest
    static void testCreateAccountsBulk() {
        List<String> names = new List<String>();
        for (Integer i = 0; i < 200; i++) {
            names.add(PREFIX + 'Mass ' + i);
        }

        Test.startTest();
        List<Account> created = SampleCiCdService.createAccounts(names);
        Test.stopTest();

        Assert.areEqual(200, created.size(), 'All 200 accounts should be created');
        Assert.areEqual(200, SampleCiCdService.countAccountsByPrefix(PREFIX + 'Mass'));
    }

    @isTest
    static void testCountAccountsByPrefix() {
        Assert.areEqual(0, SampleCiCdService.countAccountsByPrefix(null), 'null prefix');
        Assert.areEqual(0, SampleCiCdService.countAccountsByPrefix(''), 'empty prefix');
        Assert.areEqual(
            2,
            SampleCiCdService.countAccountsByPrefix(PREFIX + 'Setup'),
            'Should find the 2 accounts from @TestSetup'
        );
        Assert.areEqual(0, SampleCiCdService.countAccountsByPrefix('No Such Prefix'));
    }
}
