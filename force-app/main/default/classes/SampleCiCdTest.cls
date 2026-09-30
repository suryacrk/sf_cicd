/**
 * @description Tests for SampleCiCdService. Covers every branch, including
 * null/blank inputs, single-record and bulk (200 record) DML.
 */
@isTest
private class SampleCiCdTest {

    @TestSetup
    static void setup() {
        insert new List<Account>{
            new Account(Name = 'CICD Setup One'),
            new Account(Name = 'CICD Setup Two')
        };
    }

    @isTest
    static void testAdd() {
        Assert.areEqual(5, SampleCiCdService.add(2, 3), 'Should add two numbers');
        Assert.areEqual(0, SampleCiCdService.add(null, 3), 'Null first arg returns 0');
        Assert.areEqual(0, SampleCiCdService.add(2, null), 'Null second arg returns 0');
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
        Assert.areEqual('Hello, Guest!', SampleCiCdService.formatGreeting('   '));
        Assert.areEqual('Hello, Ajay!', SampleCiCdService.formatGreeting('  Ajay '));
    }

    @isTest
    static void testCreateAccountsHandlesEmptyInput() {
        Assert.areEqual(0, SampleCiCdService.createAccounts(null).size());
        Assert.areEqual(0, SampleCiCdService.createAccounts(new List<String>()).size());
        Assert.areEqual(0, SampleCiCdService.createAccounts(new List<String>{ ' ', null }).size());
    }

    @isTest
    static void testCreateAccountsSkipsBlankNames() {
        Test.startTest();
        List<Account> created = SampleCiCdService.createAccounts(
            new List<String>{ 'CICD Bulk A', ' ', null, ' CICD Bulk B ' }
        );
        Test.stopTest();

        Assert.areEqual(2, created.size(), 'Blank and null names should be skipped');
        Assert.areEqual(2, SampleCiCdService.countAccountsByPrefix('CICD Bulk'));
    }

    @isTest
    static void testCreateAccountsBulk() {
        List<String> names = new List<String>();
        for (Integer i = 0; i < 200; i++) {
            names.add('CICD Mass ' + i);
        }

        Test.startTest();
        List<Account> created = SampleCiCdService.createAccounts(names);
        Test.stopTest();

        Assert.areEqual(200, created.size(), 'All 200 accounts should be created');
        Assert.areEqual(200, SampleCiCdService.countAccountsByPrefix('CICD Mass'));
    }

    @isTest
    static void testCountAccountsByPrefix() {
        Assert.areEqual(0, SampleCiCdService.countAccountsByPrefix(null));
        Assert.areEqual(0, SampleCiCdService.countAccountsByPrefix(''));
        Assert.areEqual(2, SampleCiCdService.countAccountsByPrefix('CICD Setup'),
            'Should find the 2 accounts from @TestSetup');
        Assert.areEqual(0, SampleCiCdService.countAccountsByPrefix('No Such Prefix'));
    }
}
