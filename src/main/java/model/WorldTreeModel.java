package model;

import epistemic.ManagedWorlds;

import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;

public class WorldTreeModel extends DefaultTreeModel {
    private MockAgent mockAgent;
    private final DefaultMutableTreeNode root;
    public WorldTreeModel() {
        this(new DefaultMutableTreeNode("All Worlds"));
    }

    private WorldTreeModel(DefaultMutableTreeNode root) {
        super(root);
        this.root = root;
        refreshAgent();
    }

    public synchronized void refreshAgent()
    {
        removeChildren();
        this.mockAgent = new MockAgent("example.asl");
        buildTree();
    }

    private void removeChildren() {
        root.removeAllChildren();
        this.reload(root);
    }

    private void buildTree() {
        System.out.println("Rebuilding Worlds Tree");
        ManagedWorlds worlds = this.mockAgent.getEpistemicDistribution().getManagedWorlds();

        for(var world : worlds)
        {


            var worldNode = new DefaultMutableTreeNode(world);
            for(var prop : world)
            {
                worldNode.add(new DefaultMutableTreeNode(prop.getCleanedLiteral()));
            }

            root.add(worldNode);
        }

        root.setUserObject("All Worlds (" + worlds.size() + ")");

        this.reload();

    }



}
