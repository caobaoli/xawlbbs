package xyz.springabc.domin;
// Generated 2015-11-14 18:40:02 by Hibernate Tools 4.3.1.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Field generated by hbm2java
 */
@Entity
@Table(name = "field", catalog = "spring_winds")
public class Field implements java.io.Serializable {
	private static final long serialVersionUID = -1421578549422893784L;
	private Integer id;
	private Property property;
	private String content;
	private String meta;

	public Field() {
	}

	public Field(Property property, String content, String meta) {
		this.property = property;
		this.content = content;
		this.meta = meta;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "property_id", nullable = false)
	public Property getProperty() {
		return this.property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	@Column(name = "content", nullable = false)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "meta", nullable = false)
	public String getMeta() {
		return this.meta;
	}

	public void setMeta(String meta) {
		this.meta = meta;
	}


	
}
