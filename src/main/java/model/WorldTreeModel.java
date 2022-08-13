package model;

import epistemic.ManagedWorlds;
import epistemic.World;

import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import java.util.*;
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

        List<World> worldList = new ArrayList<>(worlds);
        Map<World, LinkedHashSet<String>> sortedPropositionsMap = new HashMap<>();

        worldList.sort(Collections.reverseOrder(Comparator.comparing((world) -> {
            LinkedHashSet<String> sortedPropositions = sortedPropositionsMap.get(world);

            if (sortedPropositions == null)
                sortedPropositions = world.getValuation().stream()
                        .map(l -> l.getCleanedLiteral().toString())
                        .sorted(Comparator.comparing(l -> l))
                        .collect(Collectors.toCollection(LinkedHashSet::new));


            sortedPropositionsMap.putIfAbsent(world, sortedPropositions);
            return sortedPropositions.toString();
        })));

        for (var world : worldList) {
//
//            if(!world.evaluate(ASSyntax.createLiteral("cards", ASSyntax.createString("Bob"), ASSyntax.createString("AA"))))
//                continue;

            var worldNode = new DefaultMutableTreeNode(world);
            // Sort by proposition toString().
            var sortedPropositions = sortedPropositionsMap.get(world);

            for (var prop : sortedPropositions) {
                worldNode.add(new DefaultMutableTreeNode(prop));
            }

            //
            worldNode.setUserObject(sortedPropositions);

            root.add(worldNode);
        }

        root.setUserObject("All Worlds (" + worlds.size() + ")");

        // Print worlds to string
        var rootIter = root.breadthFirstEnumeration().asIterator();
        while (rootIter.hasNext())
            System.out.println(rootIter.next().toString());

        this.reload();

    }


}
