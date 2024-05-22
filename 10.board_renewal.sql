create table author (
    id int auto_increment,
    name varchar(255),
    email varchar(255) not null unique,
    password varchar(255),
    created_time datetime default current_timestamp,
    PRIMARY KEY (id)
);

create table post (
    id int auto_increment,
    title varchar(255) not null,
    contents varchar(255),
    PRIMARY KEY (id)
);

create table author_address (
    id int auto_increment,
    city varchar(255),
    street varchar(255),
    author_id int not null unique,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) references author(id) on delete cascade
);

create table author_post (
    id int auto_increment,
    author_id int not null unique,
    post_id int not null unique,
    PRIMARY KEY (id),
    FOREIGN KEY (author_id) references author(id),
    FOREIGN KEY (post_id) references post(id)
);
