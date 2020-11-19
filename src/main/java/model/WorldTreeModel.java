package model;

import epistemic.ManagedWorlds;
import epistemic.wrappers.NormalizedWrappedLiteral;

import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import java.util.Comparator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.TreeSet;
import java.util.stream.Collectors;

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

    public synchronized void refreshAgent() {
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

        for (var world : worlds) {

            var worldNode = new DefaultMutableTreeNode(world);
            // Sort by proposition toString().
            LinkedHashSet<String> sortedPropositions = world.stream()
                    .map(l -> l.getCleanedLiteral().toString())
                    .sorted(Comparator.comparing(l -> l))
                    .collect(Collectors.toCollection(LinkedHashSet::new));

            for (var prop : sortedPropositions) {
                worldNode.add(new DefaultMutableTreeNode(prop));
            }

            //
            worldNode.setUserObject(sortedPropositions);

            root.add(worldNode);
        }

        root.setUserObject("All Worlds (" + worlds.size() + ")");

        this.reload();

    }


}
