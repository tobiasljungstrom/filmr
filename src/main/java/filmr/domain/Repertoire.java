package filmr.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import javax.persistence.*;
import java.util.Set;
import java.util.TreeSet;

@Entity
public class Repertoire {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

 // updating movie list is done through PUT /api/reperoires/{id}/?add_movie_with_id&remove_movie_with_id
    @ManyToMany
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private Set<Movie> movies;

    public Long getId() {
        return id;
    }

    public Set<Movie> getMovies() {
        if (movies == null) {
            movies = new TreeSet<>();
        }
        return movies;
    }

    public void setMovies(Set<Movie> movies) {
        this.movies = new TreeSet<Movie>(movies);
    }
    
    @Override
    public boolean equals(Object object){
        if (object == null) {
            return false;
        }
        if(!(object instanceof Repertoire)){
            return false;
        }
        final Repertoire repertoire = (Repertoire)object;
        return new EqualsBuilder()
                .append(id,repertoire.getId())
                .append(movies,repertoire.getMovies())
                .isEquals();

    }
    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 31)
                .append(id)
                .append(movies)
                .toHashCode();
    }
}
