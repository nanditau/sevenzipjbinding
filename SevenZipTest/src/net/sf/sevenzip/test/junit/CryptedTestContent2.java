package net.sf.sevenzip.test.junit;

public class CryptedTestContent2 extends StandardTest {

	@Override
	protected int getTestId() {
		return 2;
	}

	@Override
	protected boolean usingPassword() {
		return true;
	}

}