package model;

import epistemic.agent.EpistemicAgent;
import epistemic.distribution.EpistemicDistribution;
import jason.JasonException;
import org.jetbrains.annotations.Nullable;

public class MockAgent extends EpistemicAgent {

    private EpistemicDistribution epistemicDistribution;

    public MockAgent(String aslFile) {
        try {
            this.initAg();
            this.load(aslFile);
        } catch (JasonException e) {
            e.printStackTrace();
        }
    }

    /**
     * Clones the functionality of the super method, but does not call distribution.loaded()
     * so that we do not send the model to the server
     */
    @Override
    protected void agentLoaded() {
        getLogger().info("Epistemic framework initialized. Creating Epistemic Distribution:");

        // Create the distribution after loading the agent successfully
        this.epistemicDistribution = super.getDistributionBuilder().createDistribution(this);

        // This will wrap the BB with a chained epistemic BB now that the distribution is set.
        this.setBB(this.getBB());

        logger.info("Mock agent does not send model to server");
    }

    /**
     * @return The current EpistemicDistribution. This will return null before {@link EpistemicAgent#agentLoaded()} is called.
     */
    @Nullable
    public EpistemicDistribution getEpistemicDistribution() {
        return this.epistemicDistribution;
    }
}
