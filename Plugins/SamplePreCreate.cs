using Microsoft.Xrm.Sdk;
using System;


namespace Plugins
{
	[CrmPluginRegistration(MessageNameEnum.Create, "ms_sample", StageEnum.PreOperation, ExecutionModeEnum.Synchronous, "", "ms_sample_PreCreate", 1, IsolationModeEnum.Sandbox)]
	public class SamplePreCreate : IPlugin
	{
		public void Execute(IServiceProvider serviceProvider)
		{
			//throw new NotImplementedException();
		}
	}
}