import jason.util.Config;
import model.WorldTreeModel;

import javax.swing.*;
import java.awt.*;

public class WorldVisualizerView extends JFrame {
    private final JTree tree;
    private final WorldTreeModel treeModel;

    public WorldVisualizerView()
    {
        super("World Visualizer");
        this.setLayout(new BoxLayout(this.getContentPane(), BoxLayout.Y_AXIS));


        treeModel = new WorldTreeModel();
        tree = new JTree(treeModel);
        tree.setScrollsOnExpand(true);

        JScrollPane scrollPane = new JScrollPane(tree);
        this.add(scrollPane);


        JPanel evaluationPanel = new JPanel();
        JButton reloadASlButton = new JButton("Reload example.asl");
        reloadASlButton.addActionListener((a) -> {
            treeModel.refreshAgent();
        });
        evaluationPanel.add(reloadASlButton);
        this.add(evaluationPanel);
        scrollPane.setPreferredSize(new Dimension(500, 500));
        this.setVisible(true);
        this.pack();

        evaluationPanel.setMinimumSize(evaluationPanel.getPreferredSize());
        evaluationPanel.setMaximumSize(evaluationPanel.getPreferredSize());

        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
    }

    public static void main(String[] args)
    {
        // Disable Jason web server
        Config.get().setProperty(Config.START_WEB_MI, "false");
        new WorldVisualizerView();
    }
}
