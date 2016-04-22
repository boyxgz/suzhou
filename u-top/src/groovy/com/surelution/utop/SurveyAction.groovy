/**
 * 
 */
package com.surelution.utop

import com.surelution.whistle.core.NewsAttribute

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class SurveyAction extends JxBaseAction {

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		isMenu("key_survey")
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		def title = KeyedMessage.findByKey("survey-title")?.message
		def description = KeyedMessage.findByKey("survey-description")?.message
		def na = new NewsAttribute()
		na.add(title, description, "http://${rootPath}/images/survey.jpg", "http://${rootPath}/wxPortal/s/${subscriber.openId}")
		put(na)
	}

}
