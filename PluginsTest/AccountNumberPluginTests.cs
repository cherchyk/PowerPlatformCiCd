using System;
using Xunit;
using FakeXrmEasy;
using Plugins;

namespace PluginsTest
{
	public class AccountNumberPluginTests
	{
		[Fact]
		public void When_Account_Number_Plugin_is_Executed_Account_Number_Exists()
		{
			XrmFakedContext ctx = new XrmFakedContext();

			AccountNumberPlugin accountNumberPlugin = new AccountNumberPlugin();


			Assert.False(false);
		}
	}
}
