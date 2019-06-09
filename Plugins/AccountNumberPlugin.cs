using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Xrm.Sdk;

namespace Plugins
{
	/// <summary>
	/// The plug-in creates a task activity after a new account is created. The activity reminds the user to
	/// follow-up with the new account customer one week after the account was created.
	/// </summary>
	/// <remarks>Register this plug-in on the Create message, account entity, and asynchronous mode.
	/// </remarks>

	public sealed class AccountNumberPlugin : IPlugin
	{
		/// <summary>
		/// Execute method that is required by the IPlugin interface.
		/// </summary>
		/// <param name="serviceProvider">The service provider from which you can obtain the
		/// tracing service, plug-in execution context, organization service, and more.</param>
		public void Execute(IServiceProvider serviceProvider)
		{
			//Extract the tracing service for use in debugging sandboxed plug-ins.
			ITracingService tracingService = (ITracingService)serviceProvider.GetService(typeof(ITracingService));

			// Obtain the execution context from the service provider.
			IPluginExecutionContext context = (IPluginExecutionContext)serviceProvider.GetService(typeof(IPluginExecutionContext));

			// The InputParameters collection contains all the data passed in the message request.
			if (!(context.InputParameters.Contains("Target") && context.InputParameters["Target"] is Entity))
			{
				return;
			}

			// Obtain the target entity from the input parameters.
			Entity entity = (Entity)context.InputParameters["Target"];

			// Verify that the target entity represents an account.
			// If not, this plug-in was not registered correctly.
			if (entity.LogicalName != "account")
			{
				return;
			}

			//An accountnumber attribute should not already exist because
			//it is system generated.
			if (entity.Attributes.Contains("accountnumber"))
			{
				throw new InvalidPluginExecutionException(
					"An accountnumber attribute should not already exist because it is system generated.");
			}
			else
			{
				Random random = new Random();
				entity.Attributes.Add("accountnumber", random.Next().ToString());
			}

		}
	}
}