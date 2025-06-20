import java.util.Arrays;
import java.util.Comparator;

public class SearchUtil {

    public static Product linearSearch(Product[] products, int productId) {
        for (Product p : products) {
            if (p.getProductId() == productId) {
                return p;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, int productId) {
        int low = 0;
        int high = products.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            int midId = products[mid].getProductId();

            if (midId == productId) {
                return products[mid];
            } else if (midId < productId) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null;
    }

    public static void sortProductsById(Product[] products) {
        Arrays.sort(products, Comparator.comparingInt(Product::getProductId));
    }
}
