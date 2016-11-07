package index;

import java.io.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Simon Buchholz on 02.11.2016.
 */
public class InvertedIndex implements Serializable {

    private String word;
    private Map<String, Integer> microServices;

    public InvertedIndex(String word, String serviceName, int occurrence) {
        this.word = word;
        this.microServices = new HashMap<>();
        this.microServices.put(serviceName, occurrence);
    }

    public void put(String serviceName, int occurrence) {
        microServices.put(serviceName,occurrence);
    }

    public void remove(String serviceName) {
        // TODO
        microServices.remove(serviceName);
    }

    private static List<String> stopwords = Arrays.asList("a", "able", "about",
            "across", "after", "all", "almost", "also", "am", "among", "an",
            "and", "any", "are", "as", "at", "be", "because", "been", "but",
            "by", "can", "cannot", "could", "dear", "did", "do", "does",
            "either", "else", "ever", "every", "for", "from", "get", "got",
            "had", "has", "have", "he", "her", "hers", "him", "his", "how",
            "however", "i", "if", "in", "into", "is", "it", "its", "just",
            "least", "let", "like", "likely", "may", "me", "might", "most",
            "must", "my", "neither", "no", "nor", "not", "of", "off", "often",
            "on", "only", "or", "other", "our", "own", "rather", "said", "say",
            "says", "she", "should", "since", "so", "some", "than", "that",
            "the", "their", "them", "then", "there", "these", "they", "this",
            "tis", "to", "too", "twas", "us", "wants", "was", "we", "were",
            "what", "when", "where", "which", "while", "who", "whom", "why",
            "will", "with", "would", "yet", "you", "your");

    public static Map<String, Integer> indexText(String text) {
        Map<String, Integer> index = new HashMap<String, Integer>();

        for (String _word : text.split("\\W+")) {
            String word = _word.toLowerCase();
            if (stopwords.contains(word))
                continue;

            Integer idx = index.get(word);
            if (idx == null) {
                index.put(word, new Integer(1));
            } else {
                idx = idx + 1;
                index.remove(word);
                index.put(word, idx);
            }
        }
        return index;
    }

    @Override
    public String toString() {
        return "index.InvertedIndex{" +
                "word='" + word + '\'' +
                ", microServices=" + microServices +
                '}';
    }

    public String getWord() {
        return word;
    }

    public Map<String, Integer> getMicroServices() {
        return microServices;
    }
}